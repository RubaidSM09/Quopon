import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:quopon/app/modules/vendor_create_deal/views/deal_publish_view.dart';

import '../../../../common/deliveryCostForm.dart';
import '../../../data/base_client.dart';
import '../../../data/model/menu_item.dart';

class VendorCreateDealController extends GetxController {
  final RxInt selectedMenuId = 0.obs;
  final RxList<String> menuNames = <String>[].obs;     // e.g. ["Breakfast", ...]
  final RxMap<String, int> nameToId = <String, int>{}.obs; // e.g. {"Breakfast": 1}
  final RxString selectedMenuName = 'Choose a menu item'.obs;
  void setMenuId(int id) => selectedMenuId.value = id;

  final RxList<String> discounts = <String>['5%','10%','15%','20%','25%','30%','35%','40%','45%','50%'].obs;     // e.g. ["Breakfast", ...]
  final RxString selectedDiscount = '5%'.obs;

  final Rxn<File> imageFile = Rxn<File>();
  void setImageFile(File? file) => imageFile.value = file;

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final maxCuoponController = TextEditingController();
  final maxCuoponPerCustomerController = TextEditingController();
  final zipCodeController = TextEditingController();
  final deliveryFeeController = TextEditingController();
  final minOrderAmountController = TextEditingController();

  final RxList<String> redemptionTypes = <String>['Pickup','Delivery','Pickup & Delivery'].obs;
  final RxString selectedRedemptionType = 'Pickup'.obs;

  var isChecked = false.obs;
  void toggleCheckbox(bool value) => isChecked.value = value;

  // 🔹 minimal extra state to carry what the API needs (provide defaults if your UI isn’t wired yet)
  final RxInt linkedMenuItemId = 0.obs;            // set from "Linked Menu Item" dropdown when wired
  final RxString startDateIso = ''.obs;            // set from Start Date picker as ISO string
  final RxString endDateIso = ''.obs;              // set from End Date picker as ISO string

  // setters you can call from widgets (optional wiring)
  void setLinkedMenu(int id) => linkedMenuItemId.value = id;
  void setStartDateIso(String v) => startDateIso.value = v;
  void setEndDateIso(String v) => endDateIso.value = v;

  @override
  void onInit() {
    super.onInit();
    fetchMenuCategories(); // load on screen open
  }

  /// GET /vendors/categories/  (uses BaseClient.getRequest)
  Future<void> fetchMenuCategories() async {
    try {
      final userId = await BaseClient.getUserId();
      if (userId == null || userId.isEmpty) {
        throw 'User ID not found. Please log in again.';
      }
      final headers = await BaseClient.authHeaders();

      final res = await BaseClient.getRequest(
        api: 'http://10.10.13.99:8090/vendors/deals/',
        params: {'user_id': userId},
        headers: headers,
      );

      // unify handling (throws on error codes)
      final data = await BaseClient.handleResponse(res) as List<dynamic>;

      // shape: [{ "id": 1, "category_title": "..." }, ...]
      final localMap = <String, int>{};
      final localNames = <String>[];

      for (final item in data) {
        final id = item['id'] as int;
        final name = (item['title'] ?? '').toString();
        if (name.isNotEmpty) {
          localMap[name] = id;
          localNames.add(name);
        }
      }

      nameToId.assignAll(localMap);
      menuNames.assignAll(localNames);

      // default selection if empty/unchosen
      if (selectedMenuName.value == 'Choose a menu item' && menuNames.isNotEmpty) {
        selectedMenuName.value = menuNames.first;
        selectedMenuId.value = nameToId[selectedMenuName.value] ?? 0;
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  // Add this small mapper anywhere inside the controller:
  String _mapRedemption(String uiValue) {
    switch (uiValue) {
      case 'Pickup':
        return 'PICKUP';
      case 'Delivery':
        return 'DELIVERY';
      case 'Pickup & Delivery':
        return 'BOTH';
      default:
        return 'BOTH';
    }
  }

  /// POST /vendors/create-deals/
  Future<void> createDeal() async {
    try {
      final headers = await BaseClient.authHeaders();

      final title = titleController.text.trim();
      final description = descriptionController.text.trim();
      if (title.isEmpty || description.isEmpty) {
        throw 'Title and description are required.';
      }

      // ✅ image is required by the API
      if (imageFile.value == null) {
        throw 'Please select an image.';
      }

      // Upload image to get the URL
      final imageUrl = await uploadImage(imageFile.value!, headers);

      final maxTotal = int.tryParse(maxCuoponController.text.trim()) ?? 0;
      final maxPerCustomer =
          int.tryParse(maxCuoponPerCustomerController.text.trim()) ?? 0;

      final now = DateTime.now();
      final start = startDateIso.isNotEmpty ? startDateIso.value : now.toIso8601String();
      final end = endDateIso.isNotEmpty ? endDateIso.value : now.add(const Duration(days: 7)).toIso8601String();

      // Build delivery_costs from your DeliveryCostForm rows
      final dcController = Get.find<DeliveryCostController>();
      final deliveryCosts = dcController.deliveryCosts.map((row) {
        final zip = row.zipCodeController.text.trim();
        final fee = row.deliveryFeeController.text.trim();
        final min = row.minOrderController.text.trim();
        return {
          'zip_code': zip.isEmpty ? '0000' : zip,
          'delivery_fee': fee.isEmpty ? '0.00' : fee,
          'min_order_amount': min.isEmpty ? '0.00' : min,
        };
      }).toList();

      final body = <String, dynamic>{
        'linked_menu_item': selectedMenuId.value,            // ✅ your selected menu id
        'discount_value': selectedDiscount.value.replaceAll('%', '').trim(),
        'title': title,
        'description': description,
        'image': imageUrl,                                // ✅ now using the uploaded image URL
        'start_date': start,
        'end_date': end,
        'redemption_type': _mapRedemption(selectedRedemptionType.value), // ✅ API format
        'max_coupons_total': maxTotal,
        'delivery_costs': deliveryCosts,
      };

      if (maxPerCustomer > 0) {
        body['max_coupons_per_customer'] = maxPerCustomer;
      }

      print(body);

      final res = await BaseClient.postRequest(
        api: 'http://10.10.13.99:8090/vendors/create-deals/',
        headers: headers,
        body: json.encode(body),
      );

      if (res.statusCode == 200 || res.statusCode == 201) {
        final resBody = jsonDecode(res.body);
        final dealId = resBody['id'];

        await BaseClient.handleResponse(res);
        Get.snackbar('Success', 'Deal created successfully');

        Get.dialog(DealPublishView(dealId: dealId,));
      }
      else {
        final resBody = jsonDecode(res.body);
        Get.snackbar('Deal creation failed', resBody['message'] ?? 'Please give correct information');
      }
    } catch (e) {
      print('Error => ${e.toString()}');
      Get.snackbar('Error', e.toString());
    }
  }

  // Helper method to upload image and return URL
  Future<String> uploadImage(File imageFile, Map<String, String> headers) async {
    try {
      final uri = Uri.parse('http://10.10.13.99:8090/vendors/upload/');
      final req = http.MultipartRequest('POST', uri)..headers.addAll(headers);

      // File
      final file = imageFile;
      if (await file.exists()) {
        req.files.add(await http.MultipartFile.fromPath('image', file.path));
      }

      // Send
      final streamed = await req.send();
      final resp = await http.Response.fromStream(streamed);

      if (resp.statusCode >= 200 && resp.statusCode <= 210) {
        print(resp.statusCode);

        final responseJson = json.decode(resp.body);
        return responseJson['image']; // Adjust based on your API response
      } else {
        throw 'Image upload failed with status code ${resp.statusCode}';
      }
    } catch (e) {
      throw 'Image upload error: ${e.toString()}';
    }
  }
}

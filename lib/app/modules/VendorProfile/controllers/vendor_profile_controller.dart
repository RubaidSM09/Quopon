import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:quopon/app/data/model/menu.dart';

import '../../../data/api.dart';
import '../../../data/base_client.dart';
import '../../../data/model/menu_item.dart';
import '../../vendor_deals/controllers/vendor_deals_controller.dart';

class Deal {
  final String dealImg;
  final String dealTitle;
  final String dealDescription;
  final String dealValidity;

  Deal({
    required this.dealImg,
    required this.dealTitle,
    required this.dealDescription,
    required this.dealValidity,
  });
}

class VendorProfileController extends GetxController {
  var deals = <DealItem>[].obs;

  final RxList<RxBool> isOptionsSelected = [false.obs, false.obs].obs;
  RxDouble total_price = 0.00.obs;
  // var items = <Item>[].obs;

  // Loading & error
  final RxBool loading = false.obs;
  final RxString error = ''.obs;

  // categoryTitle -> List<MenuItem>
  final RxMap<String, List<MenuItem>> menusByCategory = <String, List<MenuItem>>{}.obs;

  // Fetch deals from the API
  Future<void> fetchDeals(int id) async {
    try {
      final headers = await BaseClient.authHeaders();

      // Fetch the deals
      final response = await http.get(
        Uri.parse('https://intensely-optimal-unicorn.ngrok-free.app/vendors/create-deals/?user_id=$id'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List<dynamic>;
        // Convert JSON response to a list of DealItem objects
        deals.assignAll(data.map((deal) => DealItem.fromJson(deal)).toList());
      } else {
        throw 'Failed to fetch deals';
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> fetchMenus(int id) async {
    loading.value = true;
    error.value = '';
    menusByCategory.clear();

    try {
      final headers = await BaseClient.authHeaders();
      final res = await BaseClient.getRequest(
        api: 'https://intensely-optimal-unicorn.ngrok-free.app/vendors/deals/',
        params: {'user_id': id.toString()},
        headers: headers,
      );

      final data = await BaseClient.handleResponse(res);

      final List<MenuItem> items = (data as List)
          .map((e) => MenuItem.fromJson(e as Map<String, dynamic>))
          .toList();

      final map = <String, List<MenuItem>>{};
      for (final mi in items) {
        final catTitle = (mi.category.categoryTitle).isNotEmpty
            ? mi.category.categoryTitle
            : 'Uncategorized';
        map.putIfAbsent(catTitle, () => <MenuItem>[]);
        map[catTitle]!.add(mi);
      }

      menusByCategory.assignAll(map);
    } catch (e) {
      error.value = e.toString();
    } finally {
      loading.value = false;
    }
  }

  /*Future<void> toggleOption(int menuId, int itemId, bool addedToCart, int optionId, bool isSelected) async {
    try {
      String? accessToken = await BaseClient.getAccessToken();

      Map<String, String> headers = {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      };

      // Call the API to get the categories
      final response = await BaseClient.patchRequest(
        api: Api.menuPatch(menuId),
        body: {
          "item_id": itemId,
          "added_to_cart": addedToCart,
          "option_id": optionId,
          "is_selected": isSelected
        },
        headers: headers,);

      // Decode the response body from JSON
      final decodedResponse = json.decode(response.body);

      // print(response.statusCode);

      // Check if the response contains categories
      if (decodedResponse != null && decodedResponse is List) {
        // Map the response to Category objects and update the list
        menu.value = decodedResponse
            .map((menuJson) => Menu.fromJson(menuJson))
            .toList();
      } else {
        print('No categories found or incorrect response format.');
      }
    } catch (e) {
      print('Error fetching categories: $e');
      // Handle error appropriately (e.g., show a Snackbar or error message)
    }
  }*/

  @override
  void onInit() {
    super.onInit();
  }
}

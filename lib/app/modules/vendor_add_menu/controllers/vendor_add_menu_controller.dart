import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../data/base_client.dart';

class VendorAddMenuController extends GetxController {
  // Reactive holders for inputs coming from the view
  final Rxn<File> imageFile = Rxn<File>();
  final RxInt selectedCategoryId = 0.obs;
  final RxList<int> selectedModifierGroupIds = <int>[].obs;

  // 🔹 Dynamic categories from API
  final RxList<String> categoryNames = <String>[].obs;     // e.g. ["Breakfast", ...]
  final RxMap<String, int> nameToId = <String, int>{}.obs; // e.g. {"Breakfast": 1}
  final RxString selectedCategoryName = 'Select'.obs;

  void setImageFile(File? file) => imageFile.value = file;
  void setCategoryId(int id) => selectedCategoryId.value = id;
  void setModifierGroups(List<int> ids) {
    selectedModifierGroupIds
      ..clear()
      ..addAll(ids);
  }

  @override
  void onInit() {
    super.onInit();
    fetchMenuCategories(); // load on screen open
  }

  /// GET /vendors/categories/  (uses BaseClient.getRequest)
  Future<void> fetchMenuCategories() async {
    try {
      final headers = await BaseClient.authHeaders();

      final res = await BaseClient.getRequest(
        api: 'http://10.10.13.52:7000/vendors/categories/',
        headers: headers,
      );

      // unify handling (throws on error codes)
      final data = await BaseClient.handleResponse(res) as List<dynamic>;

      // shape: [{ "id": 1, "category_title": "..." }, ...]
      final localMap = <String, int>{};
      final localNames = <String>[];

      for (final item in data) {
        final id = item['id'] as int;
        final name = (item['category_title'] ?? '').toString();
        if (name.isNotEmpty) {
          localMap[name] = id;
          localNames.add(name);
        }
      }

      nameToId.assignAll(localMap);
      categoryNames.assignAll(localNames);

      // default selection if empty/unchosen
      if (selectedCategoryName.value == 'Select' && categoryNames.isNotEmpty) {
        selectedCategoryName.value = categoryNames.first;
        selectedCategoryId.value = nameToId[selectedCategoryName.value] ?? 0;
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  /// POST /vendors/deals/  (multipart)
  /// Note: BaseClient has no multipart helper, so we use MultipartRequest,
  /// but still leverage BaseClient.authHeaders() and handleResponse() for consistency.
  Future<void> addMenu({
    required String title,
    required String description,
    required String price,
    int? overrideCategoryId,
    List<int>? overrideModifierGroups,
  }) async {
    try {
      print(imageFile.value!.path);

      // Auth headers
      final headers = await BaseClient.authHeaders();
      // Let MultipartRequest set its own content-type with boundary
      headers.remove('Content-Type');

      final uri = Uri.parse('http://10.10.13.52:7000/vendors/deals/');
      final req = http.MultipartRequest('POST', uri)..headers.addAll(headers);

      String? userId = await BaseClient.getUserId();
      print(userId);

      // Fields
      req.fields['title'] = title;
      req.fields['description'] = description;
      req.fields['price'] = price;

      final cid = overrideCategoryId ?? selectedCategoryId.value;
      req.fields['category_id'] = (cid == 0 ? 1 : cid).toString();

      final mg = overrideModifierGroups ?? selectedModifierGroupIds.toList();
      // if backend expects JSON array in multipart field:
      req.fields['modifier_groups'] = "1";

      req.fields['user'] = userId as String;
      // if backend expects CSV, use: req.fields['modifier_groups'] = mg.join(',');

      // File
      final file = imageFile.value;
      if (file != null && await file.exists()) {
        req.files.add(await http.MultipartFile.fromPath('image', file.path));
      }

      // Send
      final streamed = await req.send();
      final resp = await http.Response.fromStream(streamed);

      // Use unified handler for success/error
      await BaseClient.handleResponse(resp);

      Get.snackbar('Success', 'Menu item created successfully');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}

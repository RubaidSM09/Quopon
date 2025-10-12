import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../data/base_client.dart';

/// ===== Models backing the Modifiers UI (API-aligned) =====
class ModifierOption {
  final TextEditingController nameController;   // -> options[].title
  final TextEditingController priceController;  // -> options[].Price (double? / null)

  ModifierOption({String? name, String? price})
      : nameController = TextEditingController(text: name ?? ''),
        priceController = TextEditingController(text: price ?? '');

  /// API expects:
  /// { "title": "<option name>", "Price": 2.50 | null }
  Map<String, dynamic> toJson() => {
    "title": nameController.text.trim(),
    "Price": _parsePriceOrNull(priceController.text),
  };

  static double? _parsePriceOrNull(String raw) {
    final s = raw.trim();
    if (s.isEmpty) return null; // free
    // accept "free", "FREE" etc.
    if (s.toLowerCase() == 'free') return null;
    // accept inputs like "1", "1.2", "$ 1.20"
    final cleaned = s.replaceAll(RegExp(r'[^0-9\.-]'), '');
    if (cleaned.isEmpty) return null;
    try {
      return double.parse(cleaned);
    } catch (_) {
      return null;
    }
  }
}

class ModifierGroup {
  final TextEditingController nameController;   // -> modifiers[].name
  final RxBool isRequired;                      // -> modifiers[].is_required
  final RxList<ModifierOption> options;         // -> modifiers[].options

  ModifierGroup({
    String? name,
    bool required = false,
    List<ModifierOption>? opts,
  })  : nameController = TextEditingController(text: name ?? ''),
        isRequired = required.obs,
        options = (opts ?? [ModifierOption()]).obs;

  /// API expects:
  /// { "name": "<modifier name>", "is_required": true/false, "options": [...] }
  Map<String, dynamic> toJson() => {
    "name": nameController.text.trim(),
    "is_required": isRequired.value,
    "options": options.map((e) => e.toJson()).toList(),
  };
}

class VendorAddMenuController extends GetxController {
  // Reactive holders for inputs coming from the view
  final Rxn<File> imageFile = Rxn<File>();
  final RxInt selectedCategoryId = 0.obs;

  // 🔹 Dynamic categories from API
  final RxList<String> categoryNames = <String>[].obs;     // ["Breakfast", ...]
  final RxMap<String, int> nameToId = <String, int>{}.obs; // {"Breakfast": 1}
  final RxString selectedCategoryName = 'Select'.obs;

  // 🔹 Modifiers state (starts with one empty group)
  final RxList<ModifierGroup> modifiers = <ModifierGroup>[ModifierGroup()].obs;

  void setImageFile(File? file) => imageFile.value = file;
  void setCategoryId(int id) => selectedCategoryId.value = id;

  // --- Modifiers helpers ---
  void addModifier() => modifiers.add(ModifierGroup());
  void addOption(int modifierIndex) =>
      modifiers[modifierIndex].options.add(ModifierOption());

  @override
  void onInit() {
    super.onInit();
    fetchMenuCategories();
  }

  /// GET /vendors/categories/
  Future<void> fetchMenuCategories() async {
    try {
      final headers = await BaseClient.authHeaders();

      final res = await BaseClient.getRequest(
        api: 'http://10.10.13.99:8090/vendors/categories/',
        headers: headers,
      );

      final data = await BaseClient.handleResponse(res) as List<dynamic>;

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

      if (selectedCategoryName.value == 'Select' && categoryNames.isNotEmpty) {
        selectedCategoryName.value = categoryNames.first;
        selectedCategoryId.value = nameToId[selectedCategoryName.value] ?? 0;
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  /// Build JSON payload for modifiers (API keys)
  List<Map<String, dynamic>> _buildModifiersPayload() {
    final List<Map<String, dynamic>> payload = [];
    for (final g in modifiers) {
      final name = g.nameController.text.trim();
      if (name.isEmpty) continue; // skip empty modifier

      final opts = g.options
          .where((o) => o.nameController.text.trim().isNotEmpty)
          .map((o) => o.toJson())
          .toList();

      payload.add({
        "name": name,
        "is_required": g.isRequired.value,
        "options": opts,
      });
    }
    return payload;
  }

  /// POST /vendors/deals/  (multipart)
  /// BODY (as fields + file):
  ///  title, description, price, image(file), category_id (int), modifiers (json)
  Future<void> addMenu({
    required String title,
    required String description,
    required String price,
    int? overrideCategoryId,
  }) async {
    try {
      final headers = await BaseClient.authHeaders();
      // Multipart must set its own boundary
      headers.remove('Content-Type');

      final uri = Uri.parse(
          'http://10.10.13.99:8090/vendors/deals/');
      final req = http.MultipartRequest('POST', uri)..headers.addAll(headers);

      // Fields
      req.fields['title'] = title;
      req.fields['description'] = description;
      req.fields['price'] = price;

      final cid = overrideCategoryId ?? selectedCategoryId.value;
      req.fields['category_id'] = (cid == 0 ? 1 : cid).toString();

      // include modifiers JSON using API’s exact keys
      final modifiersJson = jsonEncode(_buildModifiersPayload());
      req.fields['modifiers'] = modifiersJson;

      // Image file
      final file = imageFile.value;
      if (file != null && await file.exists()) {
        req.files.add(await http.MultipartFile.fromPath('image', file.path));
      }

      // Send
      final streamed = await req.send();
      final resp = await http.Response.fromStream(streamed);

      await BaseClient.handleResponse(resp);
      Get.snackbar('Success', 'Menu item created successfully');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}

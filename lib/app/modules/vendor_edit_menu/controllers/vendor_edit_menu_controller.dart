import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../data/base_client.dart';
// Reuse the models from Add controller
import '../../vendor_add_menu/controllers/vendor_add_menu_controller.dart'
    show ModifierGroup, ModifierOption;

class VendorEditMenuController extends GetxController {
  VendorEditMenuController({required this.menuId});
  final int menuId;

  // originals to compute minimal PATCH
  String _origTitle = '';
  String _origDescription = '';
  String _origPrice = '';
  int _origCategoryId = 0;
  String _origImageUrl = '';
  String _origModifiersJson = '[]';

  // form fields
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();

  // image
  final Rxn<File> imageFile = Rxn<File>();
  final RxString existingImageUrl = ''.obs;

  // categories
  final RxList<String> categoryNames = <String>[].obs;
  final RxMap<String, int> nameToId = <String, int>{}.obs;
  final RxString selectedCategoryName = 'Select'.obs;
  final RxInt selectedCategoryId = 0.obs;

  // modifiers
  final RxList<ModifierGroup> modifiers = <ModifierGroup>[].obs;

  // state
  final loading = false.obs;
  final saving = false.obs;
  final error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchMenuCategories().then((_) => loadMenu(menuId));
  }

  void setImageFile(File? f) => imageFile.value = f;

  Future<void> fetchMenuCategories() async {
    try {
      final headers = await BaseClient.authHeaders();
      final res = await BaseClient.getRequest(
        api: 'https://doctorless-stopperless-turner.ngrok-free.dev/vendors/categories/',
        headers: headers,
      );
      final data = await BaseClient.handleResponse(res) as List<dynamic>;

      final localMap = <String, int>{};
      final localNames = <String>[];

      for (final item in data) {
        final id = item['id'] as int? ?? 0;
        final name = (item['category_title'] ?? '').toString();
        if (id > 0 && name.isNotEmpty) {
          localMap[name] = id;
          localNames.add(name);
        }
      }

      nameToId.assignAll(localMap);
      categoryNames.assignAll(localNames);
    } catch (e) {
      error.value = 'Failed to load categories: $e';
    }
  }

  Future<void> loadMenu(int id) async {
    loading.value = true;
    error.value = '';
    try {
      final headers = await BaseClient.authHeaders();
      headers['ngrok-skip-browser-warning'] = 'true';

      final res = await http.get(
        Uri.parse('https://doctorless-stopperless-turner.ngrok-free.dev/vendors/deals/$id/'),
        headers: headers,
      );
      if (res.statusCode < 200 || res.statusCode >= 300) {
        error.value = 'Failed to load menu (${res.statusCode})';
        return;
      }

      final jsonMap = json.decode(res.body) as Map<String, dynamic>;
      final title = (jsonMap['title'] ?? '').toString();
      final description = (jsonMap['description'] ?? '').toString();
      final price = (jsonMap['price'] ?? '0').toString();

      final category = (jsonMap['category'] as Map<String, dynamic>? ?? {});
      final cid = category['id'] is int
          ? category['id'] as int
          : int.tryParse('${category['id']}') ?? 0;

      final imageAbsolute = (jsonMap['logo_image'] ?? '').toString(); // server returns absolute url
      final modifiersJson = (jsonMap['modifiers'] as List<dynamic>? ?? <dynamic>[]);

      // fill UI
      titleController.text = title;
      descriptionController.text = description;
      priceController.text = price;
      existingImageUrl.value = imageAbsolute;

      _origCategoryId = cid;
      if (cid != 0 && nameToId.isNotEmpty) {
        final match = nameToId.entries.firstWhereOrNull((e) => e.value == cid);
        if (match != null) {
          selectedCategoryName.value = match.key;
          selectedCategoryId.value = match.value;
        } else {
          selectedCategoryName.value = 'Select';
          selectedCategoryId.value = 0;
        }
      }

      // prefill modifiers
      modifiers.clear();
      if (modifiersJson.isNotEmpty) {
        for (final g in modifiersJson) {
          final m = g as Map<String, dynamic>;
          final name = (m['name'] ?? '').toString();
          final req = m['is_required'] == true;
          final optionsList = (m['options'] as List<dynamic>? ?? <dynamic>[])
              .whereType<Map<String, dynamic>>()
              .map((opt) => ModifierOption(
            name: (opt['title'] ?? '').toString(),
            price: _stringFromPrice(opt['Price']),
          ))
              .toList();
          modifiers.add(ModifierGroup(name: name, required: req, opts: optionsList));
        }
      } else {
        modifiers.add(ModifierGroup());
      }

      // originals for diff
      _origTitle = title;
      _origDescription = description;
      _origPrice = price;
      _origImageUrl = imageAbsolute;
      _origModifiersJson = jsonEncode(_buildModifiersPayload());
    } catch (e) {
      error.value = 'Error loading menu: $e';
    } finally {
      loading.value = false;
    }
  }

  static String? _stringFromPrice(dynamic v) {
    if (v == null) return null;
    if (v is num) return v.toString();
    final s = v.toString();
    return (s.isEmpty || s.toLowerCase() == 'none') ? null : s;
    // keep it as controller text format, actual parsing is in ModifierOption.toJson()
  }

  List<Map<String, dynamic>> _buildModifiersPayload() {
    final List<Map<String, dynamic>> payload = [];
    for (final g in modifiers) {
      final name = g.nameController.text.trim();
      if (name.isEmpty) continue;
      final opts = g.options
          .where((o) => o.nameController.text.trim().isNotEmpty)
          .map((o) => o.toJson())
          .toList();
      payload.add({
        'name': name,
        'is_required': g.isRequired.value,
        'options': opts,
      });
    }
    return payload;
  }

  Map<String, String> _diffTextFields() {
    final Map<String, String> fields = {};
    final newTitle = titleController.text.trim();
    final newDesc = descriptionController.text.trim();
    final newPrice = priceController.text.trim();
    final newCategoryId = selectedCategoryId.value;

    if (newTitle.isNotEmpty && newTitle != _origTitle) fields['title'] = newTitle;
    if (newDesc.isNotEmpty && newDesc != _origDescription) fields['description'] = newDesc;
    if (newPrice.isNotEmpty && newPrice != _origPrice) fields['price'] = newPrice;
    if (newCategoryId != 0 && newCategoryId != _origCategoryId) {
      fields['category_id'] = newCategoryId.toString();
    }

    final currentModsJson = jsonEncode(_buildModifiersPayload());
    if (currentModsJson != _origModifiersJson) {
      fields['modifiers'] = currentModsJson;
    }
    return fields;
  }

  /// PATCH /vendors/deals/$menuId/
  Future<bool> patchMenu() async {
    if (saving.value) return false;
    saving.value = true;
    try {
      final headers = await BaseClient.authHeaders();
      headers.remove('Content-Type'); // multipart boundary is set automatically

      final uri = Uri.parse(
          'https://doctorless-stopperless-turner.ngrok-free.dev/vendors/deals/$menuId/');
      final req = http.MultipartRequest('PATCH', uri)..headers.addAll(headers);

      final diff = _diffTextFields();
      diff.forEach((k, v) => req.fields[k] = v);

      final file = imageFile.value;
      if (file != null && await file.exists()) {
        req.files.add(await http.MultipartFile.fromPath('image', file.path));
      }

      if (req.fields.isEmpty && req.files.isEmpty) {
        Get.snackbar('No changes', 'Nothing to update.');
        return true;
      }

      final streamed = await req.send();
      final resp = await http.Response.fromStream(streamed);
      if (resp.statusCode >= 200 && resp.statusCode < 300) {
        Get.snackbar('Success', 'Menu updated');
        return true;
      } else {
        Get.snackbar('Error', 'Update failed (${resp.statusCode})\n${resp.body}');
        return false;
      }
    } catch (e) {
      Get.snackbar('Error', 'Update failed: $e');
      return false;
    } finally {
      saving.value = false;
    }
  }
}

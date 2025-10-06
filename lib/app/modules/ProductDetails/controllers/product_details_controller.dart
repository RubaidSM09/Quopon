import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:quopon/app/data/base_client.dart';
import 'package:quopon/app/data/model/menu_item.dart';

class ProductDetailsController extends GetxController {
  // running total: base + selected option prices
  final RxDouble totalPrice = 0.0.obs;

  // per-modifier selection: key = modifierIndex, value = selected option index (or null if none selected)
  final RxMap<int, int?> selectedByModifier = <int, int?>{}.obs;

  // local cache of modifiers for validation & payload
  List<Modifier> _modifiers = const <Modifier>[];
  double _basePrice = 0.0;
  bool initialized = false;

  void init({required double basePrice, required List<Modifier> modifiers}) {
    if (initialized) return;
    initialized = true;

    _basePrice = basePrice;
    _modifiers = modifiers;

    totalPrice.value = _basePrice;

    // initialize map with null selections
    for (int i = 0; i < _modifiers.length; i++) {
      selectedByModifier[i] = null;
    }
  }

  void selectOption({
    required int modifierIndex,
    required int optionIndex,
    required double? optionPrice,
  }) {
    // single-select per modifier: just set the chosen index
    selectedByModifier[modifierIndex] = optionIndex;

    // recalc total
    double sum = _basePrice;
    for (final entry in selectedByModifier.entries) {
      final mi = entry.key;
      final idx = entry.value;
      if (idx == null) continue;
      final price = _modifiers[mi].options[idx].price;
      if (price != null) sum += price;
    }
    totalPrice.value = sum;
  }

  /// List of required modifier names that are still unselected
  List<String> validateRequiredSelections() {
    final missing = <String>[];
    for (int i = 0; i < _modifiers.length; i++) {
      final m = _modifiers[i];
      if (m.isRequired && (selectedByModifier[i] == null)) {
        missing.add(m.name);
      }
    }
    return missing;
  }

  /// POST /order/cart/add/
  /// BODY:
  /// {
  ///   "menu_item_id": <id>,
  ///   "quantity": <n>,
  ///   "selected_modifiers": [
  ///     { "group_name": "<modifier name>", "selected_options": ["<option title>"] }
  ///   ]
  /// }
  Future<bool> addToCart({
    required int menuItemId,
    required int quantity,
    required String specialInstructions, // not used by backend, kept to preserve call site
  }) async {
    try {
      // Build selected_modifiers payload
      final List<Map<String, dynamic>> selected = [];
      for (int i = 0; i < _modifiers.length; i++) {
        final mod = _modifiers[i];
        final idx = selectedByModifier[i];

        // Optional modifiers without a selection are omitted
        if (idx == null) {
          continue;
        }

        final opt = mod.options[idx];
        selected.add({
          "group_name": mod.name,
          "selected_options": [opt.title], // backend expects array of strings
        });
      }

      final body = {
        "menu_item_id": menuItemId,
        "quantity": quantity,
        "selected_modifiers": selected,
      };

      // Headers
      final headers = await BaseClient.authHeaders();
      headers['Content-Type'] = 'application/json';

      final uri = Uri.parse(
          'https://intensely-optimal-unicorn.ngrok-free.app/order/cart/add/');

      final resp = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(body),
      );

      // Use your unified handler (throws on non-2xx)
      await BaseClient.handleResponse(resp);

      Get.snackbar('Added', 'Item added to cart');
      return true;
    } catch (e) {
      Get.snackbar('Error', e.toString());
      return false;
    }
  }
}

import 'package:get/get.dart';
import 'package:quopon/app/data/model/menu_item.dart';

class ProductDetailsController extends GetxController {
  // running total: base + selected option prices
  final RxDouble totalPrice = 0.0.obs;

  // per-modifier selection: key = modifierIndex, value = selected option index (or null if none selected)
  final RxMap<int, int?> selectedByModifier = <int, int?>{}.obs;

  // local cache of modifiers for validation
  List<Modifier> _modifiers = const <Modifier>[];
  double _basePrice = 0.0;
  bool initialized = false;

  void init({required double basePrice, required List<Modifier> modifiers}) {
    if (initialized) return;
    initialized = true;

    _basePrice = basePrice;
    _modifiers = modifiers;

    // start with base price only
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

  /// Stub to match your previous usage; extend to include selected modifiers payload if needed.
  Future<bool> addToCart({
    required int menuItemId,
    required int quantity,
    required String specialInstructions,
  }) async {
    // If you want to send selected modifiers to backend cart, build payload here:
    // final selections = <Map<String, dynamic>>[];
    // for (int i = 0; i < _modifiers.length; i++) {
    //   final idx = selectedByModifier[i];
    //   if (idx == null) continue;
    //   final opt = _modifiers[i].options[idx];
    //   selections.add({"name": _modifiers[i].name, "title": opt.title, "Price": opt.price});
    // }
    // await ...POST to your cart endpoint.

    // For now, just succeed.
    return true;
  }
}

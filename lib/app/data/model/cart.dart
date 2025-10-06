// lib/app/data/model/cart.dart
class Cart {
  final int id;
  final int totalItems;
  final List<Items> items;

  /// Adapter so old UI keeps working:
  final PriceSummary priceSummary;

  Cart({
    required this.id,
    required this.totalItems,
    required this.items,
    required this.priceSummary,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    double _num(dynamic v) {
      if (v == null) return 0.0;
      if (v is num) return v.toDouble();
      return double.tryParse(v.toString()) ?? 0.0;
    }

    final itemsJson = (json['items'] as List? ?? []);
    final items = itemsJson.map((e) => Items.fromJson(e as Map<String, dynamic>)).toList();

    final summary = PriceSummary(
      subTotalPrice: _num(json['subtotal']),
      deliveryCharges: _num(json['delivery_fee']),
      totalDiscount: _num(json['total_discount']),
      inTotalPrice: _num(json['final_total']),
    );

    return Cart(
      id: json['id'] ?? 0,
      totalItems: json['total_items'] ?? items.length,
      items: items,
      priceSummary: summary,
    );
  }
}

class PriceSummary {
  final double subTotalPrice;
  final double deliveryCharges;
  final double totalDiscount;
  final double inTotalPrice;

  PriceSummary({
    required this.subTotalPrice,
    required this.deliveryCharges,
    required this.totalDiscount,
    required this.inTotalPrice,
  });
}

/// ----------------- NEW: Modifiers in cart -----------------
class CartModifierGroup {
  final String name;
  final bool isRequired;
  final List<CartSelection> selections;

  CartModifierGroup({
    required this.name,
    required this.isRequired,
    required this.selections,
  });

  factory CartModifierGroup.fromJson(Map<String, dynamic> json) => CartModifierGroup(
    name: (json['name'] ?? '').toString(),
    isRequired: json['is_required'] == true,
    selections: (json['selections'] as List? ?? [])
        .map((e) => CartSelection.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

class CartSelection {
  final String title;
  /// API returns string numbers or "None"
  final String priceRaw; // keep raw to display per API ("1.2" or "None")

  CartSelection({
    required this.title,
    required this.priceRaw,
  });

  factory CartSelection.fromJson(Map<String, dynamic> json) => CartSelection(
    title: (json['title'] ?? '').toString(),
    priceRaw: (json['price'] ?? '').toString(),
  );

  /// Convenience: numeric price or null if "None"/empty
  double? get priceNum {
    final p = priceRaw.trim();
    if (p.isEmpty || p.toLowerCase() == 'none') return null;
    return double.tryParse(p);
  }
}
/// -----------------------------------------------------------

class Items {
  final int id;
  final int quantity;
  final String specialInstructions;
  final double itemTotal;

  // Flattened deal fields for Card UI
  final int dealId;
  final String title;
  final String description;
  final double unitPrice;
  final String image;

  // NEW: modifier groups on the cart item
  final List<CartModifierGroup> modifierGroups;

  // Optional extras (not strictly needed by UI, but handy)
  final double basePrice;
  final double modifiersPrice;

  Items({
    required this.id,
    required this.quantity,
    required this.specialInstructions,
    required this.itemTotal,
    required this.dealId,
    required this.title,
    required this.description,
    required this.unitPrice,
    required this.image,
    required this.modifierGroups,
    required this.basePrice,
    required this.modifiersPrice,
  });

  factory Items.fromJson(Map<String, dynamic> json) {
    final deal = (json['deal'] as Map<String, dynamic>? ?? const {});
    double _num(dynamic v) {
      if (v == null) return 0.0;
      if (v is num) return v.toDouble();
      return double.tryParse(v.toString()) ?? 0.0;
    }

    return Items(
      id: json['id'] ?? 0,
      quantity: json['quantity'] ?? 0,
      specialInstructions: (json['special_instructions'] ?? '').toString(),
      itemTotal: _num(json['item_total']),
      dealId: deal['id'] ?? 0,
      title: (deal['title'] ?? '').toString(),
      description: (deal['description'] ?? '').toString(),
      // Prefer unit_price if present; fall back to deal.price
      unitPrice: _num(json['unit_price'] ?? deal['price']),
      image: (deal['image'] ?? '').toString(),
      modifierGroups: (json['modifier_groups'] as List? ?? [])
          .map((e) => CartModifierGroup.fromJson(e as Map<String, dynamic>))
          .toList(),
      basePrice: _num(json['base_price']),
      modifiersPrice: _num(json['modifiers_price']),
    );
  }
}

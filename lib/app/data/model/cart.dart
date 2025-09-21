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
    // Backend sends numbers as strings — normalize safely
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

/// What your UI reads in Cart/CartBottom:
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
      unitPrice: _num(deal['price']),
      image: (deal['image'] ?? '').toString(),
    );
  }
}

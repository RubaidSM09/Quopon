import 'dart:convert';

Deal dealFromJson(String str) => Deal.fromJson(json.decode(str));

class Deal {
  final int id;
  final int userId;
  final String email;
  final int linkedMenuItem;
  final String title;
  final String description;
  final String imageUrl; // poster/brand image
  final String discountValue;
  final DateTime startDate;
  final DateTime endDate;
  final String redemptionType;
  final int maxCouponsTotal;
  final int maxCouponsPerCustomer;
  final List<DeliveryCost> deliveryCosts;
  final bool isActive;
  final String qrImage;

  Deal({
    required this.id,
    required this.userId,
    required this.email,
    required this.linkedMenuItem,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.discountValue,
    required this.startDate,
    required this.endDate,
    required this.redemptionType,
    required this.maxCouponsTotal,
    required this.maxCouponsPerCustomer,
    required this.deliveryCosts,
    required this.isActive,
    required this.qrImage,
  });

  factory Deal.fromJson(Map<String, dynamic> json) => Deal(
    id: json["id"],
    userId: json["user_id"],
    email: json["email"] ?? "",
    linkedMenuItem: json["linked_menu_item"],
    title: json["title"] ?? "",
    description: json["description"] ?? "",
    imageUrl: json["image_url"] ?? "",
    discountValue: json["discount_value"] ?? "0",
    startDate: DateTime.parse(json["start_date"]),
    endDate: DateTime.parse(json["end_date"]),
    redemptionType: json["redemption_type"] ?? "",
    maxCouponsTotal: json["max_coupons_total"] ?? 0,
    maxCouponsPerCustomer: json["max_coupons_per_customer"] ?? 0,
    deliveryCosts: (json["delivery_costs"] as List<dynamic>? ?? [])
        .map((e) => DeliveryCost.fromJson(e as Map<String, dynamic>))
        .toList(),
    isActive: json["is_active"] == true,
    qrImage: json["qrimage"] ?? "",
  );
}

class DeliveryCost {
  final String zipCode;
  final String deliveryFee;
  final String minOrderAmount;

  DeliveryCost({
    required this.zipCode,
    required this.deliveryFee,
    required this.minOrderAmount,
  });

  factory DeliveryCost.fromJson(Map<String, dynamic> json) => DeliveryCost(
    zipCode: json["zip_code"] ?? "",
    deliveryFee: json["delivery_fee"] ?? "0",
    minOrderAmount: json["min_order_amount"] ?? "0",
  );
}

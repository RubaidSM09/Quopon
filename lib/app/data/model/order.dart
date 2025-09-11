// To parse this JSON data, do
//
//     final order = orderFromJson(jsonString);

import 'dart:convert';

List<Order> orderFromJson(String str) => List<Order>.from(json.decode(str).map((x) => Order.fromJson(x)));

String orderToJson(List<Order> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Order {
  int id;
  String orderId;
  String productName;
  String price;
  String status;
  String orderType;
  DateTime createdAt;
  String productImageUrl;

  Order({
    required this.id,
    required this.orderId,
    required this.productName,
    required this.price,
    required this.status,
    required this.orderType,
    required this.createdAt,
    required this.productImageUrl,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["id"],
    orderId: json["order_id"],
    productName: json["product_name"],
    price: json["price"],
    status: json["status"],
    orderType: json["order_type"],
    createdAt: DateTime.parse(json["created_at"]),
    productImageUrl: json["product_image_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_id": orderId,
    "product_name": productName,
    "price": price,
    "status": status,
    "order_type": orderType,
    "created_at": createdAt.toIso8601String(),
    "product_image_url": productImageUrl,
  };
}

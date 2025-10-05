import 'dart:convert';

List<Order> orderFromJson(String str) => List<Order>.from(json.decode(str).map((x) => Order.fromJson(x)));

String orderToJson(List<Order> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Order {
  int id;
  String? orderId;
  int user;
  String? status;
  String? paymentStatus;
  String? deliveryType;
  String? orderType;
  dynamic scheduledDatetime;
  String? subtotal;
  String? deliveryFee;
  String? discountAmount;
  String? totalAmount;
  String? deliveryAddress;
  dynamic deliveryAddressLatitude;
  dynamic deliveryAddressLongitude;
  dynamic specialInstructions;
  String? note;
  dynamic estimatedDeliveryTime;
  List<Item> items;
  List<dynamic> appliedDeals;
  List<TrackingHistory> trackingHistory;
  DateTime createdAt;
  DateTime updatedAt;
  String? deliveryCode;
  bool deliveryCodeUsed;
  dynamic qrCode;

  Order({
    required this.id,
    this.orderId,
    required this.user,
    this.status,
    this.paymentStatus,
    this.deliveryType,
    this.orderType,
    this.scheduledDatetime,
    this.subtotal,
    this.deliveryFee,
    this.discountAmount,
    this.totalAmount,
    this.deliveryAddress,
    this.deliveryAddressLatitude,
    this.deliveryAddressLongitude,
    this.specialInstructions,
    this.note,
    this.estimatedDeliveryTime,
    required this.items,
    required this.appliedDeals,
    required this.trackingHistory,
    required this.createdAt,
    required this.updatedAt,
    this.deliveryCode,
    required this.deliveryCodeUsed,
    this.qrCode,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["id"] ?? 0,
    orderId: json["order_id"],
    user: json["user"] ?? 0,
    status: json["status"],
    paymentStatus: json["payment_status"],
    deliveryType: json["delivery_type"],
    orderType: json["order_type"],
    scheduledDatetime: json["scheduled_datetime"],
    subtotal: json["subtotal"],
    deliveryFee: json["delivery_fee"],
    discountAmount: json["discount_amount"],
    totalAmount: json["total_amount"],
    deliveryAddress: json["delivery_address"],
    deliveryAddressLatitude: json["delivery_address_latitude"],
    deliveryAddressLongitude: json["delivery_address_longitude"],
    specialInstructions: json["special_instructions"],
    note: json["note"],
    estimatedDeliveryTime: json["estimated_delivery_time"],
    items: List<Item>.from(json["items"]?.map((x) => Item.fromJson(x)) ?? []),
    appliedDeals: List<dynamic>.from(json["applied_deals"]?.map((x) => x) ?? []),
    trackingHistory: List<TrackingHistory>.from(json["tracking_history"]?.map((x) => TrackingHistory.fromJson(x)) ?? []),
    createdAt: DateTime.parse(json["created_at"] ?? DateTime.now().toIso8601String()),
    updatedAt: DateTime.parse(json["updated_at"] ?? DateTime.now().toIso8601String()),
    deliveryCode: json["delivery_code"],
    deliveryCodeUsed: json["delivery_code_used"] ?? false,
    qrCode: json["qr_code"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_id": orderId,
    "user": user,
    "status": status,
    "payment_status": paymentStatus,
    "delivery_type": deliveryType,
    "order_type": orderType,
    "scheduled_datetime": scheduledDatetime,
    "subtotal": subtotal,
    "delivery_fee": deliveryFee,
    "discount_amount": discountAmount,
    "total_amount": totalAmount,
    "delivery_address": deliveryAddress,
    "delivery_address_latitude": deliveryAddressLatitude,
    "delivery_address_longitude": deliveryAddressLongitude,
    "special_instructions": specialInstructions,
    "note": note,
    "estimated_delivery_time": estimatedDeliveryTime,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
    "applied_deals": List<dynamic>.from(appliedDeals.map((x) => x)),
    "tracking_history": List<dynamic>.from(trackingHistory.map((x) => x.toJson())),
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "delivery_code": deliveryCode,
    "delivery_code_used": deliveryCodeUsed,
    "qr_code": qrCode,
  };
}

class Item {
  int id;
  int deal;
  int quantity;
  String? unitPrice;
  String? totalPrice;
  String? itemName;
  String? itemDescription;
  String? itemImage;

  Item({
    required this.id,
    required this.deal,
    required this.quantity,
    this.unitPrice,
    this.totalPrice,
    this.itemName,
    this.itemDescription,
    this.itemImage,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"] ?? 0,
    deal: json["deal"] ?? 0,
    quantity: json["quantity"] ?? 0,
    unitPrice: json["unit_price"],
    totalPrice: json["total_price"],
    itemName: json["item_name"],
    itemDescription: json["item_description"],
    itemImage: json["item_image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "deal": deal,
    "quantity": quantity,
    "unit_price": unitPrice,
    "total_price": totalPrice,
    "item_name": itemName,
    "item_description": itemDescription,
    "item_image": itemImage,
  };
}

class TrackingHistory {
  int id;
  String? status;
  DateTime timestamp;
  String? note;

  TrackingHistory({
    required this.id,
    this.status,
    required this.timestamp,
    this.note,
  });

  factory TrackingHistory.fromJson(Map<String, dynamic> json) => TrackingHistory(
    id: json["id"] ?? 0,
    status: json["status"],
    timestamp: DateTime.parse(json["timestamp"] ?? DateTime.now().toIso8601String()),
    note: json["note"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "status": status,
    "timestamp": timestamp.toIso8601String(),
    "note": note,
  };
}
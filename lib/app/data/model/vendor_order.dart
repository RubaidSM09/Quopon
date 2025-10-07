class VendorOrder {
  int id;
  String orderId;
  int user;
  String status;
  String paymentStatus;
  String deliveryType;
  String orderType;
  String? scheduledDatetime;
  String subtotal;
  String deliveryFee;
  String discountAmount;
  String totalAmount;
  String? deliveryAddress;
  double? deliveryAddressLatitude;
  double? deliveryAddressLongitude;
  String? specialInstructions;
  String? note;
  String? estimatedDeliveryTime;
  List<OrderItem> items;
  List<dynamic> appliedDeals;
  List<TrackingHistory> trackingHistory;
  String createdAt;
  String updatedAt;
  String deliveryCode;
  bool deliveryCodeUsed;
  QrCode? qrCode;

  VendorOrder({
    required this.id,
    required this.orderId,
    required this.user,
    required this.status,
    required this.paymentStatus,
    required this.deliveryType,
    required this.orderType,
    this.scheduledDatetime,
    required this.subtotal,
    required this.deliveryFee,
    required this.discountAmount,
    required this.totalAmount,
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
    required this.deliveryCode,
    required this.deliveryCodeUsed,
    this.qrCode,
  });

  factory VendorOrder.fromJson(Map<String, dynamic> json) {
    return VendorOrder(
      id: json['id'],
      orderId: json['order_id'],
      user: json['user'],
      status: json['status'],
      paymentStatus: json['payment_status'],
      deliveryType: json['delivery_type'],
      orderType: json['order_type'],
      scheduledDatetime: json['scheduled_datetime'],
      subtotal: json['subtotal'],
      deliveryFee: json['delivery_fee'],
      discountAmount: json['discount_amount'],
      totalAmount: json['total_amount'],
      deliveryAddress: json['delivery_address'],
      deliveryAddressLatitude: json['delivery_address_latitude']?.toDouble(),
      deliveryAddressLongitude: json['delivery_address_longitude']?.toDouble(),
      specialInstructions: json['special_instructions'],
      note: json['note'],
      estimatedDeliveryTime: json['estimated_delivery_time'],
      items: (json['items'] as List).map((i) => OrderItem.fromJson(i)).toList(),
      appliedDeals: json['applied_deals'],
      trackingHistory: (json['tracking_history'] as List).map((i) => TrackingHistory.fromJson(i)).toList(),
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deliveryCode: json['delivery_code'],
      deliveryCodeUsed: json['delivery_code_used'],
      qrCode: json['qr_code'] != null ? QrCode.fromJson(json['qr_code']) : null,
    );
  }
}

class OrderItem {
  int id;
  int? deal; // Make deal nullable
  int quantity;
  String unitPrice;
  String totalPrice;
  String itemName;
  String itemDescription;
  String itemImage;

  OrderItem({
    required this.id,
    this.deal, // Update to nullable
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
    required this.itemName,
    required this.itemDescription,
    required this.itemImage,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'],
      deal: json['deal'], // This will now accept null
      quantity: json['quantity'],
      unitPrice: json['unit_price'],
      totalPrice: json['total_price'],
      itemName: json['item_name'],
      itemDescription: json['item_description'],
      itemImage: json['item_image'] ?? '', // Handle null item_image
    );
  }
}

class TrackingHistory {
  int id;
  String status;
  String timestamp;
  String note;

  TrackingHistory({
    required this.id,
    required this.status,
    required this.timestamp,
    required this.note,
  });

  factory TrackingHistory.fromJson(Map<String, dynamic> json) {
    return TrackingHistory(
      id: json['id'],
      status: json['status'],
      timestamp: json['timestamp'],
      note: json['note'],
    );
  }
}

class QrCode {
  int id;
  String data;
  String image;

  QrCode({
    required this.id,
    required this.data,
    required this.image,
  });

  factory QrCode.fromJson(Map<String, dynamic> json) {
    return QrCode(
      id: json['id'],
      data: json['data'],
      image: json['image'],
    );
  }
}
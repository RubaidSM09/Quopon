// lib/app/data/model/vendor_profile_lite.dart
class VendorProfileLite {
  final int vendorId;
  final String name;
  final String address; // string we’ll geocode

  VendorProfileLite({
    required this.vendorId,
    required this.name,
    required this.address,
  });

  factory VendorProfileLite.fromJson(Map<String, dynamic> json) {
    return VendorProfileLite(
      vendorId: json['vendor_id'] ?? 0,
      name: (json['name'] ?? '').toString(),
      address: (json['address'] ?? '').toString(),
    );
  }
}

// lib/app/data/model/deal_lite.dart
class DealLite {
  final int id;
  final int userId;
  final String title;
  final String imageUrl;
  final String? discountFree;
  final String? discountPaid;
  final String? dealType;
  final bool isActive;

  // ✅ NEW
  final String? endDate; // ISO string from API

  DealLite({
    required this.id,
    required this.userId,
    required this.title,
    required this.imageUrl,
    required this.discountFree,
    required this.discountPaid,
    required this.dealType,
    required this.isActive,
    this.endDate, // NEW
  });

  factory DealLite.fromJson(Map<String, dynamic> j) => DealLite(
    id: j['id'] ?? 0,
    userId: j['user_id'] ?? 0,
    title: (j['title'] ?? '').toString(),
    imageUrl: (j['image_url'] ?? '').toString(),
    discountFree: (j['discount_value_free']?.toString()),
    discountPaid: (j['discount_value_paid']?.toString()),
    dealType: (j['deal_type']?.toString()),
    isActive: (j['is_active'] == true),
    endDate: (j['end_date']?.toString()), // ✅ NEW
  );
}

enum SubscriptionTier { free, premium }

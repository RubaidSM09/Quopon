// lib/app/data/model/beyondNeighbourhood.dart
import 'dart:math';

class DeliveryCostBN {
  final String zipCode;
  final String deliveryFee;       // string in API
  final String minOrderAmount;    // string in API

  DeliveryCostBN({
    required this.zipCode,
    required this.deliveryFee,
    required this.minOrderAmount,
  });

  factory DeliveryCostBN.fromJson(Map<String, dynamic> json) => DeliveryCostBN(
    zipCode: (json['zip_code'] ?? '').toString(),
    deliveryFee: (json['delivery_fee'] ?? '0').toString(),
    minOrderAmount: (json['min_order_amount'] ?? '0').toString(),
  );
}

class BeyondNeighbourhood {
  // ----- Raw fields from /vendors/all-deals/ -----
  final int id;
  final int userId;                 // user_id
  final String email;               // vendor email from deal payload
  final int linkedMenuItem;         // linked_menu_item
  final String title;               // "offers" in UI
  final String description;
  final String imageUrl;            // cover image in UI
  final String discountValue;       // "5.00"
  final DateTime startDate;
  final DateTime endDate;
  final String redemptionType;      // DELIVERY / PICKUP
  final int maxCouponsTotal;
  final int maxCouponsPerCustomer;
  final List<DeliveryCostBN> deliveryCosts;
  final bool isActive;
  final String qrImage;

  // ----- Optional vendor enrichment (from /vendors/all-business-profile/) -----
  final String? vendorName;         // vendor.name
  final String? vendorLogoUrl;      // vendor.logo_image

  // ----- UI-friendly convenience fields (computed or defaulted) -----
  // keep types compatible with your widgets
  final String rating;              // default "4.6" (no rating in API)
  final String distanceMiles;       // default "2.4"
  final int deliveryTimeMinutes;    // default 30
  final bool isPremium;             // derived: discount >= 50?
  final bool isFavourite;           // default false
  final int priceRange;             // default 2 (1–3 scale, tweak as needed)

  BeyondNeighbourhood({
    // raw
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
    // vendor
    this.vendorName,
    this.vendorLogoUrl,
    // ui
    required this.rating,
    required this.distanceMiles,
    required this.deliveryTimeMinutes,
    required this.isPremium,
    required this.isFavourite,
    required this.priceRange,
  });

  /// Build directly from a deal JSON (optionally pass a vendor JSON to enrich).
  factory BeyondNeighbourhood.fromDealJson(
      Map<String, dynamic> json, {
        Map<String, dynamic>? vendorJson,
      }) {
    final List<dynamic> rawCosts = (json['delivery_costs'] as List<dynamic>? ?? []);
    final costs = rawCosts.map((e) => DeliveryCostBN.fromJson(e as Map<String, dynamic>)).toList();

    final disc = double.tryParse('${json['discount_value']}') ?? 0.0;

    // Optional vendor enrichment
    final vName = vendorJson?['name']?.toString();
    final vLogo = vendorJson?['logo_image']?.toString();

    return BeyondNeighbourhood(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      email: (json['email'] ?? '').toString(),
      linkedMenuItem: json['linked_menu_item'] as int,
      title: (json['title'] ?? '').toString(),
      description: (json['description'] ?? '').toString(),
      imageUrl: (json['image_url'] ?? '').toString(),
      discountValue: (json['discount_value'] ?? '0').toString(),
      startDate: DateTime.parse(json['start_date'].toString()),
      endDate: DateTime.parse(json['end_date'].toString()),
      redemptionType: (json['redemption_type'] ?? '').toString(),
      maxCouponsTotal: (json['max_coupons_total'] ?? 0) as int,
      maxCouponsPerCustomer: (json['max_coupons_per_customer'] ?? 0) as int,
      deliveryCosts: costs,
      isActive: json['is_active'] == true,
      qrImage: (json['qrimage'] ?? '').toString(),

      vendorName: (vName != null && vName.trim().isNotEmpty) ? vName : null,
      vendorLogoUrl: (vLogo != null && vLogo.trim().isNotEmpty) ? vLogo : null,

      // UI defaults/derivations (tweak as you like)
      rating: '4.6',
      distanceMiles: '2.4',
      deliveryTimeMinutes: 30,
      isPremium: disc >= 50.0,
      isFavourite: false,
      priceRange: 2,
    );
  }

  // ------------- Convenience getters to keep your current UI happy -------------

  /// UI expects `name` to show the vendor; fallback to deal email if vendor unknown
  String get name => vendorName ?? email;

  /// UI expects `logoUrl`; prefer vendor logo, then deal image
  String? get logoUrl => vendorLogoUrl?.isNotEmpty == true ? vendorLogoUrl : imageUrl;

  /// UI expects `coverImageUrl`
  String? get coverImageUrl => imageUrl;

  /// UI expects `offers` to be the title
  String get offers => title;

  /// UI expects a string date; provide ISO (you format later with DateFormat)
  String get dealValidity => endDate.toIso8601String();

  /// UI expects the first delivery fee (string)
  String get deliveryFee => deliveryCosts.isNotEmpty ? deliveryCosts.first.deliveryFee : '0';

  /// UI expects an int for minOrder; derive from first cost (round up)
  int get minOrder {
    final s = deliveryCosts.isNotEmpty ? deliveryCosts.first.minOrderAmount : '0';
    final d = double.tryParse(s) ?? 0;
    return d.isFinite ? d.round() : 0;
  }

  /// Expose redemption type directly
  String get redemptionTypeUI => redemptionType;

  /// For compatibility with your previous field names
  String get categoryName => ''; // no category in the deal JSON
  bool get isBeyondNeighborhood => true; // section label semantics
  bool get hasOffers => (discountValue != '0');
}

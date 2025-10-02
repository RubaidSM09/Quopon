// lib/app/data/model/beyondNeighbourhood.dart
import 'dart:math';

import 'beyondNeighbourhood.dart';

class SpeedyDeliveries {
  // ----- Raw fields from /vendors/all-vendor-deals/ -----
  final int id;
  final int userId;                 // user_id
  final String email;
  final int linkedMenuItem;         // linked_menu_item
  final String title;               // "offers" in UI
  final String description;
  final String imageUrl;
  final String discountValue;       // "5.00"
  final DateTime startDate;
  final DateTime endDate;
  final String redemptionType;      // DELIVERY / PICKUP / BOTH (redemption)
  final String dealType;            // NEW: "Paid" | "Free" | "Both" | ""
  final int maxCouponsTotal;
  final int maxCouponsPerCustomer;
  final List<DeliveryCostBN> deliveryCosts;
  final bool isActive;
  final String qrImage;

  // ----- Optional vendor enrichment -----
  final String? vendorName;
  final String? vendorLogoUrl;
  final String? vendorAddress;

  // ----- UI-friendly convenience fields -----
  final String rating;              // default "4.6"
  final String distanceMiles;       // default "2.4"
  final int deliveryTimeMinutes;    // default 30
  final bool isPremium;             // derived: dealType == "Paid"
  final bool isFavourite;           // default false
  final int priceRange;             // default 2

  SpeedyDeliveries({
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
    required this.dealType,          // NEW
    required this.maxCouponsTotal,
    required this.maxCouponsPerCustomer,
    required this.deliveryCosts,
    required this.isActive,
    required this.qrImage,
    // vendor
    this.vendorName,
    this.vendorLogoUrl,
    this.vendorAddress,
    // ui
    required this.rating,
    required this.distanceMiles,
    required this.deliveryTimeMinutes,
    required this.isPremium,
    required this.isFavourite,
    required this.priceRange,
  });

  static String _norm(Object? v, {String fallback = ''}) {
    final s = (v ?? '').toString().trim();
    return s;
  }

  static String _normDealType(Object? v) {
    final s = _norm(v).toLowerCase();
    if (s == 'paid') return 'Paid';
    if (s == 'free') return 'Free';
    if (s == 'both') return 'Both';
    // Treat null/unknown as Free (visible to all)
    return '';
  }

  /// Build directly from a deal JSON (optionally pass a vendor JSON to enrich).
  factory SpeedyDeliveries.fromDealJson(
      Map<String, dynamic> json, {
        Map<String, dynamic>? vendorJson,
        bool isUserPremium = false,             // <- user-aware
      }) {
    String _norm(Object? v) => (v ?? '').toString().trim();
    String _normDealType(Object? v) {
      final s = _norm(v).toLowerCase();
      if (s == 'paid') return 'Paid';
      if (s == 'free') return 'Free';
      if (s == 'both') return 'Both';
      return ''; // unknown/null -> treat like free/both for visibility
    }

    final normalizedDealType = _normDealType(json['deal_type']);
    final isPaidDeal = normalizedDealType == 'Paid';

    // KEY: paid deals blur ONLY for free users
    final computedIsPremium = isPaidDeal && !isUserPremium;

    final List<dynamic> rawCosts = (json['delivery_costs'] as List<dynamic>? ?? []);
    final costs = rawCosts.map((e) => DeliveryCostBN.fromJson(e as Map<String, dynamic>)).toList();

    final vName = vendorJson?['name']?.toString();
    final vLogo = vendorJson?['logo_image']?.toString();
    final vAddress = vendorJson?['address']?.toString();

    return SpeedyDeliveries(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      email: _norm(json['email']),
      linkedMenuItem: json['linked_menu_item'] as int,
      title: _norm(json['title']),
      description: _norm(json['description']),
      imageUrl: _norm(json['image_url']),
      discountValue: _norm(json['discount_value'] ?? json['discount_value_free'] ?? '0'),
      startDate: DateTime.parse(json['start_date'].toString()),
      endDate: DateTime.parse(json['end_date'].toString()),
      redemptionType: _norm(json['redemption_type']),
      dealType: normalizedDealType,
      maxCouponsTotal: (json['max_coupons_total'] ?? 0) as int,
      maxCouponsPerCustomer: (json['max_coupons_per_customer'] ?? 0) as int,
      deliveryCosts: costs,
      isActive: json['is_active'] == true,
      qrImage: _norm(json['qrimage']),

      vendorName: (vName != null && vName.trim().isNotEmpty) ? vName : null,
      vendorLogoUrl: (vLogo != null && vLogo.trim().isNotEmpty) ? vLogo : null,
      vendorAddress: (vLogo != null && vLogo.trim().isNotEmpty) ? vLogo : null,

      rating: '4.6',
      distanceMiles: '2.4',
      deliveryTimeMinutes: 30,
      isPremium: computedIsPremium,          // <- drives blur in HomeRestaurantCard
      isFavourite: false,
      priceRange: 2,
    );
  }

  // ------------- Convenience getters (unchanged) -------------
  String get name => vendorName ?? email;
  String? get logoUrl => vendorLogoUrl?.isNotEmpty == true ? vendorLogoUrl : imageUrl;
  String get address => vendorAddress ?? 'Amsterdam';
  String? get coverImageUrl => imageUrl;
  String get offers => title;
  String get dealValidity => endDate.toIso8601String();
  String get deliveryFee => deliveryCosts.isNotEmpty ? deliveryCosts.first.deliveryFee : '0';

  int get minOrder {
    final s = deliveryCosts.isNotEmpty ? deliveryCosts.first.minOrderAmount : '0';
    final d = double.tryParse(s) ?? 0;
    return d.isFinite ? d.round() : 0;
  }

  String get redemptionTypeUI => redemptionType;
  String get categoryName => '';
  bool get isBeyondNeighborhood => true;
  bool get hasOffers => (discountValue != '0');
}

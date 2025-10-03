// lib/app/data/model/beyondNeighbourhood.dart

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
  // ----- Raw fields from /vendors/all-vendor-deals/ -----
  final int id;
  final int userId; // user_id
  final String email;
  final int linkedMenuItem; // linked_menu_item
  final String title; // "offers" in UI
  final String description;
  final String imageUrl;
  final String discountValue; // legacy single value, kept for compatibility
  final DateTime startDate;
  final DateTime endDate;
  final String redemptionType; // DELIVERY / PICKUP / BOTH (redemption)
  final String dealType; // "Paid" | "Free" | "Both" | ""
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
  final String rating; // default "4.6"
  final String distanceMiles; // default "2.4"
  final int deliveryTimeMinutes; // default 30
  final bool isPremium; // derived: blur flag for free users on paid deals
  final bool userType; // true = premium user, false = free user
  final bool isFavourite; // default false
  final int priceRange; // default 2

  // ----- NEW: separate discounts for Free vs Quopon+ -----
  final String discountValueFree; // formatted, e.g. "10%" or "1+1"
  final String discountValuePaid; // formatted, e.g. "15%" or "2+1"

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
    required this.dealType,
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
    required this.userType,
    required this.isFavourite,
    required this.priceRange,
    // new
    required this.discountValueFree,
    required this.discountValuePaid,
  });

  // ---------- Helpers ----------
  static String _norm(Object? v, {String fallback = ''}) {
    final s = (v ?? '').toString().trim();
    return s.isEmpty ? fallback : s;
  }

  static String _normDealType(Object? v) {
    final s = _norm(v).toLowerCase();
    if (s == 'paid') return 'Paid';
    if (s == 'free') return 'Free';
    if (s == 'both') return 'Both';
    // unknown/null
    return '';
  }

  static String _fmtDiscount(String raw) {
    final v = raw.trim();
    if (v.isEmpty) return '—';
    // keep “1+1” / “2+1” notation as-is
    if (v.contains('+')) return v;
    // if already has '%', keep
    if (v.endsWith('%')) return v;
    // numeric -> add '%'
    final numVal = double.tryParse(v);
    if (numVal != null) {
      final clean =
      (numVal == numVal.roundToDouble()) ? numVal.toInt().toString() : numVal.toString();
      return '$clean%';
    }
    return v;
  }

  /// Build directly from a deal JSON (optionally pass a vendor JSON to enrich).
  factory BeyondNeighbourhood.fromDealJson(
      Map<String, dynamic> json, {
        Map<String, dynamic>? vendorJson,
        bool isUserPremium = false, // true if current user has active subscription
      }) {
    String _n(Object? v) => (v ?? '').toString().trim();
    String _d(Object? v) {
      final s = _n(v).toLowerCase();
      if (s == 'paid') return 'Paid';
      if (s == 'free') return 'Free';
      if (s == 'both') return 'Both';
      return '';
    }

    final normalizedDealType = _d(json['deal_type']);
    final isPaidDeal = normalizedDealType == 'Paid';

    // Blur only if deal is paid and user is not premium
    final computedIsPremium = isPaidDeal && !isUserPremium;
    final userType = isUserPremium; // mirrors your previous logic

    // Read both discounts (may be null/empty)
    final rawFree = _n(json['discount_value_free']);
    final rawPaid = _n(json['discount_value_paid']);

    final List<dynamic> rawCosts = (json['delivery_costs'] as List<dynamic>? ?? []);
    final costs = rawCosts.map((e) => DeliveryCostBN.fromJson(e as Map<String, dynamic>)).toList();

    final vName = vendorJson?['name']?.toString();
    final vLogo = vendorJson?['logo_image']?.toString();
    final vAddress = vendorJson?['address']?.toString();

    return BeyondNeighbourhood(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      email: _n(json['email']),
      linkedMenuItem: (json['linked_menu_item'] ?? 0) as int,
      title: _n(json['title']),
      description: _n(json['description']),
      imageUrl: _n(json['image_url']),
      // legacy single value, keep backwards-compat; prefer discountValueFree/discountValuePaid in UI
      discountValue: _n(json['discount_value'] ?? json['discount_value_free'] ?? '0'),
      startDate: DateTime.parse(json['start_date'].toString()),
      endDate: DateTime.parse(json['end_date'].toString()),
      redemptionType: _n(json['redemption_type']),
      dealType: normalizedDealType,
      maxCouponsTotal: (json['max_coupons_total'] ?? 0) as int,
      maxCouponsPerCustomer: (json['max_coupons_per_customer'] ?? 0) as int,
      deliveryCosts: costs,
      isActive: json['is_active'] == true,
      qrImage: _n(json['qrimage']),
      vendorName: (vName != null && vName.trim().isNotEmpty) ? vName : null,
      vendorLogoUrl: (vLogo != null && vLogo.trim().isNotEmpty) ? vLogo : null,
      vendorAddress: (vAddress != null && vAddress.trim().isNotEmpty) ? vAddress : null,
      rating: '4.6',
      distanceMiles: '2.4',
      deliveryTimeMinutes: 30,
      isPremium: computedIsPremium, // drives blur in HomeRestaurantCard
      userType: userType,
      isFavourite: false,
      priceRange: 2,
      discountValueFree: _fmtDiscount(rawFree),
      discountValuePaid: _fmtDiscount(rawPaid),
    );
  }

  // ------------- Convenience getters -------------
  String get name => vendorName ?? email;
  String? get logoUrl => (vendorLogoUrl?.isNotEmpty == true) ? vendorLogoUrl : imageUrl;
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

  /// NEW: the discount value that applies to the current user type.
  /// If `userType` = true (premium), show paid discount; else show free discount.
  String get currentUserDiscount => userType ? discountValuePaid : discountValueFree;

  /// Helpful flag if any discount exists at all.
  bool get hasAnyDiscount =>
      (discountValueFree != '—' && discountValueFree.isNotEmpty) ||
          (discountValuePaid != '—' && discountValuePaid.isNotEmpty);
}

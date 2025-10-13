import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../data/base_client.dart';

class VendorDealsController extends GetxController {
  final deals = <DealItem>[].obs;           // all deals from API (for this vendor)
  final activeDeals = <DealItem>[].obs;     // filtered: active + date window
  final filteredActiveDeals = <DealItem>[].obs; // new: filtered by search query
  final searchQuery = ''.obs;                // to store search input

  String? _userId;

  @override
  void onInit() {
    super.onInit();
    fetchDeals();
  }

  Future<void> refreshAll() async {
    await fetchDeals();
    // keep current search filter if any
    if (searchQuery.value.isNotEmpty) {
      searchDeals(searchQuery.value);
    }
  }

  Future<void> fetchDeals() async {
    try {
      _userId = await BaseClient.getUserId();
      if (_userId == null || _userId!.isEmpty) {
        throw 'User ID not found. Please log in again.';
      }

      final headers = await BaseClient.authHeaders();
      final response = await http.get(
        Uri.parse('https://doctorless-stopperless-turner.ngrok-free.dev/vendors/create-deals/'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List<dynamic>;

        // Map → DealItem
        final mapped = data
            .map((raw) => DealItem.fromJson(raw as Map<String, dynamic>))
            .where((d) => d.userId?.toString() == _userId)
            .toList();

        // sort by startDate desc (newest first)
        mapped.sort((a, b) => _safeParse(b.startDate).compareTo(_safeParse(a.startDate)));

        deals.assignAll(mapped);

        // filter “active” deals in time window
        final now = DateTime.now();
        activeDeals.assignAll(
          deals.where((d) {
            final sd = _safeParse(d.startDate);
            final ed = _safeParse(d.endDate);
            final withinWindow = (now.isAfter(sd) || now.isAtSameMomentAs(sd)) &&
                (now.isBefore(ed) || now.isAtSameMomentAs(ed));
            return (d.isActive == true) && withinWindow;
          }),
        );
        filteredActiveDeals.assignAll(activeDeals); // initialize filtered list
        print(activeDeals);
      } else {
        throw 'Failed to fetch deals (${response.statusCode})';
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  // Search function to filter active deals by title
  void searchDeals(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      filteredActiveDeals.assignAll(activeDeals);
    } else {
      final filtered = activeDeals
          .where((deal) =>
      deal.title?.toLowerCase().contains(query.toLowerCase()) ?? false)
          .toList();
      filteredActiveDeals.assignAll(filtered);
    }
  }

  static DateTime _safeParse(String? iso) {
    if (iso == null) return DateTime.fromMillisecondsSinceEpoch(0);
    return DateTime.tryParse(iso) ?? DateTime.fromMillisecondsSinceEpoch(0);
  }
}

class DealItem {
  final int? id;
  final int? userId;
  final String? email;
  final int? linkedMenuItem;
  final String? title;
  final String? description;
  final String? imageUrl;

  // Totals from backend
  final int viewCount;
  final int activationCount;
  final int redemptionCount;

  // ✅ NEW: push sent count
  final int pushSentCount; // <-- NEW

  final String? discountValueFree;
  final String? discountValuePaid;
  final String? dealType;
  final String? startDate;
  final String? endDate;
  final String? redemptionType;
  final int? maxCouponsTotal;
  final int? maxCouponsPerCustomer;
  final List<DeliveryCost> deliveryCosts;
  final bool? isActive;
  final String? qrImage;

  DealItem({
    required this.id,
    required this.userId,
    required this.email,
    required this.linkedMenuItem,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.viewCount,
    required this.activationCount,
    required this.redemptionCount,
    required this.pushSentCount, // <-- NEW
    required this.discountValueFree,
    required this.discountValuePaid,
    required this.dealType,
    required this.startDate,
    required this.endDate,
    required this.redemptionType,
    required this.maxCouponsTotal,
    required this.maxCouponsPerCustomer,
    required this.deliveryCosts,
    required this.isActive,
    required this.qrImage,
  });

  factory DealItem.fromJson(Map<String, dynamic> json) {
    final dc = (json['delivery_costs'] as List? ?? [])
        .map((e) => DeliveryCost.fromJson(e as Map<String, dynamic>))
        .toList();

    print(_asInt(json['push_sent_count']));

    return DealItem(
      id: _asInt(json['id']),
      userId: _asInt(json['user_id']),
      email: _asString(json['email']),
      linkedMenuItem: _asInt(json['linked_menu_item']),
      title: _asString(json['title']),
      description: _asString(json['description']),
      imageUrl: _asString(json['image_url']),
      viewCount: _asInt(json['view_count']) ?? 0,
      activationCount: _asInt(json['activation']) ?? 0,
      redemptionCount: _asInt(json['redemption']) ?? 0,

      // ✅ map new field from backend
      pushSentCount: _asInt(json['push_sent_count']) ?? 0, // <-- NEW

      discountValueFree: _asString(json['discount_value_free']),
      discountValuePaid: _asString(json['discount_value_paid']),
      dealType: _asString(json['deal_type']),
      startDate: _asString(json['start_date']),
      endDate: _asString(json['end_date']),
      redemptionType: _asString(json['redemption_type']),
      maxCouponsTotal: _asInt(json['max_coupons_total']),
      maxCouponsPerCustomer: _asInt(json['max_coupons_per_customer']),
      deliveryCosts: dc,
      isActive: _asBool(json['is_active']),
      qrImage: _asString(json['qrimage']),
    );
  }

  static int? _asInt(dynamic v) {
    if (v == null) return null;
    if (v is int) return v;
    if (v is String) return int.tryParse(v);
    if (v is num) return v.toInt();
    return null;
  }

  static String? _asString(dynamic v) => v?.toString();

  static bool? _asBool(dynamic v) {
    if (v == null) return null;
    if (v is bool) return v;
    if (v is String) return v.toLowerCase() == 'true';
    if (v is num) return v != 0;
    return null;
  }
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

  factory DeliveryCost.fromJson(Map<String, dynamic> json) {
    return DeliveryCost(
      zipCode: json['zip_code']?.toString() ?? '',
      deliveryFee: json['delivery_fee']?.toString() ?? '0',
      minOrderAmount: json['min_order_amount']?.toString() ?? '0',
    );
  }
}
// lib/app/modules/MyDeals/controllers/my_deals_controller.dart
import 'dart:convert';
import 'package:get/get.dart';
import 'package:quopon/app/data/base_client.dart';

class MyDealEntry {
  final int id;
  final int userId;
  final int dealId;
  final DateTime addedAt;

  MyDealEntry({
    required this.id,
    required this.userId,
    required this.dealId,
    required this.addedAt,
  });

  factory MyDealEntry.fromJson(Map<String, dynamic> json) => MyDealEntry(
    id: json['id'],
    userId: json['user'],
    dealId: json['deal'],
    addedAt: DateTime.parse(json['added_at']),
  );
}

class MyDealViewData {
  final int wishlistId;
  final int dealId;

  // Deal info
  final String title;
  final String description;
  final String imageUrl;
  final DateTime startDate;
  final DateTime endDate;
  final bool isActive;
  final String redemptionType; // 'DELIVERY' | 'PICKUP' etc.

  // Delivery (first rule fallback)
  final String deliveryFee; // string per API
  final int minOrder;       // parsed int

  // Vendor enrichment
  final int? vendorId;
  final String vendorName;          // fallback to deal email if unknown
  final String? vendorLogoUrl;      // fallback to deal image if missing

  MyDealViewData({
    required this.wishlistId,
    required this.dealId,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.startDate,
    required this.endDate,
    required this.isActive,
    required this.redemptionType,
    required this.deliveryFee,
    required this.minOrder,
    required this.vendorId,
    required this.vendorName,
    required this.vendorLogoUrl,
  });

  String get statusText {
    final now = DateTime.now();
    if (!isActive || now.isAfter(endDate)) return 'Expired';
    if (now.isBefore(startDate)) return 'Upcoming';
    return 'Active';
  }
}

class MyDealsController extends GetxController {
  final deals = <MyDealViewData>[].obs;
  final isLoading = false.obs;

  Future<void> fetchMyDeals() async {
    try {
      isLoading.value = true;
      final headers = await BaseClient.authHeaders();

      // 1) Wishlist rows
      final wishRes = await BaseClient.getRequest(
        api: 'https://intensely-optimal-unicorn.ngrok-free.app/vendors/wish-deals/',
        headers: headers,
      );
      if (wishRes.statusCode < 200 || wishRes.statusCode >= 300) {
        Get.snackbar('Error', 'Failed to load My Deals (${wishRes.statusCode})');
        deals.clear();
        return;
      }
      final List<dynamic> wishBody = json.decode(wishRes.body);
      final entries = wishBody.map((e) => MyDealEntry.fromJson(e)).toList();
      if (entries.isEmpty) {
        deals.clear();
        return;
      }

      // 2) All deals
      final allDealsRes = await BaseClient.getRequest(
        api: 'https://intensely-optimal-unicorn.ngrok-free.app/vendors/all-deals/',
        headers: headers,
      );
      if (allDealsRes.statusCode < 200 || allDealsRes.statusCode >= 300) {
        Get.snackbar('Error', 'Failed to load deals catalog (${allDealsRes.statusCode})');
        deals.clear();
        return;
      }
      final List<dynamic> allDeals = json.decode(allDealsRes.body);
      final Map<int, Map<String, dynamic>> dealById = {
        for (final d in allDeals)
          (d as Map<String, dynamic>)['id'] as int: d as Map<String, dynamic>
      };

      // 3) Vendors (enrichment)
      final vendorsRes = await BaseClient.getRequest(
        api: 'https://intensely-optimal-unicorn.ngrok-free.app/vendors/all-business-profile/',
        headers: headers,
      );
      final Map<int, Map<String, dynamic>> vendorById = {};
      if (vendorsRes.statusCode >= 200 && vendorsRes.statusCode < 300) {
        final List<dynamic> vendors = json.decode(vendorsRes.body);
        for (final v in vendors) {
          final vm = v as Map<String, dynamic>;
          final vid = vm['vendor_id'];
          if (vid is int) vendorById[vid] = vm;
        }
      }

      // 4) Join → view data (NULL-SAFE)
      final joined = <MyDealViewData>[];
      for (final w in entries) {
        final djson = dealById[w.dealId];
        if (djson == null) continue;

        final userId = djson['user_id'] as int?;
        final vendor = userId != null ? vendorById[userId] : null;

        // --- Safe strings
        String _s(dynamic v) => v is String ? v : (v?.toString() ?? '');

        final title = _s(djson['title']);
        final description = _s(djson['description']);
        final imageUrl = _s(djson['image_url']);
        final redemptionType = _s(djson['redemption_type']);
        final emailFallback = _s(djson['email']);

        // --- Safe dates
        DateTime _parseDate(dynamic v, {DateTime? fallback}) {
          final s = _s(v);
          final parsed = s.isNotEmpty ? DateTime.tryParse(s) : null;
          return parsed ?? (fallback ?? DateTime.now());
        }

        final start = _parseDate(djson['start_date']);
        final end   = _parseDate(djson['end_date'], fallback: start);

        // --- Delivery (first rule)
        String deliveryFee = '0';
        int minOrder = 0;
        final costs = djson['delivery_costs'] as List<dynamic>?;
        if (costs != null && costs.isNotEmpty) {
          final first = costs.first as Map<String, dynamic>;
          deliveryFee = _s(first['delivery_fee']);
          final mo = _s(first['min_order_amount']);
          minOrder = (double.tryParse(mo) ?? 0).round();
        }

        // --- Vendor enrichment
        final vName = _s(vendor?['name']).trim();
        final vLogo = _s(vendor?['logo_image']).trim();

        joined.add(MyDealViewData(
          wishlistId: w.id,
          dealId: w.dealId,
          title: title,
          description: description,        // <- now guaranteed non-null String
          imageUrl: imageUrl,              // <- non-null String (may be '')
          startDate: start,
          endDate: end,
          isActive: djson['is_active'] == true,
          redemptionType: redemptionType,
          deliveryFee: deliveryFee,
          minOrder: minOrder,
          vendorId: userId,
          vendorName: vName.isNotEmpty ? vName : emailFallback,
          vendorLogoUrl: vLogo.isNotEmpty ? vLogo : (imageUrl.isNotEmpty ? imageUrl : null),
        ));
      }

      deals.assignAll(joined);
    } catch (e) {
      Get.snackbar('Error', e.toString());
      deals.clear();
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchMyDeals();
  }
}

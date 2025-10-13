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
  final int minOrder; // parsed int

  // Vendor enrichment
  final int? vendorProfileId;
  final int? vendorId;
  final String vendorName; // fallback to deal email if unknown
  final String? vendorLogoUrl; // fallback to deal image if missing

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
    required this.vendorProfileId,
    required this.vendorId,
    required this.vendorName,
    required this.vendorLogoUrl,
  });

  /// Status derived from isActive + dates
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

  /// 0 = Active, 1 = Used (placeholder), 2 = Expired
  final selectedTab = 0.obs;

  /// Convenience getters for filtered views
  List<MyDealViewData> get activeDeals =>
      deals.where((d) => d.statusText == 'Active').toList();
  List<MyDealViewData> get expiredDeals =>
      deals.where((d) => d.statusText == 'Expired').toList();
  // No backend signal for "used" right now – keep it empty for now.
  List<MyDealViewData> get usedDeals => <MyDealViewData>[];

  Future<void> fetchMyDeals() async {
    try {
      isLoading.value = true;
      final headers = await BaseClient.authHeaders();

      // 1) Wishlist rows
      final wishRes = await BaseClient.getRequest(
        api:
        'https://doctorless-stopperless-turner.ngrok-free.dev/vendors/wish-deals/',
        headers: headers,
      );
      if (wishRes.statusCode < 200 || wishRes.statusCode >= 300) {
        Get.snackbar(
            'Error', 'Failed to load My Deals (${wishRes.statusCode})');
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
        api:
        'https://doctorless-stopperless-turner.ngrok-free.dev/vendors/all-vendor-deals/',
        headers: headers,
      );
      if (allDealsRes.statusCode < 200 || allDealsRes.statusCode >= 300) {
        Get.snackbar(
            'Error', 'Failed to load deals catalog (${allDealsRes.statusCode})');
        deals.clear();
        return;
      }
      final List<dynamic> allDeals = json.decode(allDealsRes.body);
      final Map<int, Map<String, dynamic>> dealById = {
        for (final d in allDeals)
          (d as Map<String, dynamic>)['id'] as int:
          d as Map<String, dynamic>
      };

      // 3) Vendors (enrichment)
      final vendorsRes = await BaseClient.getRequest(
        api:
        'https://doctorless-stopperless-turner.ngrok-free.dev/vendors/all-business-profile/',
        headers: headers,
      );
      final Map<int, Map<String, dynamic>> vendorById = {};
      if (vendorsRes.statusCode >= 200 && vendorsRes.statusCode < 300) {
        final List<dynamic> vendors = json.decode(vendorsRes.body);
        for (final v in vendors) {
          final vm = v as Map<String, dynamic>;
          final vid = vm['vendor_id'];
          if (vid is int) {
            vendorById[vid] = vm; // store full map with both vendor_id and id
          }
        }
      }

      // 4) Join → view data
      final joined = <MyDealViewData>[];
      for (final w in entries) {
        final djson = dealById[w.dealId];
        if (djson == null) continue;

        final userId = djson['user_id'] as int?;
        final vendor = userId != null ? vendorById[userId] : null;

        String _s(dynamic v) => v is String ? v : (v?.toString() ?? '');

        final title = _s(djson['title']);
        final description = _s(djson['description']);
        // Try both possible fields for image naming
        final imageUrl = _s(
          djson['image_url'] ?? djson['logo_image'] ?? djson['image'],
        );
        final redemptionType = _s(djson['redemption_type']);
        final emailFallback = _s(djson['email']);

        // dates
        DateTime _parseDate(dynamic v, {DateTime? fallback}) {
          final s = _s(v);
          final parsed = s.isNotEmpty ? DateTime.tryParse(s) : null;
          return parsed ?? (fallback ?? DateTime.now());
        }

        final start = _parseDate(djson['start_date']);
        final end = _parseDate(djson['end_date'], fallback: start);

        // delivery costs
        String deliveryFee = '0';
        int minOrder = 0;
        final costs = djson['delivery_costs'] as List<dynamic>?;
        if (costs != null && costs.isNotEmpty) {
          final first = costs.first as Map<String, dynamic>;
          deliveryFee = _s(first['delivery_fee']);
          final mo = _s(first['min_order_amount']);
          minOrder = (double.tryParse(mo) ?? 0).round();
        }

        // vendor enrichment
        final vName = _s(vendor?['name']).trim();
        final vLogo = _s(vendor?['logo_image']).trim();

        final vendorProfileId = vendor?['id'] as int?;
        final vendorId = vendor?['vendor_id'] as int?;

        joined.add(
          MyDealViewData(
            wishlistId: w.id,
            dealId: w.dealId,
            title: title,
            description: description,
            imageUrl: imageUrl,
            startDate: start,
            endDate: end,
            isActive: djson['is_active'] == true,
            redemptionType: redemptionType,
            deliveryFee: deliveryFee,
            minOrder: minOrder,
            vendorProfileId: vendorProfileId,
            vendorId: vendorId,
            vendorName: vName.isNotEmpty ? vName : emailFallback,
            vendorLogoUrl:
            vLogo.isNotEmpty ? vLogo : (imageUrl.isNotEmpty ? imageUrl : null),
          ),
        );
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

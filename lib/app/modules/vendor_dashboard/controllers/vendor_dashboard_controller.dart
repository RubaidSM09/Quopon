import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../data/api_client.dart';
import '../../../data/model/vendor_order.dart';

class VendorDashboardController extends GetxController {
  RxList<VendorOrder> orders = <VendorOrder>[].obs;
  RxList<Deal> deals = <Deal>[].obs;

  RxInt totalDeals = 0.obs;
  RxInt totalRedemptions = 0.obs;
  RxInt redemptionRate = 0.obs;

  // start at 0; we will compute from API
  RxInt pushesSent = 0.obs;

  Future<void> refreshAll() async {
    await Future.wait([
      fetchOrders(),
      fetchDeals(),
    ]).catchError((_) {});
  }

  Future<void> fetchOrders() async {
    final url = Uri.parse('https://intensely-optimal-unicorn.ngrok-free.app/order/orders/vendor-orders/');
    try {
      print(await ApiClient.authHeaders());
      final response = await http.get(url, headers: await ApiClient.authHeaders());
      print(response.statusCode);
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        orders.value = data.map((json) => VendorOrder.fromJson(json)).toList();
      } else {
        print('Failed to load orders: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching orders: $e');
    }
  }

  Future<void> fetchDeals() async {
    // Recommended: endpoint that includes push_sent_count
    final url = Uri.parse('https://intensely-optimal-unicorn.ngrok-free.app/vendors/all-vendor-deals/');
    try {
      final headers = await ApiClient.authHeaders();

      // If you have a helper to get the current user id, use it:
      String? myUserId;
      try {
        // Implement ApiClient.getUserId() to read from token if you don't have it yet.
        myUserId = await ApiClient.getUserId();
      } catch (_) {
        myUserId = null;
      }

      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final raw = json.decode(response.body);
        final List<dynamic> data = (raw is List) ? raw : <dynamic>[];

        final allDeals = data
            .map((e) => Deal.fromJson(e as Map<String, dynamic>))
            .toList();

        // Filter to current vendor's deals if we know the user id.
        final mine = (myUserId == null || myUserId!.isEmpty)
            ? allDeals
            : allDeals.where((d) => d.userId.toString() == myUserId).toList();

        deals.value = mine;

        int totalViews = 0;
        int totalReds = 0;
        int activeDeals = 0;
        int totalPushes = 0;

        for (final deal in mine) {
          if (deal.isActive) activeDeals++;
          totalViews += deal.viewCount;
          totalReds += deal.redemption;

          // NEW: sum push_sent_count
          totalPushes += deal.pushSentCount;
        }

        totalDeals.value = activeDeals;
        totalRedemptions.value = totalReds;
        redemptionRate.value = (totalViews > 0)
            ? ((totalReds / totalViews) * 100).ceil()
            : 0;

        // NEW: expose on dashboard
        pushesSent.value = totalPushes;

      } else {
        print('Failed to load deals: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching deals: $e');
    }
  }

  @override
  void onInit() {
    fetchOrders();
    fetchDeals();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}

class Deal {
  int id;
  int userId;
  String email;
  int linkedMenuItem;
  String title;
  String description;
  String imageUrl;
  String? discountValueFree;
  String? discountValuePaid;
  String? dealType;
  String startDate;
  String endDate;
  String redemptionType;
  int maxCouponsTotal;
  int maxCouponsPerCustomer;
  List<DeliveryCost> deliveryCosts;
  bool isActive;
  String? qrimage;
  int viewCount;
  int activation;
  int redemption;
  int pushSentCount;

  Deal({
    required this.id,
    required this.userId,
    required this.email,
    required this.linkedMenuItem,
    required this.title,
    required this.description,
    required this.imageUrl,
    this.discountValueFree,
    this.discountValuePaid,
    this.dealType,
    required this.startDate,
    required this.endDate,
    required this.redemptionType,
    required this.maxCouponsTotal,
    required this.maxCouponsPerCustomer,
    required this.deliveryCosts,
    required this.isActive,
    this.qrimage,
    required this.viewCount,
    required this.activation,
    required this.redemption,
    required this.pushSentCount,
  });

  factory Deal.fromJson(Map<String, dynamic> json) {
    return Deal(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      email: json['email'] ?? '',
      linkedMenuItem: json['linked_menu_item'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['image_url'] ?? '',
      discountValueFree: json['discount_value_free'],
      discountValuePaid: json['discount_value_paid'],
      dealType: json['deal_type'],
      startDate: json['start_date'] ?? '',
      endDate: json['end_date'] ?? '',
      redemptionType: json['redemption_type'] ?? '',
      maxCouponsTotal: json['max_coupons_total'] ?? 0,
      maxCouponsPerCustomer: json['max_coupons_per_customer'] ?? 0,
      deliveryCosts: (json['delivery_costs'] as List<dynamic>?)
          ?.map((e) => DeliveryCost.fromJson(e as Map<String, dynamic>))
          .toList() ??
          [],
      isActive: json['is_active'] ?? false,
      qrimage: json['qrimage'],
      viewCount: json['view_count'] ?? 0,
      activation: json['activation'] ?? 0,
      redemption: json['redemption'] ?? 0,

      // NEW: default to 0 when absent
      pushSentCount: (json['push_sent_count'] is int)
          ? (json['push_sent_count'] as int)
          : int.tryParse('${json['push_sent_count'] ?? 0}') ?? 0,
    );
  }
}

class DeliveryCost {
  String zipCode;
  String deliveryFee;
  String minOrderAmount;

  DeliveryCost({
    required this.zipCode,
    required this.deliveryFee,
    required this.minOrderAmount,
  });

  factory DeliveryCost.fromJson(Map<String, dynamic> json) {
    return DeliveryCost(
      zipCode: json['zip_code'] ?? '',
      deliveryFee: json['delivery_fee'] ?? '0.00',
      minOrderAmount: json['min_order_amount'] ?? '0.00',
    );
  }
}
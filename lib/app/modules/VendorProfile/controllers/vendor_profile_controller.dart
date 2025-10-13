import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:quopon/app/data/model/menu.dart';
import '../../../data/api.dart';
import '../../../data/base_client.dart';
import '../../../data/model/menu_item.dart';
import '../../vendor_deals/controllers/vendor_deals_controller.dart';

// Define DealItem class to match the JSON structure
class DealItem {
  final int id;
  final int userId;
  final String email;
  final int linkedMenuItem;
  final String? title;
  final String? description;
  final String? imageUrl;
  final String? discountValueFree;
  final String? discountValuePaid;
  final String? dealType;
  final String? startDate;
  final String? endDate;
  final String? redemptionType;
  final int maxCouponsTotal;
  final int maxCouponsPerCustomer;
  final List<DeliveryCost> deliveryCosts;
  final bool isActive;
  final String? qrImage;
  final int viewCount;
  final int activation;
  final int redemption;

  DealItem({
    required this.id,
    required this.userId,
    required this.email,
    required this.linkedMenuItem,
    this.title,
    this.description,
    this.imageUrl,
    this.discountValueFree,
    this.discountValuePaid,
    this.dealType,
    this.startDate,
    this.endDate,
    this.redemptionType,
    required this.maxCouponsTotal,
    required this.maxCouponsPerCustomer,
    required this.deliveryCosts,
    required this.isActive,
    this.qrImage,
    required this.viewCount,
    required this.activation,
    required this.redemption,
  });

  factory DealItem.fromJson(Map<String, dynamic> json) {
    return DealItem(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      email: json['email'] as String,
      linkedMenuItem: json['linked_menu_item'] as int,
      title: json['title'] as String?,
      description: json['description'] as String?,
      imageUrl: json['image_url'] as String?,
      discountValueFree: json['discount_value_free'] as String?,
      discountValuePaid: json['discount_value_paid'] as String?,
      dealType: json['deal_type'] as String?,
      startDate: json['start_date'] as String?,
      endDate: json['end_date'] as String?,
      redemptionType: json['redemption_type'] as String?,
      maxCouponsTotal: json['max_coupons_total'] as int,
      maxCouponsPerCustomer: json['max_coupons_per_customer'] as int,
      deliveryCosts: (json['delivery_costs'] as List<dynamic>)
          .map((e) => DeliveryCost.fromJson(e as Map<String, dynamic>))
          .toList(),
      isActive: json['is_active'] as bool,
      qrImage: json['qrimage'] as String?,
      viewCount: json['view_count'] as int,
      activation: json['activation'] as int,
      redemption: json['redemption'] as int,
    );
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
      zipCode: json['zip_code'] as String,
      deliveryFee: json['delivery_fee'] as String,
      minOrderAmount: json['min_order_amount'] as String,
    );
  }
}

class Deal {
  final String dealImg;
  final String dealTitle;
  final String dealDescription;
  final String dealValidity;

  Deal({
    required this.dealImg,
    required this.dealTitle,
    required this.dealDescription,
    required this.dealValidity,
  });
}

class VendorProfileController extends GetxController {
  var deals = <DealItem>[].obs;
  final RxList<RxBool> isOptionsSelected = [false.obs, false.obs].obs;
  RxDouble total_price = 0.00.obs;

  final RxBool loading = false.obs;
  final RxString error = ''.obs;
  final RxMap<String, List<MenuItem>> menusByCategory = <String, List<MenuItem>>{}.obs;
  final RxString subscriptionStatus = 'Inactive'.obs; // Store subscription status

  /// FOLLOW/UNFOLLOW STATE
  final isFollowed = false.obs;
  final followBusy = false.obs;

  /// Fetch user profile to determine subscription status
  Future<void> fetchUserProfile() async {
    try {
      final headers = await BaseClient.authHeaders();
      final response = await http.get(
        Uri.parse('https://doctorless-stopperless-turner.ngrok-free.dev/food/my-profile/'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        subscriptionStatus.value = data['subscription_status'] as String? ?? 'Inactive';
      } else {
        debugPrint('Failed to fetch user profile: ${response.statusCode} ${response.body}');
        subscriptionStatus.value = 'Inactive'; // Default to Inactive on error
      }
    } catch (e) {
      debugPrint('fetchUserProfile error: $e');
      subscriptionStatus.value = 'Inactive';
    }
  }

  /// Initialize follow state for this vendor (use the *business profile* id)
  Future<void> loadFollowState(int vendorProfileId) async {
    try {
      final headers = await BaseClient.authHeaders();
      final res = await http.get(
        Uri.parse('https://doctorless-stopperless-turner.ngrok-free.dev/vendors/customers/followed-vendors/'),
        headers: headers,
      );
      if (res.statusCode < 200 || res.statusCode >= 300) {
        debugPrint('followed-vendors status: ${res.statusCode} ${res.body}');
        isFollowed.value = false;
        return;
      }
      final body = json.decode(res.body);
      if (body is List) {
        isFollowed.value = body.any((e) {
          final m = e as Map<String, dynamic>;
          final id = m['id'];
          return id is int ? id == vendorProfileId : int.tryParse('$id') == vendorProfileId;
        });
      } else {
        isFollowed.value = false;
      }
    } catch (e) {
      debugPrint('loadFollowState error: $e');
      isFollowed.value = false;
    }
  }

  /// Toggle follow/unfollow using the *business profile* id in the endpoint
  Future<void> toggleFollow(int vendorProfileId) async {
    if (followBusy.value) return;
    followBusy.value = true;
    try {
      final headers = await BaseClient.authHeaders();
      final base = 'https://doctorless-stopperless-turner.ngrok-free.dev/vendors/vendors/$vendorProfileId';
      final uri = Uri.parse(isFollowed.value ? '$base/unfollow/' : '$base/follow/');
      final res = await http.post(uri, headers: headers);

      if (res.statusCode >= 200 && res.statusCode < 300) {
        isFollowed.toggle();
        Get.snackbar('Success', isFollowed.value ? 'Vendor followed' : 'Vendor unfollowed');
      } else {
        debugPrint('Follow/unfollow error: ${res.statusCode} ${res.body}');
        Get.snackbar('Error', 'Failed to ${isFollowed.value ? 'unfollow' : 'follow'} vendor');
      }
    } catch (e) {
      debugPrint('toggleFollow error: $e');
      Get.snackbar('Error', 'Network error while updating follow status');
    } finally {
      followBusy.value = false;
    }
  }

  // Fetch active deals for a specific vendor
  Future<void> fetchDeals(int vendorId) async {
    try {
      loading.value = true;
      error.value = '';
      await fetchUserProfile(); // Fetch subscription status before deals
      final headers = await BaseClient.authHeaders();
      final response = await http.get(
        Uri.parse('https://doctorless-stopperless-turner.ngrok-free.dev/vendors/all-vendor-deals/'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List<dynamic>;
        final now = DateTime.now();
        // Filter deals by vendorId, active status, and subscription-based deal type
        deals.assignAll(data
            .map((deal) => DealItem.fromJson(deal as Map<String, dynamic>))
            .where((deal) {
          final isValidDeal = deal.userId == vendorId &&
              deal.isActive &&
              deal.endDate != null &&
              DateTime.parse(deal.endDate!).isAfter(now);
          if (subscriptionStatus.value == 'Active') {
            // Paid users see all deals
            return isValidDeal;
          } else {
            // Free users see only Paid or Both deal types
            return isValidDeal && (deal.dealType == 'Paid' || deal.dealType == 'Both');
          }
        })
            .toList());
      } else {
        error.value = 'Failed to fetch deals: ${response.statusCode}';
        Get.snackbar('Error', error.value);
      }
    } catch (e) {
      error.value = 'Error fetching deals: $e';
      Get.snackbar('Error', error.value);
    } finally {
      loading.value = false;
    }
  }

  Future<void> fetchMenus(int id) async {
    loading.value = true;
    error.value = '';
    menusByCategory.clear();

    try {
      final headers = await BaseClient.authHeaders();
      final res = await BaseClient.getRequest(
        api: 'https://doctorless-stopperless-turner.ngrok-free.dev/vendors/deals/',
        params: {'user_id': id.toString()},
        headers: headers,
      );

      final data = await BaseClient.handleResponse(res);

      final List<MenuItem> items = (data as List)
          .map((e) => MenuItem.fromJson(e as Map<String, dynamic>))
          .toList();

      final map = <String, List<MenuItem>>{};
      for (final mi in items) {
        final catTitle = (mi.category.categoryTitle).isNotEmpty
            ? mi.category.categoryTitle
            : 'Uncategorized';
        map.putIfAbsent(catTitle, () => <MenuItem>[]);
        map[catTitle]!.add(mi);
      }

      menusByCategory.assignAll(map);
    } catch (e) {
      error.value = e.toString();
    } finally {
      loading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
  }
}
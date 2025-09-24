import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../data/base_client.dart';

class VendorDealsController extends GetxController {
  var deals = <DealItem>[].obs; // Observable list to store deals

  @override
  void onInit() {
    super.onInit();
    fetchDeals(); // Fetch deals when the controller is initialized
  }

  // Fetch deals from the API
  Future<void> fetchDeals() async {
    try {
      final userId = await BaseClient.getUserId();
      if (userId == null || userId.isEmpty) {
        throw 'User ID not found. Please log in again.';
      }
      final headers = await BaseClient.authHeaders();

      // Fetch the deals
      final response = await http.get(
        Uri.parse('https://intensely-optimal-unicorn.ngrok-free.app/vendors/create-deals/'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List<dynamic>;
        // Convert JSON response to a list of DealItem objects
        deals.assignAll(data.map((deal) => DealItem.fromJson(deal)).toList());
      } else {
        throw 'Failed to fetch deals';
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}

// DealItem model to parse the deal data
class DealItem {
  final int id;
  final int linkedMenuItem;
  final String title;
  final String description;
  final String imageUrl;
  final String discountValue;
  final String startDate;
  final String endDate;
  final String redemptionType;
  final int maxCouponsTotal;
  final int maxCouponsPerCustomer;
  final List<DeliveryCost> deliveryCosts;

  DealItem({
    required this.id,
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
  });

  factory DealItem.fromJson(Map<String, dynamic> json) {
    var list = json['delivery_costs'] as List;
    List<DeliveryCost> deliveryCostsList =
    list.map((i) => DeliveryCost.fromJson(i)).toList();

    return DealItem(
      id: json['id'],
      linkedMenuItem: json['linked_menu_item'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['image_url'],
      discountValue: json['discount_value'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      redemptionType: json['redemption_type'],
      maxCouponsTotal: json['max_coupons_total'],
      maxCouponsPerCustomer: json['max_coupons_per_customer'],
      deliveryCosts: deliveryCostsList,
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
      zipCode: json['zip_code'],
      deliveryFee: json['delivery_fee'],
      minOrderAmount: json['min_order_amount'],
    );
  }
}

import 'dart:convert';

import 'package:get/get.dart';
import 'package:quopon/app/data/model/order.dart';

import '../../../data/api.dart';
import '../../../data/base_client.dart';

class MyOrdersController extends GetxController {
  final activeOrders = <Order>[].obs;
  final completedOrders = <Order>[].obs;
  final isLoading = false.obs;
  final errorText = ''.obs;

  Future<void> fetchActiveOrders() async {
    try {
      isLoading.value = true;
      errorText.value = '';

      final headers = await BaseClient.authHeaders();
      final response = await BaseClient.getRequest(api: Api.activeOrders, headers: headers);
      final data = await BaseClient.handleResponse(response);

      List<Order> parsed = const [];
      if (data is List) {
        parsed = data.map((e) => Order.fromJson(Map<String, dynamic>.from(e))).toList();
      } else if (data is Map && data['results'] is List) {
        parsed = (data['results'] as List)
            .map((e) => Order.fromJson(Map<String, dynamic>.from(e)))
            .toList();
      } else if (data is String && data.isNotEmpty) {
        parsed = orderFromJson(data);
      }

      activeOrders.assignAll(parsed);
    } catch (e) {
      errorText.value = e.toString();
      activeOrders.clear();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchCompletedOrders() async {
    try {
      isLoading.value = true;
      errorText.value = '';

      final headers = await BaseClient.authHeaders();
      final response = await BaseClient.getRequest(api: Api.completedOrders, headers: headers);
      final data = await BaseClient.handleResponse(response);

      List<Order> parsed = const [];
      if (data is List) {
        parsed = data.map((e) => Order.fromJson(Map<String, dynamic>.from(e))).toList();
      } else if (data is Map && data['results'] is List) {
        parsed = (data['results'] as List)
            .map((e) => Order.fromJson(Map<String, dynamic>.from(e)))
            .toList();
      } else if (data is String && data.isNotEmpty) {
        parsed = orderFromJson(data);
      }

      completedOrders.assignAll(parsed);
    } catch (e) {
      errorText.value = e.toString();
      completedOrders.clear();
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchActiveOrders();
    fetchCompletedOrders();
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

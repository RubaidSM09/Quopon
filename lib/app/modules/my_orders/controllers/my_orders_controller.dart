import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quopon/app/data/api.dart';
import 'package:quopon/app/data/base_client.dart';
import 'package:quopon/app/data/model/order.dart';

class MyOrdersController extends GetxController {
  final activeOrders = <Order>[].obs;
  final completedOrders = <Order>[].obs;
  final cancelledOrders = <Order>[].obs;
  final isLoading = false.obs;
  final errorText = ''.obs;

  Future<void> fetchOrders() async {
    try {
      isLoading.value = true;
      errorText.value = '';

      final headers = await BaseClient.authHeaders();
      final response = await BaseClient.getRequest(api: 'https://intensely-optimal-unicorn.ngrok-free.app/order/orders/', headers: headers);
      final data = await BaseClient.handleResponse(response);

      List<Order> allOrders = [];
      if (data is List) {
        allOrders = data.map((e) {
          if (e is Map<String, dynamic>) {
            return Order.fromJson(e);
          } else {
            throw FormatException('Invalid order data format');
          }
        }).toList();
      } else if (data is Map && data['results'] is List) {
        allOrders = (data['results'] as List).map((e) {
          if (e is Map<String, dynamic>) {
            return Order.fromJson(e);
          } else {
            throw FormatException('Invalid order data format');
          }
        }).toList();
      } else if (data is String && data.isNotEmpty) {
        allOrders = orderFromJson(data);
      } else {
        throw Exception('Unexpected response format');
      }

      activeOrders.assignAll(allOrders.where((o) => o.status != "COMPLETED" && o.status != "CANCELLED").toList());
      completedOrders.assignAll(allOrders.where((o) => o.status == "COMPLETED").toList());
      cancelledOrders.assignAll(allOrders.where((o) => o.status == "CANCELLED").toList());
    } catch (e) {
      errorText.value = e.toString();
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.red, colorText: Colors.white);
      activeOrders.clear();
      completedOrders.clear();
      cancelledOrders.clear();
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
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
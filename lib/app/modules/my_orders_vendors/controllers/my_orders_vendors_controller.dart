import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:quopon/app/data/api_client.dart';

import '../../../data/model/vendor_order.dart';

class MyOrdersVendorsController extends GetxController {
  RxList<RxBool> selectedTime = [false.obs, true.obs, false.obs, false.obs, false.obs].obs;
  RxInt time = 30.obs;

  RxList<VendorOrder> orders = <VendorOrder>[].obs;

  final count = 0.obs;
  @override
  void onInit() {
    fetchOrders();
    super.onInit();
  }

  Future<void> fetchOrders() async {
    final url = Uri.parse('https://intensely-optimal-unicorn.ngrok-free.app/order/orders/vendor-orders/');
    try {
      print(await ApiClient.authHeaders());
      final response = await http.get(url, headers: await ApiClient.authHeaders());
      print(url);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print('Rubaid');
        List<dynamic> data = json.decode(response.body);
        orders.value = data.map((json) => VendorOrder.fromJson(json)).toList();
        print(orders);
      } else {
        print('Failed to load orders');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> updateOrderStatus(String orderId, String newStatus) async {
    final url = Uri.parse('https://intensely-optimal-unicorn.ngrok-free.app/order/orders/$orderId/status/');
    try {
      final response = await http.post(
        url,
        headers: await ApiClient.authHeaders(),
        body: json.encode({'status': newStatus}),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar('Success', 'Order status updated to $newStatus');
        // Update the local order status
        final orderIndex = orders.indexWhere((order) => order.orderId == orderId);
        if (orderIndex != -1) {
          orders[orderIndex].status = newStatus;
          orders.refresh();
        }
        // Refresh orders to ensure consistency
        await fetchOrders();
      } else {
        Get.snackbar('Error', 'Failed to update order status: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to update order status: $e');
      print('Error: $e');
    }
  }

  Future<void> cancelOrder(String orderId, String cancellationReason) async {
    final url = Uri.parse('https://intensely-optimal-unicorn.ngrok-free.app/order/orders/$orderId/cancel/');
    try {
      final response = await http.post(
        url,
        headers: await ApiClient.authHeaders(),
        body: json.encode({'cancellation_reason': cancellationReason}),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar('Success', 'Order canceled successfully');
        // Update the local order status
        final orderIndex = orders.indexWhere((order) => order.orderId == orderId);
        if (orderIndex != -1) {
          orders[orderIndex].status = 'CANCELLED';
          orders.refresh();
        }
        // Refresh orders to ensure consistency
        await fetchOrders();
      } else {
        Get.snackbar('Error', 'Failed to cancel order: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to cancel order: $e');
      print('Error: $e');
    }
  }

  Future<bool> verifyDelivery(String orderId, String code) async {
    final url = Uri.parse('https://intensely-optimal-unicorn.ngrok-free.app/order/orders/$orderId/verify-delivery/');
    try {
      final response = await http.post(
        url,
        headers: await ApiClient.authHeaders(),
        body: json.encode({'delivery_code': code}),
      );
      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Order verified successfully');
        await fetchOrders();
        return true;
      } else {
        Get.snackbar('Error', 'Failed to verify order: ${response.body}');
        return false;
      }
    } catch (e) {
      Get.snackbar('Error', 'Error verifying order: $e');
      return false;
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
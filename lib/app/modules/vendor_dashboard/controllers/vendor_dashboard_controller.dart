import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../data/api_client.dart';
import '../../../data/model/vendor_order.dart';

class VendorDashboardController extends GetxController {
  RxList<VendorOrder> orders = <VendorOrder>[].obs;

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
        print('Failed to load orders');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void onInit() {
    fetchOrders();
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

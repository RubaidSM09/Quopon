import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../data/base_client.dart';
import '../../Cart/controllers/cart_controller.dart';
import '../../OrderDetails/controllers/order_details_controller.dart';
import '../../OrderDetails/views/order_details_view.dart';
import '../views/checkout_web_view.dart';

class CheckoutController extends GetxController {
  // UI state
  final selectedPaymentMethod = "".obs;
  final selectedPaymentMethodLogo = "".obs;

  // Delivery address pulled from profile for DELIVERY
  final deliveryAddress = "".obs;

  // Shared note for both Delivery & Pickup screens
  final noteController = TextEditingController();

  void updatePaymentMethod(String method, String logo) {
    selectedPaymentMethod.value = method;
    selectedPaymentMethodLogo.value = logo;
  }

  @override
  void onInit() {
    super.onInit();
    _fetchProfileAddress();
  }

  Future<void> _fetchProfileAddress() async {
    try {
      final headers = await BaseClient.authHeaders();
      headers['ngrok-skip-browser-warning'] = 'true';

      final res = await http.get(
        Uri.parse("https://intensely-optimal-unicorn.ngrok-free.app/food/my-profile/"),
        headers: headers,
      );
      if (res.statusCode == 200) {
        final profile = json.decode(res.body);
        deliveryAddress.value = (profile["address"] ?? "").toString();
      } else {
        deliveryAddress.value = "";
      }
    } catch (_) {
      deliveryAddress.value = "";
    }
  }

  /// Place order with API (new body), then redirect to Mollie payment flow.
  Future<void> placeOrderAndPay({
    required bool isDelivery,
    required String note,
  }) async {
    try {
      final headers = await BaseClient.authHeaders();
      headers['ngrok-skip-browser-warning'] = 'true';
      headers['Content-Type'] = 'application/json';

      final String addressToSend =
      isDelivery ? (deliveryAddress.value.isEmpty ? "Unknown Address" : deliveryAddress.value) : "N/A";

      final String finalNote =
      (noteController.text.isNotEmpty ? noteController.text : (note.isEmpty ? "No notes" : note));

      final body = {
        "delivery_type": isDelivery ? "DELIVERY" : "PICKUP",
        "delivery_address": addressToSend,
        "order_type": "STANDARD",
        "note": finalNote,
      };

      final orderRes = await http.post(
        Uri.parse("https://intensely-optimal-unicorn.ngrok-free.app/order/orders/create/"),
        headers: headers,
        body: json.encode(body),
      );

      print("ORDER STATUS: ${orderRes.statusCode}");
      print("ORDER BODY: ${orderRes.body}");

      if (orderRes.statusCode == 200 || orderRes.statusCode == 201) {
        final parsed = json.decode(orderRes.body) as Map<String, dynamic>;
        final orderId = parsed['order_id']?.toString();

        if (orderId == null || orderId.isEmpty) {
          Get.snackbar("Order Error", "Missing order_id in response");
          return;
        }

        // ✅ Call new Mollie API
        await foodPayment(orderId: orderId);
      } else {
        Get.snackbar("Order Failed", orderRes.body);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  /// Mollie payment call (NEW endpoint)
  Future<void> foodPayment({required String orderId}) async {
    try {
      final headers = await BaseClient.authHeaders();
      headers['ngrok-skip-browser-warning'] = 'true';
      headers['Content-Type'] = 'application/json';

      final response = await http.post(
        Uri.parse(
            "https://intensely-optimal-unicorn.ngrok-free.app/order/orders/$orderId/process-payment/"),
        headers: headers,
      );

      print("PAYMENT STATUS: ${response.statusCode}");
      print("PAYMENT BODY: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseBody = jsonDecode(response.body);
        final checkoutUrl = responseBody['checkout_url'];

        if (checkoutUrl != null && checkoutUrl.isNotEmpty) {
          Get.to(() => WebViewScreen(
            orderId: orderId,
            url: checkoutUrl,
            onUrlMatched: (bool isCancelled) {
              if (!isCancelled) {
                Get.snackbar("Success", "Order placed successfully!");
              } else {
                Get.snackbar("Cancelled", "Payment cancelled");
              }
              Get.offAll(() => const OrderDetailsView(),
                  arguments: {"order_id": orderId});
            },
          ));
        } else {
          Get.snackbar("Warning", "No checkout url received");
        }
      } else {
        Get.snackbar("Payment Failed", response.body);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../data/base_client.dart';
import '../../Cart/controllers/cart_controller.dart';
import '../../OrderDetails/views/order_details_view.dart';
import '../views/checkout_web_view.dart';

class CheckoutController extends GetxController {
  // UI state
  final selectedPaymentMethod = "".obs;
  final selectedPaymentMethodLogo = "".obs;

  // Delivery address pulled from profile for DELIVERY
  final deliveryAddress = "".obs;

  // Shared note for both Delivery & Pickup screens
  final TextEditingController noteController = TextEditingController();

  void updatePaymentMethod(String method, String logo) {
    selectedPaymentMethod.value = method;
    selectedPaymentMethodLogo.value = logo;
  }

  @override
  void onInit() {
    super.onInit();
    // Preload profile address so Delivery card shows it right away.
    _fetchProfileAddress();
  }

  Future<void> _fetchProfileAddress() async {
    try {
      final headers = await BaseClient.authHeaders();
      final res = await http.get(
        Uri.parse("https://intensely-optimal-unicorn.ngrok-free.app/food/my-profile/"),
        headers: headers,
      );
      if (res.statusCode == 200) {
        final profile = json.decode(res.body);
        deliveryAddress.value = (profile["address"] ?? "").toString();
      } else {
        // Non-fatal; user can still place a PICKUP order.
        deliveryAddress.value = "";
      }
    } catch (_) {
      deliveryAddress.value = "";
    }
  }

  /// Place order with new body, then redirect to Mollie payment checkout.
  /// New body spec:
  /// {
  ///   "delivery_type": "DELIVERY" | "PICKUP",
  ///   "delivery_address": "123 Main St" | "N/A",
  ///   "order_type": "STANDARD",
  ///   "note": "Please deliver ASAP"
  /// }
  Future<void> placeOrderAndPay({
    required bool isDelivery,
    required String note, // we still accept it but will also read from noteController
  }) async {
    try {
      final headers = await BaseClient.authHeaders();

      // If delivery, make sure we have an address (we already fetched on init).
      final String addressToSend =
      isDelivery ? (deliveryAddress.value.isEmpty ? "Unknown Address" : deliveryAddress.value) : "N/A";

      final String finalNote = (noteController.text.isNotEmpty ? noteController.text : (note.isEmpty ? "No notes" : note));

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

      print("Order API => ${orderRes.statusCode}");
      print("Order Body => ${orderRes.body}");

      if (orderRes.statusCode == 200 || orderRes.statusCode == 201) {
        // use actual total from cart for payment amount
        final cart = Get.find<CartController>().currentCart;
        final total = cart?.priceSummary.inTotalPrice ?? 0.0;

        await foodPayment(amount: total.toStringAsFixed(2));
      } else {
        Get.snackbar("Order Failed", orderRes.body);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  /// Mollie payment call (unchanged except amount now from cart total)
  Future<void> foodPayment({required String amount}) async {
    try {
      final headers = await BaseClient.authHeadersFormData();

      final response = await http.post(
        Uri.parse("http://10.10.13.52:7000/discover/payment/"),
        headers: headers,
        body: {"amount": amount},
      );

      print("Payment API => ${response.statusCode}");

      if (response.statusCode == 201) {
        final responseBody = jsonDecode(response.body);
        final checkoutUrl = responseBody['checkout_url'];

        if (checkoutUrl != null && checkoutUrl.isNotEmpty) {
          Get.off(() => WebViewScreen(
            url: checkoutUrl,
            onUrlMatched: (bool isCancelled) {
              if (!isCancelled) {
                Get.snackbar("Success", "Order placed successfully!");
              } else {
                Get.snackbar("Cancelled", "Payment cancelled");
              }
              Get.offAll(() => OrderDetailsView());
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

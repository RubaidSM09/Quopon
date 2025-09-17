import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:quopon/app/modules/OrderDetails/views/order_details_view.dart';

import '../views/checkout_web_view.dart';

class CheckoutController extends GetxController {
  var selectedPaymentMethod = "" .obs;
  var selectedPaymentMethodLogo = "" .obs;

  void updatePaymentMethod(String method, String logo) {
    selectedPaymentMethod.value = method;
    selectedPaymentMethodLogo.value = logo;
  }

  Future<void> foodPayment({
    required String amount,
  }) async {
    try {
      // Call the API with only the amount in the form data
      final response = await http.post(
        Uri.parse('http://10.10.13.52:7000/discover/payment/'), // Replace with your actual API URL
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          // Add any additional headers like authorization if needed
          'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzU4MTM4MjY0LCJpYXQiOjE3NTgxMDk0NjQsImp0aSI6ImNjZjZmMjU5NTliNTQ0Njk5MTlkY2NkOTlmOTUwOGMzIiwidXNlcl9pZCI6IjIyIn0.nYfA0VGV1GX2XkQUleBZ5iTGb1NeTHB03VwwdXqDLJI',
        },
        body: {
          'amount': amount,
          // Add any other required form fields if needed
        },
      );

      if (response.statusCode == 201) {
        final responseBody = jsonDecode(response.body);
        final checkoutUrl = responseBody['checkout_url'];
        final message = responseBody['Message'];

        if (message != null && message.isNotEmpty) {
          Get.snackbar('Message', message);
        } else if (checkoutUrl != null && checkoutUrl.isNotEmpty) {
          print(':::::::::checkout_url:::::::::::::::::::::::::::::$checkoutUrl');
          Get.off(() => WebViewScreen(
            url: checkoutUrl,
            onUrlMatched: (bool isCancelled) {
              if (!isCancelled) {
                // Since packageName and packageType are not passed, avoid referencing them
                Get.snackbar('success'.tr, 'package_purchased_successfully'.tr);
              } else {
                Get.snackbar('cancelled'.tr, 'package_purchase_cancelled'.tr);
              }
              Get.offAll(() => OrderDetailsView());
            },
          ));
        } else {
          Get.snackbar('warning'.tr, 'unexpected_response_please_try_again'.tr);
        }
      } else {
        Get.snackbar('warning'.tr, 'failed_to_purchase_subscription'.tr);
      }
    } catch (e) {
      print('$e');
      Get.snackbar('warning'.tr, '$e');
    }
  }

  // final count = 0.obs;
  // @override
  // void onInit() {
  //   super.onInit();
  // }
  //
  // @override
  // void onReady() {
  //   super.onReady();
  // }
  //
  // @override
  // void onClose() {
  //   super.onClose();
  // }
  //
  // void increment() => count.value++;
}

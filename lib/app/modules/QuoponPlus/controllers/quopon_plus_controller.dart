// quopon_plus_controller.dart
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:quopon/app/data/api_client.dart';
import '../../../data/model/subscription_plan.dart';
import '../../Checkout/views/checkout_web_view.dart';

class QuoponPlusController extends GetxController {
  final isLoading = false.obs;
  final isSubscribing = false.obs;
  final error = RxnString();
  final plans = <SubscriptionPlan>[].obs;

  final isMonthly = true.obs;

  SubscriptionPlan? get monthlyPlan => _findBy('month');
  SubscriptionPlan? get yearlyPlan  => _findBy('year');

  SubscriptionPlan? _findBy(String keyword) {
    final k = keyword.toLowerCase();
    for (final p in plans) {
      if (p.name.toLowerCase().contains(k)) return p;
    }
    return null;
  }

  Future<void> fetchPlans() async {
    try {
      isLoading.value = true;
      error.value = null;

      final http.Response res = await ApiClient.get('/subscription/plans/');
      if (res.statusCode >= 200 && res.statusCode < 300) {
        final body = jsonDecode(res.body);
        if (body is List) {
          plans.value = body
              .map((e) => SubscriptionPlan.fromJson(e as Map<String, dynamic>))
              .toList();
        } else {
          throw 'Unexpected response shape';
        }
      } else if (res.statusCode == 401) {
        throw 'Unauthorized (401). Please log in again.';
      } else {
        throw 'Request failed (${res.statusCode}).';
      }
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  /// --- Start Mollie checkout for a plan (with redirect_url) ---
  Future<void> subscribe(SubscriptionPlan plan) async {
    try {
      isSubscribing.value = true;
      error.value = null;

      // Choose the URL your backend will redirect to after payment success.
      // Use your real frontend URL or a dedicated confirmation endpoint.
      final successUrl = 'https://your-frontend-app.com/subscription/success/plan_${plan.id}/';
      final cancelUrl  = 'https://your-frontend-app.com/subscription/cancel/';

      final http.Response res = await ApiClient.post(
        '/subscription/subscribe/${plan.id}/',
        {
          'redirect_url': successUrl, // << REQUIRED by your API
        },
      );

      if (res.statusCode >= 200 && res.statusCode < 300) {
        final data = jsonDecode(res.body);
        final checkoutUrl = (data['checkout_url'] ?? '').toString();
        if (checkoutUrl.isEmpty) throw 'checkout_url missing in response';

        await Get.to(() => WebViewScreen(
          url: checkoutUrl,
          orderId: 'plan_${plan.id}',            // just a tag
          onUrlMatched: (bool isCancelled) {
            if (isCancelled) {
              Get.snackbar('Payment cancelled', 'You can try again anytime.');
            } else {
              Get.snackbar('Success', 'Subscription activated.');
              fetchPlans(); // optional refresh
            }
          },
          // NEW: pass the URLs so WebView can detect them
          successUrl: successUrl,
          cancelUrl: cancelUrl,
        ));
      } else if (res.statusCode == 401) {
        throw 'Unauthorized (401). Please log in again.';
      } else {
        throw 'Subscribe failed (${res.statusCode}).';
      }
    } catch (e) {
      error.value = e.toString();
      Get.snackbar('Subscription error', error.value!);
    } finally {
      isSubscribing.value = false;
    }
  }

  @override
  void onReady() {
    super.onReady();
    fetchPlans();
  }
}

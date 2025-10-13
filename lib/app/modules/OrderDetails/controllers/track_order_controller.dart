// lib/app/modules/OrderDetails/controllers/track_order_controller.dart
import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:quopon/app/data/api_client.dart';

import '../../../services/review_prompt_service.dart';
import '../../Review/views/review_view.dart';

class TrackOrderController extends GetxController {
  var currentStep = 0.obs;
  var title = 'Order Received'.obs;
  var gif = 'assets/images/OrderDetails/OrderConfirmed.gif'.obs;
  var status = ''.obs;
  var deliveryType = ''.obs;
  var orderData = <String, dynamic>{}.obs;
  late String orderId;
  Timer? timer;

  // Ensure we only show the review once
  bool _reviewShown = false;

  @override
  void onInit() {
    super.onInit();
    orderId = Get.arguments as String;
    fetchOrder();
    timer = Timer.periodic(const Duration(seconds: 10), (t) => fetchOrder());
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }

  Future<void> fetchOrder() async {
    try {
      final response = await http.get(
        Uri.parse('https://doctorless-stopperless-turner.ngrok-free.dev/order/orders/$orderId/'),
        headers: await ApiClient.authHeaders(),
      );
      if (response.statusCode == 200) {
        orderData.value = jsonDecode(response.body);

        // Normalize fields
        status.value = (orderData['status'] ?? '').toString();
        deliveryType.value = (orderData['delivery_type'] ?? '').toString();

        updateStep();
        _maybePromptReview(); // <- show review (by NAME) when done
      }
    } catch (_) {}
  }

  void updateStep() {
    int newStep = 0;
    String newTitle = 'Order Received';
    String newGif = 'assets/images/OrderDetails/OrderConfirmed.gif';

    final s = status.value.toUpperCase();
    final dType = deliveryType.value.toUpperCase();

    switch (s) {
      case 'RECEIVED':
        newStep = 0;
        newTitle = 'Order Received';
        newGif = 'assets/images/OrderDetails/OrderConfirmed.gif';
        break;

      case 'PREPARING':
        newStep = 1;
        newTitle = 'Preparing Your Food';
        newGif = 'assets/images/OrderDetails/Cooking.gif';
        break;

      case 'OUT_FOR_DELIVERY':
        newStep = 2;
        newTitle = 'Out for Delivery';
        newGif = 'assets/images/OrderDetails/Cooking.gif';
        break;

      case 'READY_FOR_PICKUP':
        newStep = 2;
        newTitle = 'Ready for Pickup';
        newGif = 'assets/images/OrderDetails/Cooking.gif';
        break;

      case 'DELIVERED':
        newStep = 3;
        newTitle = 'Order Delivered';
        newGif = 'assets/images/OrderDetails/OrderConfirmed.gif';
        break;

      case 'PICKEDUP':
        newStep = 3;
        newTitle = 'Order Picked Up';
        newGif = 'assets/images/OrderDetails/OrderConfirmed.gif';
        break;

    // COMPLETED = last step; label depends on delivery type
      case 'COMPLETED':
        newStep = 3;
        if (dType == 'DELIVERY' || dType == 'DELIVERED') {
          newTitle = 'Order Delivered';
        } else {
          newTitle = 'Order Picked Up';
        }
        newGif = 'assets/images/OrderDetails/OrderConfirmed.gif';
        break;

      default:
        newStep = 0;
        newTitle = 'Order Received';
        newGif = 'assets/images/OrderDetails/OrderConfirmed.gif';
    }

    currentStep.value = newStep;
    title.value = newTitle;
    gif.value = newGif;
  }

  // ---------- Open review dialog once order is finished (by NAME) ----------
  void _maybePromptReview() {
    if (_reviewShown) return;

    final s = status.value.toUpperCase();
    final finished = s == 'DELIVERED' || s == 'PICKEDUP' || s == 'COMPLETED';
    if (!finished) return;

    final items = (orderData['items'] as List?) ?? const [];
    if (items.isEmpty) return;

    final first = (items.first as Map<String, dynamic>?) ?? const {};
    final menuName = _asString(first['item_name']) ??
        _asString(first['title']) ??
        _asString(first['name']);

    if (menuName == null || menuName.trim().isEmpty) return;

    _reviewShown = true;

    // NEW: schedule the review 5 minutes from now (or from server-delivered time if you have it)
    ReviewPromptService.to.scheduleReview(
      orderId: orderId,
      menuName: menuName.trim(),
      // deliveredAt: parse from orderData if you have server clock, otherwise omit to use now
    );

    // Optional UX hint:
    // Get.snackbar('Thanks!', 'We’ll ask for a quick review in about 5 minutes.');
  }

  String? _asString(dynamic v) {
    if (v == null) return null;
    final s = v.toString();
    return s.isEmpty ? null : s;
  }
}

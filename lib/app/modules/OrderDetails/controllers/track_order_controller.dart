// TrackOrderController.dart
import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:quopon/app/data/api_client.dart';

class TrackOrderController extends GetxController {
  var currentStep = 0.obs;
  var title = 'Order Received'.obs;
  var gif = 'assets/images/OrderDetails/OrderConfirmed.gif'.obs;
  var status = ''.obs;
  var deliveryType = ''.obs;
  var orderData = <String, dynamic>{}.obs;
  late String orderId;
  Timer? timer;

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
        Uri.parse('https://intensely-optimal-unicorn.ngrok-free.app/order/orders/$orderId/'),
        headers: await ApiClient.authHeaders()
      );
      if (response.statusCode == 200) {
        orderData.value = jsonDecode(response.body);
        status.value = orderData['status'];
        deliveryType.value = orderData['delivery_type'];
        updateStep();
      }
    } catch (e) {
      // Error handling can be added here if needed
    }
  }

  void updateStep() {
    int newStep = 0;
    String newTitle = 'Order Received';
    String newGif = 'assets/images/OrderDetails/OrderConfirmed.gif';
    switch (status.value) {
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
        newGif = 'assets/images/OrderDetails/Cooking.gif'; // Reuse existing GIF if specific not available
        break;
      case 'READY_FOR_PICKUP':
        newStep = 2;
        newTitle = 'Ready for Pickup';
        newGif = 'assets/images/OrderDetails/Cooking.gif'; // Reuse existing GIF if specific not available
        break;
      case 'DELIVERED':
        newStep = 3;
        newTitle = 'Order Delivered';
        newGif = 'assets/images/OrderDetails/OrderConfirmed.gif'; // Reuse existing GIF if specific not available
        break;
      case 'PICKEDUP':
        newStep = 3;
        newTitle = 'Order Picked Up';
        newGif = 'assets/images/OrderDetails/OrderConfirmed.gif'; // Reuse existing GIF if specific not available
        break;
      default:
        newStep = 0;
    }
    currentStep.value = newStep;
    title.value = newTitle;
    gif.value = newGif;
  }
}

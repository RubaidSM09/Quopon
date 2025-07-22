import 'package:get/get.dart';

class CheckoutController extends GetxController {
  var selectedPaymentMethod = 'None' .obs;

  void updatePaymentMethod(String method) {
    selectedPaymentMethod.value = method;
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

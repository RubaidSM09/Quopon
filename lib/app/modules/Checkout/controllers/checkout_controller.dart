import 'package:get/get.dart';

class CheckoutController extends GetxController {
  var selectedPaymentMethod = "" .obs;
  var selectedPaymentMethodLogo = "" .obs;

  void updatePaymentMethod(String method, String logo) {
    selectedPaymentMethod.value = method;
    selectedPaymentMethodLogo.value = logo;
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

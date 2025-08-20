import 'package:get/get.dart';

class MyOrdersVendorDeliveryController extends GetxController {
  RxList<RxBool> filters = [true.obs, false.obs, false.obs, false.obs, false.obs, false.obs].obs;

  final count = 0.obs;
  @override
  void onInit() {
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

  void increment() => count.value++;
}

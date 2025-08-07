import 'package:get/get.dart';

import '../controllers/my_orders_vendors_controller.dart';

class MyOrdersVendorsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyOrdersVendorsController>(
      () => MyOrdersVendorsController(),
    );
  }
}

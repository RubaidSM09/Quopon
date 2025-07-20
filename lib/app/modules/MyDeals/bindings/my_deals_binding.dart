import 'package:get/get.dart';

import '../controllers/my_deals_controller.dart';

class MyDealsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyDealsController>(
      () => MyDealsController(),
    );
  }
}

import 'package:get/get.dart';

import '../controllers/quopon_plus_controller.dart';

class QuoponPlusBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuoponPlusController>(
      () => QuoponPlusController(),
    );
  }
}

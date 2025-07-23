import 'package:get/get.dart';

import '../controllers/support_f_a_q_controller.dart';

class SupportFAQBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SupportFAQController>(
      () => SupportFAQController(),
    );
  }
}

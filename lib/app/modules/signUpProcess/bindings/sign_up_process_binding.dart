import 'package:get/get.dart';

import 'package:quopon/app/modules/signUpProcess/controllers/sign_up_process_vendor_controller.dart';

import '../controllers/sign_up_process_controller.dart';

class SignUpProcessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpProcessVendorController>(
      () => SignUpProcessVendorController(),
    );
    Get.lazyPut<SignUpProcessController>(
      () => SignUpProcessController(),
    );
  }
}

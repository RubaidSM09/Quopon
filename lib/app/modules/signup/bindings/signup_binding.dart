import 'package:get/get.dart';

import 'package:quopon/app/modules/signup/controllers/signup_vendor_controller.dart';

import '../controllers/signup_controller.dart';

class SignupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignupVendorController>(
      () => SignupVendorController(),
    );
    Get.lazyPut<SignupController>(
      () => SignupController(),
    );
  }
}

import 'package:get/get.dart';

import 'package:quopon/app/modules/login/controllers/login_vendor_controller.dart';

import '../controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginVendorController>(
      () => LoginVendorController(),
    );
    Get.lazyPut<LoginController>(
      () => LoginController(),
    );
  }
}

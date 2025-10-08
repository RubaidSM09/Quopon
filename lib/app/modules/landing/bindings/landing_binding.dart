import 'package:get/get.dart';

import 'package:quopon/app/modules/landing/controllers/landing_vendor_controller.dart';

import '../controllers/landing_controller.dart';

class LandingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LandingVendorController>(
      () => LandingVendorController(),
    );
    Get.lazyPut<LandingController>(
      () => LandingController(),
    );
  }
}

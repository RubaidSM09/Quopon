import 'package:get/get.dart';

import 'package:quopon/app/modules/onboarding/controllers/onboarding_vendor_controller.dart';

import '../controllers/onboarding_controller.dart';

class OnboardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnboardingVendorController>(
      () => OnboardingVendorController(),
    );
    Get.lazyPut<OnboardingController>(
      () => OnboardingController(),
    );
  }
}

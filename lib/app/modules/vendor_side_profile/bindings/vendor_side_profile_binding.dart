import 'package:get/get.dart';

import 'package:quopon/app/modules/vendor_side_profile/controllers/my_followers_controller.dart';

import '../controllers/vendor_side_profile_controller.dart';

class VendorSideProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyFollowersController>(
      () => MyFollowersController(),
    );
    Get.lazyPut<VendorSideProfileController>(
      () => VendorSideProfileController(),
    );
  }
}

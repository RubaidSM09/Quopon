import 'package:get/get.dart';

import 'package:quopon/app/modules/Profile/controllers/city_controller.dart';
import 'package:quopon/app/modules/Profile/controllers/country_controller.dart';
import 'package:quopon/app/modules/Profile/controllers/edit_profile_controller.dart';
import 'package:quopon/app/modules/Profile/controllers/follow_vendors_controller.dart';

import '../controllers/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditProfileController>(
      () => EditProfileController(),
    );
    Get.lazyPut<FollowVendorsController>(
      () => FollowVendorsController(),
    );
    Get.lazyPut<CityController>(
      () => CityController(),
    );
    Get.lazyPut<CountryController>(
      () => CountryController(),
    );
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
  }
}

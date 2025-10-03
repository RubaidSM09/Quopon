// lib/app/modules/landing/controllers/landing_controller.dart
import 'package:get/get.dart';
import 'package:quopon/app/modules/MyDeals/controllers/my_deals_controller.dart'; // 👈 add

class LandingController extends GetxController {
  var currentIndex = 0.obs;

  void updateIndex(int index) {
    currentIndex.value = index;

    // If switching to My Deals tab, refresh its data
    if (index == 3) {
      final c = Get.isRegistered<MyDealsController>()
          ? Get.find<MyDealsController>()
          : Get.put(MyDealsController()); // instantiate if not already
      c.fetchMyDeals();
    }
  }
}

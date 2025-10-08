// lib/app/modules/landing/controllers/landing_controller.dart
import 'package:get/get.dart';
import 'package:quopon/app/modules/MyDeals/controllers/my_deals_controller.dart';
import 'package:quopon/app/modules/home/controllers/home_controller.dart';
import 'package:quopon/app/modules/discover/controllers/discover_controller.dart';
import 'package:quopon/app/modules/QRScanner/controllers/q_r_scanner_controller.dart';
import 'package:quopon/app/modules/Profile/controllers/profile_controller.dart';

class LandingController extends GetxController {
  var currentIndex = 0.obs;

  // simple debounce guard so rapid taps don’t spam network
  bool _busy = false;

  void updateIndex(int index) async {
    if (_busy) return;
    _busy = true;

    currentIndex.value = index;
    await _refreshForIndex(index);

    _busy = false;
  }

  Future<void> _refreshForIndex(int index) async {
    switch (index) {
      case 0: // Home
        final c = Get.isRegistered<HomeController>()
            ? Get.find<HomeController>()
            : Get.put(HomeController());
        await c.refreshAll();
        break;

      case 1: // Discover
        final c = Get.isRegistered<DiscoverController>()
            ? Get.find<DiscoverController>()
            : Get.put(DiscoverController());
        await c.refreshAll();
        break;

      case 2: // QR Scanner
        final c = Get.isRegistered<QRScannerController>()
            ? Get.find<QRScannerController>()
            : Get.put(QRScannerController());
        await c.refreshAll();
        break;

      case 3: // My Deals
        final c = Get.isRegistered<MyDealsController>()
            ? Get.find<MyDealsController>()
            : Get.put(MyDealsController());
        await c.fetchMyDeals();
        break;

      case 4: // Profile
        final c = Get.isRegistered<ProfileController>()
            ? Get.find<ProfileController>()
            : Get.put(ProfileController());
        await c.refreshAll();
        break;
    }
  }
}

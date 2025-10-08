// lib/app/modules/landing/controllers/landing_vendor_controller.dart
import 'package:get/get.dart';
import 'package:quopon/app/modules/vendor_dashboard/controllers/vendor_dashboard_controller.dart';
import 'package:quopon/app/modules/vendor_deals/controllers/vendor_deals_controller.dart';
import 'package:quopon/app/modules/qr_scanner_vendor/controllers/qr_scanner_vendor_controller.dart';
import 'package:quopon/app/modules/my_orders_vendors/controllers/my_orders_vendors_controller.dart';
import 'package:quopon/app/modules/vendor_side_profile/controllers/vendor_side_profile_controller.dart';

class LandingVendorController extends GetxController {
  final currentIndex = 0.obs;
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
      case 0: // Dashboard
        final c = Get.isRegistered<VendorDashboardController>()
            ? Get.find<VendorDashboardController>()
            : Get.put(VendorDashboardController());
        await c.refreshAll();
        break;

      case 1: // Deals
        final c = Get.isRegistered<VendorDealsController>()
            ? Get.find<VendorDealsController>()
            : Get.put(VendorDealsController());
        await c.refreshAll();
        break;

      case 2: // QR (vendor)
        final c = Get.isRegistered<QrScannerVendorController>()
            ? Get.find<QrScannerVendorController>()
            : Get.put(QrScannerVendorController());
        await c.refreshAll();
        break;

      case 3: // Orders
        final c = Get.isRegistered<MyOrdersVendorsController>()
            ? Get.find<MyOrdersVendorsController>()
            : Get.put(MyOrdersVendorsController());
        await c.refreshAll();
        break;

      case 4: // Profile
        final c = Get.isRegistered<VendorSideProfileController>()
            ? Get.find<VendorSideProfileController>()
            : Get.put(VendorSideProfileController());
        await c.refreshAll();
        break;
    }
  }
}

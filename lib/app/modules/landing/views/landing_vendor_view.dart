import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quopon/app/modules/my_orders_vendors/views/my_orders_vendors_view.dart';
import 'package:quopon/app/modules/qr_scanner_vendor/views/qr_scanner_vendor_view.dart';
import 'package:quopon/app/modules/vendor_dashboard/views/vendor_dashboard_view.dart';
import 'package:quopon/app/modules/vendor_deals/views/vendor_deals_view.dart';
import 'package:quopon/app/modules/vendor_menu/views/vendor_menu_view.dart';
import 'package:quopon/app/modules/vendor_side_profile/views/vendor_side_profile_view.dart';

import '../../../../common/CustomNavBar.dart';
import '../../QRScanner/views/q_r_scanner_view.dart';
import '../../my_orders_vendors/controllers/my_orders_vendors_controller.dart';
import '../controllers/landing_controller.dart';

class LandingVendorView extends GetView {
  const LandingVendorView({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LandingController());

    final ordersCtrl = Get.put(MyOrdersVendorsController(), permanent: true);

    final List<Widget> pages = [
      VendorDashboardView(),
      VendorDealsView(),
      QrScannerVendorView(),
      // VendorMenuView(),
      MyOrdersVendorsView(),
      VendorSideProfileView(),
    ];

    return Scaffold(
      body: Obx(() {
        final idx = controller.currentIndex.value;

        // If user navigates to the "Orders" tab, refresh the list.
        if (idx == 3) {
          // microtask so it doesn't block build
          Future.microtask(() => ordersCtrl.fetchOrders());
        }

        return pages[idx];
      }),
      bottomNavigationBar: const VendorNavigationBar(),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quopon/app/modules/vendor_dashboard/views/vendor_dashboard_view.dart';
import 'package:quopon/app/modules/vendor_deals/views/vendor_deals_view.dart';
import 'package:quopon/app/modules/vendor_menu/views/vendor_menu_view.dart';
import 'package:quopon/app/modules/vendor_side_profile/views/vendor_side_profile_view.dart';

import '../../../../common/CustomNavBar.dart';
import '../../QRScanner/views/q_r_scanner_view.dart';
import '../controllers/landing_controller.dart';

class LandingVendorView extends GetView {
  const LandingVendorView({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LandingController());

    final List<Widget> pages = [
      VendorDashboardView(),
      VendorDealsView(),
      QRScannerView(),
      VendorMenuView(),
      VendorSideProfileView(),
    ];

    return Scaffold(
      body: Obx(() => pages[controller.currentIndex.value]),

      bottomNavigationBar: const VendorNavigationBar(),
    );
  }
}

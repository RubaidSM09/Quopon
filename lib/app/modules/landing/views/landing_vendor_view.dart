// lib/app/modules/landing/views/landing_vendor_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quopon/app/modules/my_orders_vendors/views/my_orders_vendors_view.dart';
import 'package:quopon/app/modules/qr_scanner_vendor/views/qr_scanner_vendor_view.dart';
import 'package:quopon/app/modules/vendor_dashboard/views/vendor_dashboard_view.dart';
import 'package:quopon/app/modules/vendor_deals/views/vendor_deals_view.dart';
import 'package:quopon/app/modules/vendor_side_profile/views/vendor_side_profile_view.dart';

import '../../../../common/CustomNavBar.dart';
import '../controllers/landing_vendor_controller.dart';

class LandingVendorView extends GetView<LandingVendorController> {
  const LandingVendorView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LandingVendorController());

    final pages = <Widget>[
      VendorDashboardView(),
      VendorDealsView(),
      QrScannerVendorView(),
      MyOrdersVendorsView(),
      VendorSideProfileView(),
    ];

    return Scaffold(
      body: Obx(() => pages[controller.currentIndex.value]),
      bottomNavigationBar: const VendorNavigationBar(), // unchanged name, now uses vendor controller
    );
  }
}

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quopon/app/modules/MyDeals/views/my_deals_view.dart';
import 'package:quopon/app/modules/Profile/views/profile_view.dart';
import 'package:quopon/app/modules/QRScanner/views/q_r_scanner_view.dart';
import 'package:quopon/app/modules/deals/views/deals_view.dart';
import 'package:quopon/app/modules/home/views/home_view.dart';
import 'package:quopon/common/CustomNavBar.dart';

import '../controllers/landing_controller.dart';

class LandingView extends GetView<LandingController> {
  const LandingView({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LandingController());

    final List<Widget> pages = [
      HomeView(),
      DealsView(),
      QRScannerView(),
      MyDealsView(),
      ProfileView(),
    ];

    return Scaffold(
      body: Obx(() => pages[controller.currentIndex.value]),

      bottomNavigationBar: const CustomNavigationBar(),
    );
  }
}

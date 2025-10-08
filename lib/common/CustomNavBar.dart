import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../app/modules/landing/controllers/landing_controller.dart';
import '../app/modules/landing/controllers/landing_vendor_controller.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LandingController>();

    final List<Map<String, String>> navItems = [
      {
        'label': 'Home',
        'filledIcon': 'assets/images/BottomNavigation/Home Active.svg',
        'defaultIcon': 'assets/images/BottomNavigation/Home.svg',
      },
      {
        'label': 'Discover',
        'filledIcon': 'assets/images/BottomNavigation/Discover Active.svg',
        'defaultIcon': 'assets/images/BottomNavigation/Discover.svg',
      },
      {
        'label': '',
        'filledIcon': 'assets/images/BottomNavigation/Scan.svg',
        'defaultIcon': 'assets/images/BottomNavigation/Scan.svg',
      },
      {
        'label': 'My Deals',
        'filledIcon': 'assets/images/BottomNavigation/My Deals Active.svg',
        'defaultIcon': 'assets/images/BottomNavigation/My Deals.svg',
      },
      {
        'label': 'Profile',
        'filledIcon': 'assets/images/BottomNavigation/Profile Active.svg',
        'defaultIcon': 'assets/images/BottomNavigation/Profile.svg',
      },
    ];

    return Container(
        height: 92.h, // Set the desired height
        color: Colors.white,
        padding: EdgeInsets.all(16.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(navItems.length, (index) {
            final item = navItems[index];
            return GestureDetector(
              onTap: () => controller.updateIndex(index),
              child: Obx(() {
                final isSelected = index == controller.currentIndex.value;
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200), // Smooth transition duration
                  transitionBuilder: (child, animation) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        isSelected ? item['filledIcon']! : item['defaultIcon']!,
                        key: ValueKey('${item['label']}_$isSelected'),
                      ),
                      item['label'] != '' ?
                      Text(
                        item['label']!,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                          color: isSelected ? Color(0xFFD62828) : Color(0xFF6F7E8D)
                        ),
                      ) : SizedBox.shrink(),
                    ],
                  ),
                );
              }),
            );
          }),
        ),
      );
  }
}

class VendorNavigationBar extends StatelessWidget {
  const VendorNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LandingVendorController>();

    final navItems = [
      {
        'label': 'Dashboard',
        'filledIcon': 'assets/images/BottomNavigation/Dashboard Active.svg',
        'defaultIcon': 'assets/images/BottomNavigation/Dashboard.svg',
      },
      {
        'label': 'Deals',
        'filledIcon': 'assets/images/BottomNavigation/Deals Active.svg',
        'defaultIcon': 'assets/images/BottomNavigation/Deals.svg',
      },
      {
        'label': '',
        'filledIcon': 'assets/images/BottomNavigation/Scan.svg',
        'defaultIcon': 'assets/images/BottomNavigation/Scan.svg',
      },
      {
        'label': 'Orders',
        'filledIcon': 'assets/images/BottomNavigation/Orders Active.svg',
        'defaultIcon': 'assets/images/BottomNavigation/Orders.svg',
      },
      {
        'label': 'Profile',
        'filledIcon': 'assets/images/BottomNavigation/Profile Active.svg',
        'defaultIcon': 'assets/images/BottomNavigation/Profile.svg',
      },
    ];

    return Container(
      height: 92.h,
      color: Colors.white,
      padding: EdgeInsets.all(16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(navItems.length, (index) {
          final item = navItems[index];
          return GestureDetector(
            onTap: () => controller.updateIndex(index),
            child: Obx(() {
              final isSelected = index == controller.currentIndex.value;
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: Column(
                  children: [
                    SvgPicture.asset(
                      isSelected ? item['filledIcon']! : item['defaultIcon']!,
                      key: ValueKey('${item['label']}_$isSelected'),
                    ),
                    item['label']!.isNotEmpty
                        ? Text(
                      item['label']!,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12.sp,
                        color: isSelected ? const Color(0xFFD62828) : const Color(0xFF6F7E8D),
                      ),
                    )
                        : const SizedBox.shrink(),
                  ],
                ),
              );
            }),
          );
        }),
      ),
    );
  }
}

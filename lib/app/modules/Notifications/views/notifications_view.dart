import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quopon/app/modules/Notifications/views/notifications_card_view.dart';
import 'package:quopon/app/modules/Notifications/views/notifications_settings_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil

import '../../Notifications/controllers/notifications_controller.dart';

class NotificationsView extends GetView<NotificationsController> {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF9FBFC),
        title: Center(
          child: Text(
            'Notifications',
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500, color: Color(0xFF020711)), // ScreenUtil applied
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Get.to(NotificationsSettingsView());
            },
            child: Image.asset("assets/images/Notifications/Notification Settings.png"),
          ),
        ],
      ),
      backgroundColor: Color(0xFFF9FBFC),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // TODAY Section
            Container(
              padding: EdgeInsets.all(16.w), // ScreenUtil applied
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'TODAY',
                    style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)), // ScreenUtil applied
                  ),
                  SizedBox.shrink()
                ],
              ),
            ),
            NotificationsCardView(
              isChecked: false,
              icon: 'assets/images/Notifications/Flame.png',
              iconBg: Color(0xFFFF6C3D),
              title: 'Limited-Time Flash Deal!',
              time: 'Today',
              description: 'Sweet Scoops just dropped a 1-hour exclusive offer. Don’t miss it!',
            ),
            NotificationsCardView(
              isChecked: false,
              icon: 'assets/images/Notifications/Flame.png',
              iconBg: Color(0xFFFF6C3D),
              title: 'New Deal from Urban Wok!',
              time: 'Today',
              description: '🔥 Save 25% on all noodle bowls this weekend only. HURRY UP',
            ),

            // YESTERDAY Section
            Container(
              padding: EdgeInsets.all(16.w), // ScreenUtil applied
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'YESTERDAY',
                    style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)), // ScreenUtil applied
                  ),
                  SizedBox.shrink()
                ],
              ),
            ),
            NotificationsCardView(
              isChecked: true,
              icon: 'assets/images/Notifications/Diamond.png',
              iconBg: Color(0xFFD62828),
              title: 'Your Qoupon+ Trial is Ending Soon',
              time: 'Yesterday',
              description: 'Upgrade now to keep enjoying full access to premium deals.',
            ),
            NotificationsCardView(
              isChecked: true,
              icon: 'assets/images/Notifications/Star.png',
              iconBg: Color(0xFFFFA81C),
              title: 'Vendor Replied to Your Review',
              time: 'Yesterday',
              description: 'Grill House responded to your feedback on deal. Tap to view',
            ),
            NotificationsCardView(
              isChecked: true,
              icon: 'assets/images/Notifications/Flame.png',
              iconBg: Color(0xFFFF6C3D),
              title: 'Limited-Time Flash Deal!',
              time: 'Yesterday',
              description: 'Sweet Scoops just dropped a 1-hour exclusive offer. Don’t miss it!',
            ),
            NotificationsCardView(
              isChecked: true,
              icon: 'assets/images/Notifications/Flame.png',
              iconBg: Color(0xFFFF6C3D),
              title: 'New Deal from Urban Wok!',
              time: 'Yesterday',
              description: '🔥 Save 25% on all noodle bowls this weekend only. HURRY UP',
            ),

            // Date Section
            Container(
              padding: EdgeInsets.all(16.w), // ScreenUtil applied
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Jun 9, 2024',
                    style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)), // ScreenUtil applied
                  ),
                  SizedBox.shrink()
                ],
              ),
            ),
            NotificationsCardView(
              isChecked: true,
              icon: 'assets/images/Notifications/DealExpired.png',
              iconBg: Color(0xFFD62828),
              title: 'Expired Deal',
              time: 'Jun 9, 2025',
              description: 'Your deal for Buy 1 Get 1 at Pizza Place has expired. Explore more deals',
            ),
            NotificationsCardView(
              isChecked: true,
              icon: 'assets/images/Notifications/DealExpireSoon.png',
              iconBg: Color(0xFF2ECC71),
              title: 'Your Deal is Expiring Soon!',
              time: 'Jun 9, 2025',
              description: 'Free Coffee at Daily Brew expires tomorrow at 11:59 PM.',
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quopon/app/modules/Notifications/controllers/notifications_controller.dart';

class NotificationsSettingsCardView extends GetView {
  final String title;
  final String description;
  final bool isActive;
  final RxBool isSwitched; // Local RxBool for this widget

  NotificationsSettingsCardView({
    required this.title,
    required this.description,
    required this.isActive,
    super.key,
  }) : isSwitched = isActive.obs; // Initialize RxBool with isActive

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xFF020711)),
            ),
            Text(
              description,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)),
            ),
          ],
        ),
        Obx(() {
          return Theme(
            data: ThemeData(
              primarySwatch: Colors.red,
            ),
            child: Switch(
              value: isSwitched.value,
              onChanged: (value) {
                // Update the local state
                isSwitched.value = value;
                // Optionally, notify the controller if needed
                // Get.find<NotificationsController>().updateSwitchState(title, value);
              },
              activeColor: Colors.white,
              activeTrackColor: Color(0xFFD62828),
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: Color(0xFFBAC9D8),
            ),
          );
        }),
      ],
    );
  }
}
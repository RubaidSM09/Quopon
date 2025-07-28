import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileCard extends GetView {
  final String icon;
  final String title;
  final bool isActive;

  const ProfileCard({
    super.key,
    required this.icon,
    required this.title,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    RxBool isSwitched = true.obs;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFFDF4F4)
              ),
              padding: EdgeInsets.all(8),
              child: Image.asset(icon,),
            ),
            SizedBox(width: 15,),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16,),
            )
          ],
        ),
        isActive ?
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
        }) :
        Image.asset(
          "assets/images/Profile/NextArrow.png",
          height: 18,
          width: 18,
        ),
      ],
    );
  }
}

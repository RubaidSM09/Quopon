import 'package:flutter/material.dart';

import 'package:get/get.dart';

class VendorBusinessHourRowView extends GetView {
  final bool isActive;
  final RxBool isSwitched;
  final String day;
  final String startTime;
  final String endTime;

  VendorBusinessHourRowView({
    super.key,
    required this.isActive,
    required this.day,
    required this.startTime,
    required this.endTime,
  }) : isSwitched = isActive.obs;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
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

        Text(
          day,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xFF020711)),
        ),

        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Color(0xFFF4F6F7),
              border: Border.all(color: Color(0xFFEAECED))
          ),
          child: Row(
            children: [
              Text(
                startTime,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)),
              ),
              SizedBox(width: 5,),
              Image.asset('assets/images/BusinessHour/Time.png'),
            ],
          ),
        ),

        Text(
          'to',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)),
        ),

        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Color(0xFFF4F6F7),
              border: Border.all(color: Color(0xFFEAECED))
          ),
          child: Row(
            children: [
              Text(
                endTime,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)),
              ),
              SizedBox(width: 5,),
              Image.asset('assets/images/BusinessHour/Time.png'),
            ],
          ),
        )
      ],
    );
  }
}

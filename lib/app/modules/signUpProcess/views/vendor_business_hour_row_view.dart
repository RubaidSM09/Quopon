import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil

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
              },
              activeColor: Colors.white,
              activeTrackColor: Color(0xFFD62828),
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: Color(0xFFBAC9D8),
            ),
          );
        }),

        // Day text
        Text(
          day,
          style: TextStyle(
            fontSize: 16.sp, // Apply ScreenUtil to font size
            fontWeight: FontWeight.w400,
            color: Color(0xFF020711),
          ),
        ),

        // Start time container
        Container(
          padding: EdgeInsets.all(12.r), // Apply ScreenUtil to padding
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r), // Apply ScreenUtil to border radius
            color: Color(0xFFF4F6F7),
            border: Border.all(color: Color(0xFFEAECED)),
          ),
          child: Row(
            children: [
              Text(
                startTime,
                style: TextStyle(
                  fontSize: 14.sp, // Apply ScreenUtil to font size
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF6F7E8D),
                ),
              ),
              SizedBox(width: 5.w), // Apply ScreenUtil to width
              Image.asset('assets/images/BusinessHour/Time.png'),
            ],
          ),
        ),

        // "to" text
        Text(
          'to',
          style: TextStyle(
            fontSize: 16.sp, // Apply ScreenUtil to font size
            fontWeight: FontWeight.w400,
            color: Color(0xFF6F7E8D),
          ),
        ),

        // End time container
        Container(
          padding: EdgeInsets.all(12.r), // Apply ScreenUtil to padding
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r), // Apply ScreenUtil to border radius
            color: Color(0xFFF4F6F7),
            border: Border.all(color: Color(0xFFEAECED)),
          ),
          child: Row(
            children: [
              Text(
                endTime,
                style: TextStyle(
                  fontSize: 14.sp, // Apply ScreenUtil to font size
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF6F7E8D),
                ),
              ),
              SizedBox(width: 5.w), // Apply ScreenUtil to width
              Image.asset('assets/images/BusinessHour/Time.png'),
            ],
          ),
        ),
      ],
    );
  }
}

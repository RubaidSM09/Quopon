import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../controllers/sign_up_process_vendor_controller.dart'; // Import ScreenUtil

class VendorBusinessHourRowView extends GetView {
  final bool isActive;
  final RxBool isSwitched;
  final String day;

  // 🔧 new:
  final RxString startTimeRx;
  final RxString endTimeRx;
  final int index;

  VendorBusinessHourRowView({
    super.key,
    required this.isActive,
    required this.day,

    // 🔧 new:
    required this.startTimeRx,
    required this.endTimeRx,
    required this.index,
  }) : isSwitched = isActive.obs;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Obx(() {
          return Theme(
            data: ThemeData(primarySwatch: Colors.red),
            child: Switch(
              value: isSwitched.value,
              onChanged: (value) {
                isSwitched.value = value;
                final c = Get.find<SignUpProcessVendorController>();
                c.setIsClosed(index, !value);
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
          day.substring(0,3),
          style: TextStyle(
            fontSize: 16.sp, // Apply ScreenUtil to font size
            fontWeight: FontWeight.w400,
            color: Color(0xFF020711),
          ),
        ),

        // Start time container
        Obx(() {
          return GestureDetector(
            onTap: () async {
              // open time picker if the row is active
              if (!isSwitched.value) return;

              final now = TimeOfDay.now();
              final picked = await showTimePicker(
                context: context,
                initialTime: _parseTimeOfDay(startTimeRx.value) ?? now,
              );
              if (picked != null) {
                final hh = picked.hour.toString().padLeft(2, '0');
                final mm = picked.minute.toString().padLeft(2, '0');
                final newVal = "$hh:$mm";

                // 🔧 update controller: endTimes[index] and businessSchedule[index]
                final c = Get.find<SignUpProcessVendorController>();
                c.setStartTime(index, newVal);
              }
            },
            child: Container(
              width: 105.5.w,
              height: 40.h,
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: Color(0xFFF4F6F7),
                border: Border.all(color: Color(0xFFEAECED)),
              ),
              child: Row(
                children: [
                  // 🔧 bound to RxString
                  Text(
                    startTimeRx.value,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF6F7E8D),
                    ),
                  ),
                  SizedBox(width: 5.w),
                  Image.asset('assets/images/BusinessHour/Time.png'),
                ],
              ),
            ),
          );
        }),

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
        Obx(() {
          return GestureDetector(
            onTap: () async {
              // open time picker if the row is active
              if (!isSwitched.value) return;

              final now = TimeOfDay.now();
              final picked = await showTimePicker(
                context: context,
                initialTime: _parseTimeOfDay(endTimeRx.value) ?? now,
              );
              if (picked != null) {
                final hh = picked.hour.toString().padLeft(2, '0');
                final mm = picked.minute.toString().padLeft(2, '0');
                final newVal = "$hh:$mm";

                // 🔧 update controller: endTimes[index] and businessSchedule[index]
                final c = Get.find<SignUpProcessVendorController>();
                c.setEndTime(index, newVal);
              }
            },
            child: Container(
              width: 105.5.w,
              height: 40.h,
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: Color(0xFFF4F6F7),
                border: Border.all(color: Color(0xFFEAECED)),
              ),
              child: Row(
                children: [
                  // 🔧 bound to RxString
                  Text(
                    endTimeRx.value,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF6F7E8D),
                    ),
                  ),
                  SizedBox(width: 5.w),
                  Image.asset('assets/images/BusinessHour/Time.png'),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}

TimeOfDay? _parseTimeOfDay(String value) {
  try {
    final parts = value.split(':');
    if (parts.length != 2) return null;
    final h = int.parse(parts[0]);
    final m = int.parse(parts[1]);
    if (h < 0 || h > 23 || m < 0 || m > 59) return null;
    return TimeOfDay(hour: h, minute: m);
  } catch (_) {
    return null;
  }
}
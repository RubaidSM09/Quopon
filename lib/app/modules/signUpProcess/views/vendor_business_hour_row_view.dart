// vendor_business_hour_row_view.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ✅ import both controller types (this file is reused in two screens)
import '../controllers/sign_up_process_vendor_controller.dart'
as signup_ctrl; // alias to avoid name clash
import '../../vendor_side_profile/controllers/vendor_side_profile_controller.dart'
as vendor_ctrl;

class VendorBusinessHourRowView extends GetView {
  final bool isActive;
  final RxBool isSwitched;
  final String? day;

  final RxString startTimeRx;
  final RxString endTimeRx;
  final int index;

  VendorBusinessHourRowView({
    super.key,
    required this.isActive,
    required this.day,
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

                // ✅ call whichever controller is active
                if (Get.isRegistered<vendor_ctrl.VendorSideProfileController>()) {
                  Get.find<vendor_ctrl.VendorSideProfileController>()
                      .setIsClosed(index, !value);
                } else if (Get
                    .isRegistered<signup_ctrl.SignUpProcessVendorController>()) {
                  Get.find<signup_ctrl.SignUpProcessVendorController>()
                      .setIsClosed(index, !value);
                }
              },
              activeColor: Colors.white,
              activeTrackColor: const Color(0xFFD62828),
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: const Color(0xFFBAC9D8),
            ),
          );
        }),

        // Day text
        Text(
          day!.substring(0, 3),
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF020711),
          ),
        ),

        // Start time
        Obx(() {
          return GestureDetector(
            onTap: () async {
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

                // ✅ update the bound RxString immediately (UI refreshes)
                startTimeRx.value = newVal;

                // ✅ also sync the owning controller's model/lists
                if (Get.isRegistered<vendor_ctrl.VendorSideProfileController>()) {
                  Get.find<vendor_ctrl.VendorSideProfileController>()
                      .setStartTime(index, newVal);
                } else if (Get.isRegistered<
                    signup_ctrl.SignUpProcessVendorController>()) {
                  Get.find<signup_ctrl.SignUpProcessVendorController>()
                      .setStartTime(index, newVal);
                }
              }
            },
            child: _timeBox(startTimeRx.value),
          );
        }),

        // "to"
        Text(
          'to',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF6F7E8D),
          ),
        ),

        // End time
        Obx(() {
          return GestureDetector(
            onTap: () async {
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

                // ✅ update bound RxString
                endTimeRx.value = newVal;

                // ✅ sync controller
                if (Get.isRegistered<vendor_ctrl.VendorSideProfileController>()) {
                  Get.find<vendor_ctrl.VendorSideProfileController>()
                      .setEndTime(index, newVal);
                } else if (Get.isRegistered<
                    signup_ctrl.SignUpProcessVendorController>()) {
                  Get.find<signup_ctrl.SignUpProcessVendorController>()
                      .setEndTime(index, newVal);
                }
              }
            },
            child: _timeBox(endTimeRx.value),
          );
        }),
      ],
    );
  }
}

// Small helper to keep your existing visual style intact
Widget _timeBox(String value) {
  return Container(
    width: 105.5.w,
    height: 40.h,
    padding: EdgeInsets.all(12.r),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8.r),
      color: const Color(0xFFF4F6F7),
      border: Border.all(color: const Color(0xFFEAECED)),
    ),
    child: Row(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF6F7E8D),
          ),
        ),
        SizedBox(width: 5.w),
        Image.asset('assets/images/BusinessHour/Time.png'),
      ],
    ),
  );
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

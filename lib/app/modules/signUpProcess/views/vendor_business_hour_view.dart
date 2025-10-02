import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil
import 'package:quopon/app/modules/signUpProcess/controllers/sign_up_process_vendor_controller.dart';
import 'package:quopon/app/modules/signUpProcess/views/vendor_business_hour_row_view.dart';

class VendorBusinessHourView extends GetView<SignUpProcessVendorController> {
  final VoidCallback onNext;
  final VoidCallback onSkip;

  VendorBusinessHourView({super.key, required this.onNext, required this.onSkip});

  @override
  Widget build(BuildContext context) {
    // Fetch business hours when the view is initialized
    controller.fetchBusinessHours();

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.r),  // Use ScreenUtil for padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Set Your Business Hours',
              style: TextStyle(
                fontSize: 28.sp,  // Use ScreenUtil for font size
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8.h),  // Use ScreenUtil for spacing
            Text(
              'Let customers know when you\'re open by adding your operating days and times.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,  // Use ScreenUtil for font size
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 40.h),  // Use ScreenUtil for spacing

            // Wrap the schedule list with Obx to automatically rebuild when the businessSchedule changes
            Obx(() {
              return Container(
                padding: EdgeInsets.all(16.r),  // Use ScreenUtil for padding
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),  // Use ScreenUtil for radius
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 16)],
                ),
                child: Column(

                  children: List.generate(controller.businessSchedule.length, (index) {
                    final schedule = controller.businessSchedule[index];
                    return VendorBusinessHourRowView(
                      isActive: !schedule.isClosed,
                      day: schedule.day,
                      startTimeRx: controller.startTimes[index],
                      // 🔧 pass the RxString and index instead of a plain String
                      endTimeRx: controller.endTimes[index],
                      index: index,
                    );
                  }),
                ),
              );
            }),

            // Next button to trigger the PATCH request to update business hours
            Padding(
              padding: EdgeInsets.only(top: 20.h),
              child: ElevatedButton(
                onPressed: () async {
                  await controller.patchBusinessHours(); // Trigger patch request
                },
                child: Text('Next'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFD62828), // Set button color
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),  // Apply ScreenUtil to border radius
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? _NumberToDay (int day) {
    if(day == 0) {
      return 'Monday';
    }
    else if (day == 1) {
      return 'Tuesday';
    }
    else if (day == 2) {
      return 'Wednesday';
    }
    else if (day == 3) {
      return 'Thursday';
    }
    else if (day == 4) {
      return 'Friday';
    }
    else if (day == 5) {
      return 'Saturday';
    }
    else if (day == 6) {
      return 'Sunday';
    }
    else {
      return null;
    }
  }
}



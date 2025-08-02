import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';  // Import ScreenUtil
import 'package:quopon/app/modules/signUpProcess/controllers/sign_up_process_vendor_controller.dart';
import 'package:quopon/app/modules/signUpProcess/views/vendor_business_hour_row_view.dart';

class VendorBusinessHourView extends GetView<SignUpProcessVendorController> {
  final VoidCallback onNext;
  final VoidCallback onSkip;

  VendorBusinessHourView({super.key, required this.onNext, required this.onSkip,});

  @override
  Widget build(BuildContext context) {
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
            Container(
              padding: EdgeInsets.all(16.r),  // Use ScreenUtil for padding
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),  // Use ScreenUtil for radius
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 16)],
              ),
              child: Column(
                children: [
                  VendorBusinessHourRowView(
                    isActive: true,
                    day: 'Mon',
                    startTime: '12:00 AM',
                    endTime: '12:00 AM',
                  ),
                  SizedBox(height: 15.h),  // Use ScreenUtil for spacing
                  VendorBusinessHourRowView(
                    isActive: true,
                    day: 'Tue',
                    startTime: '12:00 AM',
                    endTime: '12:00 AM',
                  ),
                  SizedBox(height: 15.h),  // Use ScreenUtil for spacing
                  VendorBusinessHourRowView(
                    isActive: true,
                    day: 'Wed',
                    startTime: '12:00 AM',
                    endTime: '12:00 AM',
                  ),
                  SizedBox(height: 15.h),  // Use ScreenUtil for spacing
                  VendorBusinessHourRowView(
                    isActive: true,
                    day: 'Thu',
                    startTime: '12:00 AM',
                    endTime: '12:00 AM',
                  ),
                  SizedBox(height: 15.h),  // Use ScreenUtil for spacing
                  VendorBusinessHourRowView(
                    isActive: true,
                    day: 'Fri',
                    startTime: '12:00 AM',
                    endTime: '12:00 AM',
                  ),
                  SizedBox(height: 15.h),  // Use ScreenUtil for spacing
                  VendorBusinessHourRowView(
                    isActive: false,
                    day: 'Sat',
                    startTime: '12:00 AM',
                    endTime: '12:00 AM',
                  ),
                  SizedBox(height: 15.h),  // Use ScreenUtil for spacing
                  VendorBusinessHourRowView(
                    isActive: false,
                    day: 'Sun',
                    startTime: '12:00 AM',
                    endTime: '12:00 AM',
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

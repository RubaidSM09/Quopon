import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../common/customTextButton.dart';

class QRFailView extends StatelessWidget {
  const QRFailView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: Get.back, // Close on outside tap
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.0),
        body: Center(
          child: GestureDetector(
            onTap: () {}, // prevent dismiss on card tap
            child: Container(
              width: 398.w,
              height: 452.h,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: const Color(0xFFF9FBFC),
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8.r,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.asset('assets/images/QR/no-data 1.png'),
                    SizedBox(height: 20.h),
                    Text(
                      'Oops! Something Went Wrong',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFF020711),
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'This QR code is invalid or expired.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFF020711),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: const Color(0xFFF7EEEF),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8.w),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset('assets/images/QR/RedExclIcon.png'),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Unable to process QR code',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: const Color(0xFFD62828),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    'The QR code might be expired or invalid. Please try scanning again or contact support if the issue persists.',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: const Color(0xFFD62828),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    GradientButton(
                      text: '⟳ Try Again',
                      onPressed: Get.back, // simply close the dialog to resume camera
                      colors: const [Color(0xFFD62828), Color(0xFFC21414)],
                      boxShadow: const [BoxShadow(color: Color(0xFF9A0000), spreadRadius: 1)],
                      child: Text(
                        '⟳ Try Again',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    GradientButton(
                      text: "Contact Support",
                      onPressed: () {
                        // TODO: route to your support screen/page
                      },
                      colors: const [Color(0xFFF4F5F6), Color(0xFFEEF0F3)],
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                        color: const Color(0xFF020711),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';  // Import ScreenUtil
import 'package:get/get_core/src/get_main.dart';
import '../../../../common/customTextButton.dart';
import '../../vendor_dashboard/views/vendor_dashboard_view.dart';

class QRFailView extends StatelessWidget {
  const QRFailView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);  // Close the detail view on tapping outside
      },
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.0),
        body: Center(
          child: GestureDetector(
            onTap: () {}, // Prevent dismiss on card tap
            child: Container(
              width: 398.w,  // Use ScreenUtil for width
              height: 452.h,  // Use ScreenUtil for height
              padding: EdgeInsets.all(16.w),  // Use ScreenUtil for padding
              decoration: BoxDecoration(
                color: Color(0xFFF9FBFC),
                borderRadius: BorderRadius.circular(16.r),  // Use ScreenUtil for radius
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8.r,  // Use ScreenUtil for blurRadius
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/QR/no-data 1.png'),
                    SizedBox(height: 20.h),
                    Text(
                      'Oops! Something Went Wrong',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF020711),
                        fontSize: 18.sp,  // Use ScreenUtil for font size
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'This QR code is invalid or expired.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF020711),
                        fontSize: 14.sp,  // Use ScreenUtil for font size
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),  // Use ScreenUtil for radius
                        color: Color(0xFFF7EEEF),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8.w),  // Use ScreenUtil for padding
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Image.asset('assets/images/QR/RedExclIcon.png'),
                            ),
                            SizedBox(width: 10.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Unable to process QR code',
                                  style: TextStyle(
                                    fontSize: 14.sp,  // Use ScreenUtil for font size
                                    color: Color(0xFFD62828),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: 265.w,
                                  child: Text(
                                    'The QR code might be expired or invalid. Please try scanning again or contact support if the issue persists.',
                                    style: TextStyle(
                                      fontSize: 12.sp,  // Use ScreenUtil for font size
                                      color: Color(0xFFD62828),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    GradientButton(
                      text: '⟳ Try Again',
                      onPressed: () {

                      },
                      colors: [const Color(0xFFD62828), const Color(0xFFC21414)],
                      boxShadow: [const BoxShadow(color: Color(0xFF9A0000), spreadRadius: 1)],
                      child: Text(
                        '⟳ Try Again',
                        style: TextStyle(
                          fontSize: 16.sp,  // Use ScreenUtil for font size
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    GradientButton(
                      text: "Contact Support",
                      onPressed: () {},
                      colors: [Color(0xFFF4F5F6), Color(0xFFEEF0F3)],
                      textStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp, color: Color(0xFF020711)),
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

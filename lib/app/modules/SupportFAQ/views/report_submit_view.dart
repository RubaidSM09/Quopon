import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/customTextButton.dart'; // Import ScreenUtil

class ReportSubmitView extends GetView {
  const ReportSubmitView({super.key});
  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Color(0xFFFFFFFF),
        child: SingleChildScrollView(
          child: Container(
            height: 296.h, // ScreenUtil applied
            padding: EdgeInsets.all(16.w), // ScreenUtil applied
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/images/SupportFAQ/Message.gif',
                  height: 80.h, // ScreenUtil applied
                  width: 80.w, // ScreenUtil applied
                ),
                Column(
                  children: [
                    Text(
                      'Request Submitted!',
                      style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500, color: Color(0xFF020711)), // ScreenUtil applied
                    ),
                    SizedBox(height: 10.h), // ScreenUtil applied
                    Text(
                      'We’ve received your message. You’ll get a notification once it’s reviewed by our support team.',
                      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)), // ScreenUtil applied
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                SizedBox(height: 20.h), // ScreenUtil applied
                GradientButton(
                  text: 'Done',
                  onPressed: () {
                    Get.back();
                  },
                  colors: [const Color(0xFFD62828), const Color(0xFFC21414)],
                  boxShadow: [const BoxShadow(color: Color(0xFF9A0000), spreadRadius: 1)],
                  child: Text(
                    'Done',
                    style: TextStyle(
                      fontSize: 16.sp,  // Use ScreenUtil for font size
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}

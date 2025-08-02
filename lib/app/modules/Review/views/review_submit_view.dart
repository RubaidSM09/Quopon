import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil
import 'package:get/get.dart';

import '../../../../common/customTextButton.dart';

class ReviewSubmitView extends GetView {
  const ReviewSubmitView({super.key});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Color(0xFFFFFFFF),
      child: SingleChildScrollView(
        child: Container(
          height: 296.h, // Use ScreenUtil for height
          padding: EdgeInsets.all(16.w), // Use ScreenUtil for padding
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/images/Review/Thanks.gif',
                height: 80.h, // Use ScreenUtil for height
                width: 80.w, // Use ScreenUtil for width
              ),
              Column(
                children: [
                  Text(
                    'Thanks for your review!',
                    style: TextStyle(
                      fontSize: 20.sp, // Use ScreenUtil for font size
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF020711),
                    ),
                  ),
                  Text(
                    'It helps other users and supports your favorite vendors.',
                    style: TextStyle(
                      fontSize: 16.sp, // Use ScreenUtil for font size
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF6F7E8D),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
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
      ),
    );
  }
}

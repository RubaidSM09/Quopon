import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil
import '../../../../common/customTextButton.dart';
import '../../../../common/custom_textField.dart';

class GetInTouchView extends GetView {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  GetInTouchView({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(16.r), // Use ScreenUtil for radius
          topLeft: Radius.circular(16.r),
        ),
      ),
      padding: EdgeInsets.all(16.w), // Use ScreenUtil for padding
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox.shrink(),
                Container(
                  width: 60.w, // Use ScreenUtil for width
                  height: 60.h, // Use ScreenUtil for height
                  decoration: BoxDecoration(
                    color: Color(0xFFDC143C),
                    borderRadius: BorderRadius.circular(16.r), // Use ScreenUtil for radius
                  ),
                  padding: EdgeInsets.all(12.w), // Use ScreenUtil for padding
                  child: Image.asset(
                    'assets/images/login/Logo Icon.png',
                    fit: BoxFit.cover,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(Icons.close),
                ),
              ],
            ),
            SizedBox(height: 15.h),
            Text(
              'Get in Touch',
              style: TextStyle(
                fontSize: 28.sp, // Use ScreenUtil for font size
                fontWeight: FontWeight.w700,
                color: Color(0xFF020711),
              ),
            ),
            SizedBox(height: 15.h),
            Text(
              'Need help? Send us a message and our support team will get back to you shortly.',
              style: TextStyle(
                fontSize: 16.sp, // Use ScreenUtil for font size
                fontWeight: FontWeight.w400,
                color: Color(0xFF6F7E8D),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30.h),

            GetInTouchTextField(
              headingText: 'Full Name',
              fieldText: 'Enter full name',
              iconImagePath: '',
              controller: _fullNameController,
              isRequired: false,
            ),
            SizedBox(height: 15.h),
            GetInTouchTextField(
              headingText: 'Email Address',
              fieldText: 'Enter email address',
              iconImagePath: '',
              controller: _emailController,
              isRequired: false,
            ),
            SizedBox(height: 15.h),
            CustomCategoryField(
              fieldName: 'Category',
              isRequired: false,
            ),
            SizedBox(height: 15.h),
            GetInTouchTextField(
              headingText: 'Message',
              fieldText: 'Write here...',
              iconImagePath: '',
              controller: _messageController,
              isRequired: false,
              maxLine: 6,
            ),
            SizedBox(height: 25.h),
            GradientButton(
              text: 'Send Message',
              onPressed: () {
                Get.back();
              },
              colors: [const Color(0xFFD62828), const Color(0xFFC21414)],
              boxShadow: [const BoxShadow(color: Color(0xFF9A0000), spreadRadius: 1)],
              child: Text(
                'Send Message',
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
    );
  }
}

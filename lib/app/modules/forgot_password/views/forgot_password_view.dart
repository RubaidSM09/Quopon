import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:quopon/app/modules/forgot_password/views/mail_verification_code_view.dart';

import '../../../../common/customTextButton.dart';
import '../../../../common/custom_textField.dart';
import '../../qr_scanner_vendor/views/verification_code_view.dart';
import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  final emailController = TextEditingController();
  final ForgotPasswordController forgotPasswordController = Get.put(ForgotPasswordController());

  ForgotPasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9FBFC),
      body: Padding(
        padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 92, bottom: 38),
        child: SizedBox(
          height: 802.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(12.w), // Use ScreenUtil for padding
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFFD62828), Color(0xFFC21414)],
                      ),
                      borderRadius: BorderRadius.circular(
                        16.r,
                      ), // Use ScreenUtil for border radius
                      border: Border.all(width: 1, color: Colors.transparent),
                      boxShadow: [
                        BoxShadow(color: Color(0xFF9A0000), spreadRadius: 1),
                      ],
                    ),
                    child: Image.asset(
                      'assets/images/login/Logo Icon.png',
                      fit: BoxFit.cover,
                    ),
                  ),

                  SizedBox(height: 24.h), // Use ScreenUtil for height spacing
                  // Title
                  Text(
                    'Forgot Password?',
                    style: TextStyle(
                      fontSize: 28.sp, // Use ScreenUtil for font size
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF020711),
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 12.h), // Use ScreenUtil for height spacing
                  // Subtitle
                  Text(
                    'Enter the email linked to your account. We’ll send you a verification code.',
                    style: TextStyle(
                      fontSize: 16.sp, // Use ScreenUtil for font size
                      color: Color(0xFF6F7E8D),
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 48.h), // Use ScreenUtil for height spacing
                  // Email Field
                  CustomTextField(
                    headingText: 'Email Address',
                    fieldText: 'Enter email address',
                    iconImagePath: 'assets/images/login/Email.png',
                    controller: emailController,
                    isRequired: true,
                  ),
                ],
              ),

              Column(
                children: [
                  GradientButton(
                    text: 'Send Verification Code',
                    onPressed: () {
                      forgotPasswordController.forgotPassword(emailController.text.trim());
                    },
                    colors: [
                      const Color(0xFFD62828),
                      const Color(0xFFC21414),
                    ],
                    boxShadow: [
                      const BoxShadow(
                        color: Color(0xFF9A0000),
                        spreadRadius: 1,
                      ),
                    ],
                    child: Text(
                      'Send Verification Code',
                      style: TextStyle(
                        fontSize: 16.sp, // Use ScreenUtil for font size
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h,),
                  GradientButton(
                    text: 'Go Back',
                    onPressed: () {
                      Get.back();
                    },
                    colors: [const Color(0xFFF4F5F6), const Color(0xFFEEF0F3)],
                    borderColor: [Colors.white, Color(0xFFEEF0F3)],
                    boxShadow: [
                      const BoxShadow(color: Color(0xFFDFE4E9), spreadRadius: 1),
                    ],
                    child: Text(
                      'Go Back',
                      style: TextStyle(
                        color: Color(0xFF020711),
                        fontSize: 16.sp, // Use ScreenUtil for font size
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

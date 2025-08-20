import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:quopon/app/modules/forgot_password/controllers/forgot_password_controller.dart';
import 'package:quopon/app/modules/login/views/login_view.dart';

import '../../../../common/customTextButton.dart';
import '../../../../common/custom_textField.dart';

class SetNewPasswordView extends GetView<ForgotPasswordController> {
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final String email;
  final ForgotPasswordController forgotPasswordController = Get.put(ForgotPasswordController());

  SetNewPasswordView({
    required this.email,
    super.key
  });
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
                    'Set New Password',
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
                    'Please create a new, secure password to regain access to your account.',
                    style: TextStyle(
                      fontSize: 16.sp, // Use ScreenUtil for font size
                      color: Color(0xFF6F7E8D),
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 48.h), // Use ScreenUtil for height spacing
                  // New Password Field
                  CustomTextField(
                    headingText: 'New Password',
                    fieldText: '••••••••••••',
                    iconImagePath: 'assets/images/login/Password.png',
                    controller: newPasswordController,
                    isRequired: true,
                    isPassword: true,
                  ),

                  SizedBox(height: 16.h), // Use ScreenUtil for height spacing
                  // Confirm Password Field
                  CustomTextField(
                    headingText: 'Confirm Password',
                    fieldText: '••••••••••••',
                    iconImagePath: 'assets/images/login/Password.png',
                    controller: confirmPasswordController,
                    isRequired: true,
                    isPassword: true,
                  ),
                ],
              ),

              Column(
                children: [
                  GradientButton(
                    text: 'Update Password',
                    onPressed: () {
                      forgotPasswordController.setNewPassword(email, newPasswordController.text.trim(), confirmPasswordController.text.trim());
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
                      'Update Password',
                      style: TextStyle(
                        fontSize: 16.sp, // Use ScreenUtil for font size
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
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

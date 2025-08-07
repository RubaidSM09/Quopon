import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:quopon/app/modules/forgot_password/views/set_new_password_view.dart';

import '../../../../common/customTextButton.dart';
import '../../../../common/custom_textField.dart';
import '../controllers/forgot_password_controller.dart';

class MailVerificationCodeView extends GetView<ForgotPasswordController> {
  final emailController = TextEditingController();

  MailVerificationCodeView({super.key}) {
    Get.put(ForgotPasswordController());
  }

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
                    'Verify Your Email',
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
                    'Enter the 6-digit code we sent to your email.',
                    style: TextStyle(
                      fontSize: 16.sp, // Use ScreenUtil for font size
                      color: Color(0xFF6F7E8D),
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 48.h), // Use ScreenUtil for height spacing

                  // Input boxes
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(6, (index) {
                      return SizedBox(
                        width: 58.w,
                        height: 58.h,
                        child: TextField(
                          controller: controller.controllers[index],
                          focusNode: controller.focusNodes[index],
                          onChanged: (value) =>
                              controller.onDigitEntered(index, value),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          textAlignVertical: TextAlignVertical.center,
                          maxLength: 1,
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF020711),
                          ),
                          decoration: InputDecoration(
                            counterText: '',
                            enabled: true,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: BorderSide(color: Color(0xFFEAECED)),
                            ),
                            filled: true,
                            fillColor: Color(0xFFF4F6F7),
                          ),
                        ),
                      );
                    }),
                  ),

                  SizedBox(height: 24.h,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don’t receive code? ",
                        style: TextStyle(
                          color: Color(0xFF6F7E8D),
                          fontSize: 14.sp, // Use ScreenUtil for font size
                        ),
                      ),
                      GestureDetector(
                        onTap: () {

                        },
                        child: Text(
                          'Resend Now',
                          style: TextStyle(
                            color: Color(0xFFDC143C),
                            fontSize: 14.sp, // Use ScreenUtil for font size
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              Column(
                children: [
                  GradientButton(
                    text: 'Verify',
                    onPressed: () {
                      Get.to(SetNewPasswordView());
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
                      'Verify',
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

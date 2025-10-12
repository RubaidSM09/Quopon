import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:quopon/app/modules/Review/views/review_view.dart';
import 'package:quopon/app/modules/landing/views/landing_vendor_view.dart';
import 'package:quopon/app/modules/signup/views/signup_vendor_view.dart';
import 'package:quopon/app/modules/vendor_dashboard/views/vendor_dashboard_view.dart';
import 'package:quopon/common/custom_textField.dart';

import '../../../../common/customTextButton.dart';
import '../../forgot_password/views/forgot_password_view.dart';
import '../controllers/login_controller.dart';
import '../controllers/login_vendor_controller.dart';

class LoginVendorView extends GetView<LoginVendorController> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.put(LoginController());
    return Scaffold(
      backgroundColor: Color(0xFFF9FBFC),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              SizedBox(height: 60.h),

              // Logo
              Container(
                width: 80.w,
                height: 80.h,
                decoration: BoxDecoration(
                  color: Color(0xFFDC143C),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Image.asset(
                  'assets/images/login/Logo Icon.png',
                  fit: BoxFit.cover,
                ),
              ),

              SizedBox(height: 32.h),

              // Title
              Text(
                'Log In to Manage Your Business',
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 12.h),

              // Subtitle
              Text(
                'Log in to manage your deals, track redemptions, and connect with your customers.',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey[600],
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 48.h),

              // Email Field
              CustomTextField(
                headingText: 'Email Address',
                fieldText: 'Enter email address',
                iconImagePath: 'assets/images/login/Email.png',
                controller: loginController.emailController,
                isRequired: true,
              ),

              SizedBox(height: 12.h),

              // Password Field
              CustomTextField(
                headingText: 'Password',
                fieldText: '••••••••••••',
                iconImagePath: 'assets/images/login/Password.png',
                controller: loginController.passwordController,
                isRequired: true,
                isPassword: true,
              ),

              SizedBox(height: 8.h),

              // Forgot Password
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Get.to(ForgotPasswordView(userType: 'vendor',));
                  },
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Color(0xFFDC143C),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 12.h),

              // Login Button
              GradientButton(
                text: 'Log In',
                onPressed: () {
                  loginController.userLogin();
                },
                colors: [const Color(0xFFD62828), const Color(0xFFC21414)],
                boxShadow: [const BoxShadow(color: Color(0xFF9A0000), spreadRadius: 1)],
                child: Text(
                  'Log In',
                  style: TextStyle(
                    fontSize: 16.sp,  // Use ScreenUtil for font size
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),

              SizedBox(height: 16.h),

              // OR CONTINUE WITH
              Row(
                children: [
                  Expanded(child: Divider(color: Colors.grey[300])),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Text(
                      'OR CONTINUE WITH',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(child: Divider(color: Colors.grey[300])),
                ],
              ),

              SizedBox(height: 24.h),

              // Google Login Button
              SizedBox(
                width: double.infinity,
                height: 56.h,
                child: OutlinedButton(
                  onPressed: () {
                    loginController.socialSignIn(userType: 'vendor', provider: 'Google');
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: BorderSide(color: Colors.grey[300]!),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/images/login/Google Icon.svg',
                      ),
                      SizedBox(width: 12.w),
                      Text(
                        'Continue With Google',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 8.h),

              // Apple Login Button
              SizedBox(
                width: double.infinity,
                height: 56.h,
                child: OutlinedButton(
                  onPressed: () {
                    loginController.socialSignIn(userType: 'vendor', provider: 'Apple');
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: BorderSide(color: Colors.grey[300]!),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/images/login/Apple Icon.svg',
                      ),
                      SizedBox(width: 12.w),
                      Text(
                        'Continue With Apple',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 16.h),

              // Create Account
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16.sp,
                    ),
                  ),
                  TextButton(
                    onPressed: () => Get.to(SignupVendorView()),
                    child: Text(
                      'Create Account',
                      style: TextStyle(
                        color: Color(0xFFDC143C),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }
}

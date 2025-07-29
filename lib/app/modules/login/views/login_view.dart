import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';  // Import ScreenUtil
import 'package:get/get.dart';
import 'package:quopon/app/modules/Review/views/review_view.dart';
import 'package:quopon/app/modules/home/views/home_view.dart';
import 'package:quopon/app/modules/login/controllers/login_controller.dart';
import 'package:quopon/common/customTextButton.dart';
import 'package:quopon/common/custom_textField.dart';
import 'package:quopon/common/red_button.dart';

class LoginView extends GetView<LoginController> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9FBFC),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 92.h, left: 16.w, right: 16.w),  // Use ScreenUtil for padding
        child: Column(
          children: [
            // Logo
            Container(
                padding: EdgeInsets.all(12.w),  // Use ScreenUtil for padding
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [Color(0xFFD62828), Color(0xFFC21414)]),
                    borderRadius: BorderRadius.circular(16.r), // Use ScreenUtil for border radius
                    border: Border.all(
                      width: 1,
                      color: Colors.transparent,
                    ),
                    boxShadow: [BoxShadow(color: Color(0xFF9A0000), spreadRadius: 1)]
                ),
                child: Image.asset(
                  'assets/images/login/Logo Icon.png',
                  fit: BoxFit.cover,
                )
            ),

            SizedBox(height: 32.h),  // Use ScreenUtil for height spacing

            // Title
            Text(
              'Welcome Back to Qoupon',
              style: TextStyle(
                fontSize: 28.sp,  // Use ScreenUtil for font size
                fontWeight: FontWeight.bold,
                color: Color(0xFF020711),
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 12.h),  // Use ScreenUtil for height spacing

            // Subtitle
            Text(
              'Sign in to access your saved deals, track redemptions,\nand discover new offers near you.',
              style: TextStyle(
                  fontSize: 16.sp,  // Use ScreenUtil for font size
                  color: Color(0xFF6F7E8D),
                  fontWeight: FontWeight.w400
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 48.h),  // Use ScreenUtil for height spacing

            // Email Field
            CustomTextField(
                headingText: 'Email Address',
                fieldText: 'Enter email address',
                iconImagePath: 'assets/images/login/Email.png',
                controller: _emailController,
                isRequired: true
            ),

            SizedBox(height: 12.h),  // Use ScreenUtil for height spacing

            // Password Field
            CustomTextField(
                headingText: 'Password',
                fieldText: '••••••••••••',
                iconImagePath: 'assets/images/login/Password.png',
                controller: _passwordController,
                isRequired: true,
                isPassword: true
            ),

            SizedBox(height: 8.h),  // Use ScreenUtil for height spacing

            // Forgot Password
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // Handle forgot password
                },
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: Color(0xFFD62828),
                    fontSize: 14.sp,  // Use ScreenUtil for font size
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),

            SizedBox(height: 12.h),  // Use ScreenUtil for height spacing

            // Login Button
            GradientButton(
              text: 'Log In',
              onPressed: () {
                Get.to(HomeView());
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

            SizedBox(height: 16.h),  // Use ScreenUtil for height spacing

            // OR CONTINUE WITH
            Row(
              children: [
                Expanded(child: Divider(color: Colors.grey[300])),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),  // Use ScreenUtil for padding
                  child: Text(
                    'OR CONTINUE WITH',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12.sp,  // Use ScreenUtil for font size
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Expanded(child: Divider(color: Colors.grey[300])),
              ],
            ),

            SizedBox(height: 24.h),  // Use ScreenUtil for height spacing

            // Google Login Button
            GradientButton(
              text: 'Continue With Google',
              onPressed: () {
                Get.to(HomeView());
              },
              colors: [const Color(0xFFF4F5F6), const Color(0xFFEEF0F3)],
              borderColor: [Colors.white, Color(0xFFEEF0F3)],
              boxShadow: [const BoxShadow(color: Color(0xFFDFE4E9), spreadRadius: 1)],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 20.w,
                    height: 20.h,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/login/Google.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    'Continue With Google',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 16.sp,  // Use ScreenUtil for font size
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 12.h),  // Use ScreenUtil for height spacing

            // Apple Login Button
            GradientButton(
              text: 'Continue With Apple',
              onPressed: () {
                Get.to(HomeView());
              },
              colors: [const Color(0xFFF4F5F6), const Color(0xFFEEF0F3)],
              borderColor: [Colors.white, Color(0xFFEEF0F3)],
              boxShadow: [const BoxShadow(color: Color(0xFFDFE4E9), spreadRadius: 1)],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 20.w,
                    height: 20.h,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/login/Apple.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    'Continue With Apple',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 16.sp,  // Use ScreenUtil for font size
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16.h),  // Use ScreenUtil for height spacing

            // Create Account
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account? ",
                  style: TextStyle(
                    color: Color(0xFF6F7E8D),
                    fontSize: 14.sp,  // Use ScreenUtil for font size
                  ),
                ),
                TextButton(
                  onPressed: () => Get.offNamed('/signup'),
                  child: Text(
                    'Create Account',
                    style: TextStyle(
                      color: Color(0xFFDC143C),
                      fontSize: 14.sp,  // Use ScreenUtil for font size
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 16.h),  // Use ScreenUtil for height spacing
          ],
        ),
      ),
    );
  }
}

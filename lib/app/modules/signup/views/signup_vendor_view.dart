import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil
import 'package:quopon/app/modules/login/views/login_vendor_view.dart';
import 'package:quopon/app/modules/signUpProcess/views/sign_up_process_vendor_view.dart';
import 'package:quopon/app/modules/signup/controllers/signup_vendor_controller.dart';
import '../../../../common/customTextButton.dart';
import '../../../../common/custom_textField.dart';

class SignupVendorView extends GetView<SignupVendorController> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _referralCodeController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9FBFC),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w), // Use ScreenUtil for horizontal padding
          child: Column(
            children: [
              SizedBox(height: 60.h), // Use ScreenUtil for height spacing

              // Logo
              Container(
                  width: 80.w, // Use ScreenUtil for width
                  height: 80.h, // Use ScreenUtil for height
                  decoration: BoxDecoration(
                    color: Color(0xFFDC143C),
                    borderRadius: BorderRadius.circular(16.r), // Use ScreenUtil for border radius
                  ),
                  child:  Image.asset(
                    'assets/images/login/Logo Icon.png',
                    fit: BoxFit.cover,
                  )
              ),

              SizedBox(height: 32.h), // Use ScreenUtil for height spacing

              // Title
              Text(
                'Create Your Vendor Profile',
                style: TextStyle(
                  fontSize: 28.sp, // Use ScreenUtil for font size
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 12.h), // Use ScreenUtil for height spacing

              // Subtitle
              Text(
                'Apply to join Qoupon and start growing your business with smart, trackable deals.',
                style: TextStyle(
                  fontSize: 13.8.sp, // Use ScreenUtil for font size
                  color: Colors.grey[600],
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 24.h), // Use ScreenUtil for height spacing

              // Email Field
              CustomTextField(
                  headingText: 'Email Address',
                  fieldText: 'Enter email address',
                  iconImagePath: 'assets/images/login/Email.png',
                  controller: _emailController,
                  isRequired: true
              ),

              SizedBox(height: 12.h), // Use ScreenUtil for height spacing

              // Create Password Field
              CustomTextField(
                  headingText: 'Create Password',
                  fieldText: '••••••••••••',
                  iconImagePath: 'assets/images/login/Password.png',
                  controller: _passwordController,
                  isRequired: true,
                  isPassword: true
              ),

              SizedBox(height: 12.h), // Use ScreenUtil for height spacing

              // Confirm Password Field
              CustomTextField(
                  headingText: 'Confirm Password',
                  fieldText: '••••••••••••',
                  iconImagePath: 'assets/images/login/Password.png',
                  controller: _confirmPasswordController,
                  isRequired: true,
                  isPassword: true
              ),

              SizedBox(height: 32.h), // Use ScreenUtil for height spacing

              // Create Account Button
              SizedBox(
                  width: double.infinity,
                  height: 56.h, // Use ScreenUtil for height
                  child: GradientButton(
                    text: 'Create Account',
                    onPressed: () {
                      Get.to(SignUpProcessVendorView());
                    },
                    colors: [const Color(0xFFD62828), const Color(0xFFC21414)],
                    boxShadow: [const BoxShadow(color: Color(0xFF9A0000), spreadRadius: 1)],
                    child: Text(
                      'Create Account',
                      style: TextStyle(
                        fontSize: 16.sp,  // Use ScreenUtil for font size
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ),

              SizedBox(height: 12.h), // Use ScreenUtil for height spacing

              // Already have account
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16.sp, // Use ScreenUtil for font size
                    ),
                  ),
                  TextButton(
                    onPressed: () => Get.to(LoginVendorView()),
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        color: Color(0xFFDC143C),
                        fontSize: 16.sp, // Use ScreenUtil for font size
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16.h), // Use ScreenUtil for height spacing

              // Terms and Privacy Policy
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w), // Use ScreenUtil for padding
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'By creating an account, you agree to our ',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14.sp, // Use ScreenUtil for font size
                          height: 1.4,
                        ),
                      ),
                      TextSpan(
                        text: 'Terms of Use',
                        style: TextStyle(
                          color: Color(0xFFDC143C),
                          fontSize: 14.sp, // Use ScreenUtil for font size
                          fontWeight: FontWeight.w500,
                          height: 1.4,
                        ),
                      ),
                      TextSpan(
                        text: ' and ',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14.sp, // Use ScreenUtil for font size
                          height: 1.4,
                        ),
                      ),
                      TextSpan(
                        text: 'Privacy Policy',
                        style: TextStyle(
                          color: Color(0xFFDC143C),
                          fontSize: 14.sp, // Use ScreenUtil for font size
                          fontWeight: FontWeight.w500,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 16.h), // Use ScreenUtil for height spacing
            ],
          ),
        ),
      ),
    );
  }
}

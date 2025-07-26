import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:quopon/app/modules/login/views/login_vendor_view.dart';
import 'package:quopon/app/modules/signUpProcess/views/sign_up_process_vendor_view.dart';
import 'package:quopon/app/modules/signup/controllers/signup_vendor_controller.dart';
import 'package:quopon/common/red_button.dart';

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
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              SizedBox(height: 60),

              // Logo
              Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Color(0xFFDC143C),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child:  Image.asset(
                    'assets/images/login/Logo Icon.png',
                    fit: BoxFit.cover,
                  )
              ),

              SizedBox(height: 32),

              // Title
              Text(
                'Create Your Vendor Profile',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 12),

              // Subtitle
              Text(
                'Apply to join Qoupon and start growing your business with smart, trackable deals.',
                style: TextStyle(
                  fontSize: 13.8,
                  color: Colors.grey[600],
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 24),

              // Email Field
              CustomTextField(
                  headingText: 'Email Address',
                  fieldText: 'Enter email address',
                  iconImagePath: 'assets/images/login/Email.png',
                  controller: _emailController,
                  isRequired: true
              ),

              SizedBox(height: 12),

              // Create Password Field
              CustomTextField(
                  headingText: 'Create Password',
                  fieldText: '••••••••••••',
                  iconImagePath: 'assets/images/login/Password.png',
                  controller: _passwordController,
                  isRequired: true,
                  isPassword: true
              ),

              SizedBox(height: 12),

              // Confirm Password Field
              CustomTextField(
                  headingText: 'Confirm Password',
                  fieldText: '••••••••••••',
                  iconImagePath: 'assets/images/login/Password.png',
                  controller: _confirmPasswordController,
                  isRequired: true,
                  isPassword: true
              ),

              SizedBox(height: 32),

              // Create Account Button
              SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: RedButton(buttonText: "Create Account", onPressed: () => Get.to(SignUpProcessVendorView()),)
              ),

              SizedBox(height: 12),

              // Already have account
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                    ),
                  ),
                  TextButton(
                    onPressed: () => Get.to(LoginVendorView()),
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        color: Color(0xFFDC143C),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16),

              // Terms and Privacy Policy
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'By creating an account, you agree to our ',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                          height: 1.4,
                        ),
                      ),
                      TextSpan(
                        text: 'Terms of Use',
                        style: TextStyle(
                          color: Color(0xFFDC143C),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: 1.4,
                        ),
                      ),
                      TextSpan(
                        text: ' and ',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                          height: 1.4,
                        ),
                      ),
                      TextSpan(
                        text: 'Privacy Policy',
                        style: TextStyle(
                          color: Color(0xFFDC143C),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
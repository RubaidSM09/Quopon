import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:quopon/app/modules/Review/views/review_view.dart';
import 'package:quopon/app/modules/signup/views/signup_vendor_view.dart';
import 'package:quopon/common/custom_textField.dart';
import 'package:quopon/common/red_button.dart';

import '../controllers/login_vendor_controller.dart';

class LoginVendorView extends GetView<LoginVendorController> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

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
                  child: Image.asset(
                    'assets/images/login/Logo Icon.png',
                    fit: BoxFit.cover,
                  )
              ),

              SizedBox(height: 32),

              // Title
              Text(
                'Log In to Manage Your Business',
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
                'Log in to manage your deals, track redemptions, and connect with your customers.',
                style: TextStyle(
                  fontSize: 13.8,
                  color: Colors.grey[600],
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 48),

              // Email Field
              CustomTextField(
                  headingText: 'Email Address',
                  fieldText: 'Enter email address',
                  iconImagePath: 'assets/images/login/Email.png',
                  controller: _emailController,
                  isRequired: true
              ),

              SizedBox(height: 12),

              // Password Field
              CustomTextField(
                  headingText: 'Password',
                  fieldText: '••••••••••••',
                  iconImagePath: 'assets/images/login/Password.png',
                  controller: _passwordController,
                  isRequired: true,
                  isPassword: true
              ),

              SizedBox(height: 8),

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
                      color: Color(0xFFDC143C),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 12),

              // Login Button
              RedButton(buttonText: 'Log In', onPressed: () {
                Get.offNamed('/home');
                Get.dialog(ReviewView());
              }),

              SizedBox(height: 16),

              // OR CONTINUE WITH
              Row(
                children: [
                  Expanded(child: Divider(color: Colors.grey[300])),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'OR CONTINUE WITH',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(child: Divider(color: Colors.grey[300])),
                ],
              ),

              SizedBox(height: 24),

              // Google Login Button
              Container(
                width: double.infinity,
                height: 56,
                child: OutlinedButton(
                  onPressed: () {
                    // Handle Google login
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: BorderSide(color: Colors.grey[300]!),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage('https://developers.google.com/identity/images/g-logo.png'),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Text(
                        'Continue With Google',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 8),

              // Apple Login Button
              Container(
                width: double.infinity,
                height: 56,
                child: OutlinedButton(
                  onPressed: () {
                    // Handle Apple login
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: BorderSide(color: Colors.grey[300]!),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.apple,
                        color: Colors.black,
                        size: 24,
                      ),
                      SizedBox(width: 12),
                      Text(
                        'Continue With Apple',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 16),

              // Create Account
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                    ),
                  ),
                  TextButton(
                    onPressed: () => Get.to(SignupVendorView()),
                    child: Text(
                      'Create Account',
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
            ],
          ),
        ),
      ),
    );
  }
}
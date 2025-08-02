import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil
import 'package:get/get.dart';
import 'package:quopon/app/modules/landing/views/landing_view.dart';
import 'package:quopon/app/modules/signUpProcess/views/food_preferences_view.dart';
import 'package:quopon/app/modules/signUpProcess/views/location_view.dart';
import 'package:quopon/app/modules/signUpProcess/views/profile_complete_view.dart';

import '../../../../../common/customTextButton.dart';

class SignUpProcessView extends StatefulWidget {
  const SignUpProcessView({super.key});

  @override
  _SignUpProcessViewState createState() => _SignUpProcessViewState();
}

class _SignUpProcessViewState extends State<SignUpProcessView> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Progress Bar
            Container(
              padding: EdgeInsets.all(20.h), // Apply ScreenUtil to padding
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 4.h, // Apply ScreenUtil to height
                      decoration: BoxDecoration(
                        color: _currentPage >= 0
                            ? Color(0xFFD62828)
                            : Colors.grey[300],
                        borderRadius: BorderRadius.circular(2.r), // Apply ScreenUtil to border radius
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w), // Apply ScreenUtil to width
                  Expanded(
                    child: Container(
                      height: 4.h, // Apply ScreenUtil to height
                      decoration: BoxDecoration(
                        color: _currentPage >= 1
                            ? Color(0xFFD62828)
                            : Colors.grey[300],
                        borderRadius: BorderRadius.circular(2.r), // Apply ScreenUtil to border radius
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w), // Apply ScreenUtil to width
                  Expanded(
                    child: Container(
                      height: 4.h, // Apply ScreenUtil to height
                      decoration: BoxDecoration(
                        color: _currentPage >= 2
                            ? Color(0xFFD62828)
                            : Colors.grey[300],
                        borderRadius: BorderRadius.circular(2.r), // Apply ScreenUtil to border radius
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Page View
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                children: [
                  FoodPreferencesScreen(
                    onNext: () => _nextPage(),
                    onSkip: () => _nextPage(),
                  ),
                  LocationScreen(
                    onNext: () => _nextPage(),
                    onSkip: () => _nextPage(),
                  ),
                  ProfileCompleteScreen(
                    onFinish: () => _finishOnboarding(),
                    onSkip: () => _finishOnboarding(),
                  ),
                ],
              ),
            ),

            _buildBottomButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomButtons() {
    return Container(
      padding: EdgeInsets.all(20.h), // Apply ScreenUtil to padding
      child: Column(
        children: [
          // Skip Button
          GradientButton(
            text: 'Skip',
            textStyle: TextStyle(color: Color(0xFF020711)),
            onPressed: () => _handleSkip(),
            colors: [Color(0xFFF4F5F6), Color(0xFFEEF0F3)],
            borderColor: [Colors.white, Color(0xFFEEF0F3)],
            boxShadow: [BoxShadow(color: Color(0xFFDFE4E9), spreadRadius: 1)],
          ),
          SizedBox(height: 20.h), // Apply ScreenUtil to height
          // Next/Finish Button
          GradientButton(
            text: _getButtonText(),
            onPressed: () => _handleNext(),
            colors: [const Color(0xFFD62828), const Color(0xFFC21414)],
            boxShadow: [const BoxShadow(color: Color(0xFF9A0000), spreadRadius: 1)],
            child: Text(
              _getButtonText(),
              style: TextStyle(
                fontSize: 16.sp, // Use ScreenUtil for font size
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getButtonText() {
    if (_currentPage == 2) {
      return 'Finish Setup';
    }
    return 'Next';
  }

  void _handleSkip() {
    _finishOnboarding();
  }

  void _handleNext() {
    if (_currentPage == 2) {
      _finishOnboarding();
    } else {
      _nextPage();
    }
  }

  void _nextPage() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _finishOnboarding() {
    // Navigate to main app or handle completion
    Get.to(LandingView());
    // Example: Navigate to home screen
    // Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

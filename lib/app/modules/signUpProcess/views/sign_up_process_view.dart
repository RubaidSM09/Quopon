import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:quopon/app/modules/signUpProcess/views/food_preferences_view.dart';
import 'package:quopon/app/modules/signUpProcess/views/location_view.dart';
import 'package:quopon/app/modules/signUpProcess/views/profile_complete_view.dart';

import '../../../../common/customTextButton.dart';
import '../../../../common/red_button.dart';

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
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 4,
                      decoration: BoxDecoration(
                        color: _currentPage >= 0 ? Color(0xFFD62828) : Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      height: 4,
                      decoration: BoxDecoration(
                        color: _currentPage >= 1 ? Color(0xFFD62828) : Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      height: 4,
                      decoration: BoxDecoration(
                        color: _currentPage >= 2 ? Color(0xFFD62828) : Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
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
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          // Skip Button
          GradientButton(
            text: 'Skip',
            textStyle: TextStyle(color: Color(0xFF020711)),
            onPressed: () => _handleSkip(),
            colors: [Color(0xFFF4F5F6), Color(0xFFEEF0F3)],
          ),
          SizedBox(height: 20),
          // Next/Finish Button
          RedButton(
            buttonText: _getButtonText(),
            onPressed: () => _handleNext(),
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
    // print('Onboarding completed');
    Get.offNamed('/home');
    // Example: Navigate to home screen
    // Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:quopon/app/modules/signUpProcess/controllers/sign_up_process_vendor_controller.dart';
import 'package:quopon/app/modules/signUpProcess/views/business_profile_vendor_view.dart';
import 'package:quopon/app/modules/signUpProcess/views/food_preferences_view.dart';
import 'package:quopon/app/modules/signUpProcess/views/location_view.dart';
import 'package:quopon/app/modules/signUpProcess/views/profile_complete_view.dart';
import 'package:quopon/app/modules/signUpProcess/views/vendor_business_hour_view.dart';
import 'package:quopon/app/modules/vendor_dashboard/views/vendor_dashboard_view.dart';

import '../../../../../common/customTextButton.dart';
import '../../../../../common/red_button.dart';

class SignUpProcessVendorView extends GetView<SignUpProcessVendorController> {
  final PageController _pageController = PageController();
  RxInt currentPage = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9FBFC),
      body: SafeArea(
        child: Obx(() {
          return Column(
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
                          color: currentPage.value >= 0 ? Color(0xFFD62828) : Colors
                              .grey[300],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        height: 4,
                        decoration: BoxDecoration(
                          color: currentPage.value >= 1 ? Color(0xFFD62828) : Colors
                              .grey[300],
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
                    currentPage.value = index;
                  },
                  children: [
                    BusinessProfileVendorView(
                      onNext: () => _nextPage(),
                      onSkip: () => _nextPage(),
                    ),
                    VendorBusinessHourView(
                      onNext: () => _nextPage(),
                      onSkip: () => _nextPage(),
                    ),
                  ],
                ),
              ),

              _buildBottomButtons(),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildBottomButtons() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          RedButton(
            buttonText: _getButtonText(),
            onPressed: () => _handleNext(),
          ),
        ],
      ),
    );
  }

  String _getButtonText() {
    if (currentPage.value == 1) {
      return 'Finish Setup';
    }
    return 'Next';
  }

  void _handleNext() {
    if (currentPage.value == 1) {
      _finishOnboarding();
    } else {
      _nextPage();
    }
  }

  void _nextPage() {
    if (currentPage.value < 2) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _finishOnboarding() {
    // Navigate to main app or handle completion
    // print('Onboarding completed');
    Get.to(VendorDashboardView());
    // Example: Navigate to home screen
    // Navigator.pushReplacementNamed(context, '/home');
  }
}
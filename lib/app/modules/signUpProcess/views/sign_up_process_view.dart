import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'food_preferences_view.dart';
import 'location_view.dart';
import 'profile_complete_view.dart';
import '../../landing/views/landing_view.dart';
import '../../../../../common/customTextButton.dart';
import '../controllers/sign_up_process_controller.dart';

class SignUpProcessView extends GetView<SignUpProcessController> {
  const SignUpProcessView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SignUpProcessController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // === Progress bar (UNCHANGED UI) ===
            Padding(
              padding: EdgeInsets.all(20.h),
              child: Obx(() {
                final idx = controller.currentPage.value;
                Widget seg(int i) => Expanded(
                  child: Container(
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: idx >= i ? const Color(0xFFD62828) : Colors.grey[300],
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                );
                return Row(children: [seg(0), SizedBox(width: 8.w), seg(1), SizedBox(width: 8.w), seg(2)]);
              }),
            ),

            // === Pages (UNCHANGED content order) ===
            Expanded(
              child: PageView(
                controller: controller.pageController,
                onPageChanged: controller.onPageChanged,
                children: [
                  FoodPreferencesScreen(
                    onNext: controller.nextPage,
                    onSkip: controller.nextPage,
                  ),
                  LocationScreen(
                    onNext: controller.nextPage,
                    onSkip: controller.nextPage,
                  ),
                  ProfileCompleteScreen(
                    onFinish: controller.finishOnboarding,
                    onSkip: controller.finishOnboarding,
                  ),
                ],
              ),
            ),

            // === Bottom buttons (using your GradientButton) ===
            Padding(
              padding: EdgeInsets.all(20.h),
              child: Obx(() {
                final last = controller.currentPage.value == 2;
                return Column(
                  children: [
                    GradientButton(
                      text: 'Skip',
                      textStyle: const TextStyle(color: Color(0xFF020711)),
                      onPressed: controller.finishOnboarding,
                      colors: const [Color(0xFFF4F5F6), Color(0xFFEEF0F3)],
                      borderColor: const [Colors.white, Color(0xFFEEF0F3)],
                      boxShadow: const [BoxShadow(color: Color(0xFFDFE4E9), spreadRadius: 1)],
                    ),
                    SizedBox(height: 20.h),
                    GradientButton(
                      text: last ? 'Finish Setup' : 'Next',
                      onPressed: last
                          ? () {
                        controller.fullName.value = controller.nameController.text;
                        controller.phoneNumber.value = controller.phoneController.text;
                        controller.finishOnboarding();
                      }
                          : controller.nextPage,
                      colors: const [Color(0xFFD62828), Color(0xFFC21414)],
                      boxShadow: const [BoxShadow(color: Color(0xFF9A0000), spreadRadius: 1)],
                      child: Text(
                        last ? 'Finish Setup' : 'Next',
                        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: Colors.white),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

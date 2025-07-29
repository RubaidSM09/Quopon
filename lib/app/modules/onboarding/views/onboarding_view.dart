import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quopon/common/customTextButton.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../onboarding/controllers/onboarding_controller.dart';
import 'onboarding_page_view_view.dart';

class OnboardingView extends GetView<OnboardingController> {
  final OnboardingController controller = Get.put(OnboardingController());

  OnboardingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background Image
          Image.asset(
            'assets/images/onboarding/Background.png',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: const Color(0xFFF5F5DC),
                child: const Center(
                  child: Icon(
                    Icons.restaurant,
                    size: 50,
                    color: Colors.grey,
                  ),
                ),
              );
            },
          ),

          Padding(
            padding: EdgeInsets.fromLTRB(0, 584.h, 0, 0), // Use ScreenUtil for padding
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.r), // Use ScreenUtil for radius
                  topRight: Radius.circular(24.r), // Use ScreenUtil for radius
                ),
              ),
            ),
          ),

          // Page View
          PageView(
            controller: controller.pageController,
            onPageChanged: (index) {
              controller.currentPage.value = index;
            },
            children: [
              OnboardingPageViewView(
                title: 'Explore Exclusive Local Offers',
                description:
                'Find the best nearby discounts from trusted vendors tailored to your location and preferences.',
              ),
              OnboardingPageViewView(
                title: 'Activate Deals Instantly',
                description:
                'Unlock offers with a QR code or choose delivery saving has never been this fast or flexible.',
              ),
              OnboardingPageViewView(
                title: 'Go Premium Save More!',
                description:
                'Access member-only deals, early releases, and exclusive perks with Coupons+.',
              ),
            ],
          ),

          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 725.h, 20.w, 20.h), // Use ScreenUtil for padding
            child: Column(
              children: [
                // Page Indicator
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Obx(() => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            3,
                                (index) => AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: EdgeInsets.symmetric(horizontal: 4.w), // Use ScreenUtil for margin
                              height: 8.h, // Use ScreenUtil for height
                              width: controller.currentPage.value == index ? 24.w : 8.w, // Use ScreenUtil for width
                              decoration: BoxDecoration(
                                color: controller.currentPage.value == index
                                    ? const Color(0xFFD62828)
                                    : const Color(0xFFD0DFEE),
                                borderRadius: BorderRadius.circular(4.r), // Use ScreenUtil for border radius
                              ),
                            ),
                          ),
                        )),
                      ],
                    ),
                  ),
                ),

                // Next Button
                Container(
                  width: double.infinity,
                  height: 50.h, // Use ScreenUtil for height
                  margin: EdgeInsets.only(bottom: 30.h), // Use ScreenUtil for margin
                  child: Obx(() => GradientButton(
                    text: controller.currentPage.value == 2 ? 'Get Started' : 'Next',
                    onPressed: () => controller.nextPage(),
                    colors: [const Color(0xFFD62828), const Color(0xFFC21414)],
                    boxShadow: [const BoxShadow(color: Color(0xFF9A0000), spreadRadius: 1)],
                    child: Text(
                      controller.currentPage.value == 2 ? 'Get Started' : 'Next',
                      style: TextStyle(
                        fontSize: 16.sp, // Use ScreenUtil for font size
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

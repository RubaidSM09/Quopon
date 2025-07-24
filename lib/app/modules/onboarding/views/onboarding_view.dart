import 'package:flutter/material.dart';

import 'package:get/get.dart';

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
            padding: const EdgeInsets.fromLTRB(0, 550, 0, 0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                )
              ),
            ),
          ),

          PageView(
          controller: controller.pageController,
          onPageChanged: (index) {
            controller.currentPage.value = index;
          },
          children: [
            OnboardingPageViewView(
              title: 'Explore Exclusive Local Offers',
              description: 'Find the best nearby discounts from trusted vendors tailored to your location and preferences.',
            ),
            OnboardingPageViewView(
              title: 'Activate Deals Instantly',
              description: 'Unlock offers with a QR code or choose delivery saving has never been this fast or flexible.',
            ),
            OnboardingPageViewView(
              title: 'Go Premium Save More!',
              description: 'Access member-only deals, early releases, and exclusive perks with Coupons+.',
            ),
          ],
        ),

          Padding(
            padding: const EdgeInsets.fromLTRB(20, 700, 20, 20),
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
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              height: 8,
                              width: controller.currentPage.value == index ? 24 : 8,
                              decoration: BoxDecoration(
                                color: controller.currentPage.value == index
                                    ? Colors.red
                                    : Colors.grey.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(4),
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
                  height: 50,
                  margin: const EdgeInsets.only(bottom: 30),
                  child: Obx(() => ElevatedButton(
                    onPressed: () => controller.nextPage(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      controller.currentPage.value == 2 ? 'Get Started' : 'Next',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )),
                ),
              ],
            ),
          ),
      ]
      ),
    );
  }
}

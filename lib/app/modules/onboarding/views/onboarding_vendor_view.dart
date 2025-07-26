import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quopon/app/modules/login/views/login_vendor_view.dart';
import 'package:quopon/app/modules/signup/views/signup_vendor_view.dart';
import 'package:quopon/common/customTextButton.dart';

import '../controllers/onboarding_vendor_controller.dart';

class OnboardingVendorView extends GetView {
  final OnboardingVendorController onboardingVendorController = Get.put(OnboardingVendorController());

  OnboardingVendorView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return Stack(
          children: [
            // Background Image
            Image.asset(
              onboardingVendorController.images[onboardingVendorController.currentIndex.value],
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),

            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.white, Colors.transparent],
                  stops: [0.25, 1.0],
                ),
              ),
            ),

            // Overlay content
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Title Text
                Spacer(),
                Text(
                  onboardingVendorController.titles[onboardingVendorController.currentIndex.value],
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF020711),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 5,),
                // Description Text
                Text(
                  onboardingVendorController.descriptions[onboardingVendorController.currentIndex.value],
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Color(0xFF6F7E8D),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30,),

                // Dots Indicator (with red line for active index)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    onboardingVendorController.images.length,
                        (index) {
                      // If it's the active index, display a red line, otherwise show a dot
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: index == onboardingVendorController.currentIndex.value
                            ? Container(
                          width: 30,
                          height: 12,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Color(0xFFD62828),
                          ),
                        )
                            : CircleAvatar(
                          radius: 6,
                          backgroundColor: Color(0xFFD0DFEE),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 30),

                // Spacer(),
                // Buttons for create account and login
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      GradientButton(
                        text: 'Create an Account',
                        onPressed: () {
                          Get.to(SignupVendorView());
                        },
                        colors: [Color(0xFFD62828), Color(0xFFD62828)],
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Create an Account',
                              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Colors.white),
                            ),
                            SizedBox(width: 10,),
                            Icon(Icons.arrow_forward, color: Colors.white,)
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      GradientButton(
                        text: 'Log in an Account',
                        onPressed: () {
                          Get.to(LoginVendorView());
                        },
                        borderColor: Color(0xFFFFFFFF),
                        colors: [Color(0xFFF4F5F6), Color(0xFFEEF0F3)],
                        child: Text(
                          'Log in an Account',
                          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Color(0xFF020711)),
                        ),
                      ),
                      SizedBox(height: 30,)
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      }),
    );
  }
}

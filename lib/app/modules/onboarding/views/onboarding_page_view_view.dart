import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../controllers/onboarding_controller.dart';

class OnboardingPageViewView extends GetView<OnboardingController> {
  final String title;
  final String description;

  const OnboardingPageViewView({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Main Content
        Expanded(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.w, 616.h, 20.w, 100.h), // Use ScreenUtil for padding
            child: Column(
              children: [
                // Title and Description
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 24.sp, // Use ScreenUtil for font size
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          height: 1.2.h,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 12.h), // Use ScreenUtil for height spacing
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 14.sp, // Use ScreenUtil for font size
                          color: Colors.grey,
                          height: 1.4.h,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

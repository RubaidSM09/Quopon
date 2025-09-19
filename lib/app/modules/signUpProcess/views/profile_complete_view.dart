// lib/app/modules/signUpProcess/views/profile_complete_view.dart
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quopon/common/custom_textField.dart';
import '../controllers/sign_up_process_controller.dart';

class ProfileCompleteScreen extends GetView<SignUpProcessController> {
  final VoidCallback onFinish;
  final VoidCallback onSkip;

  ProfileCompleteScreen({super.key, required this.onFinish, required this.onSkip});

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Complete Your Profile',
              style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold, color: const Color(0xFF020711))),
          SizedBox(height: 8.h),
          Text(
            'Add your details to personalize your Goupon\nexperience.',
            style: TextStyle(fontSize: 16.sp, color: const Color(0xFF6F7E8D), fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 40.h),
          Center(
            child: Column(
              children: [
                GestureDetector(
                  onTap: controller.pickProfileImage,
                  child: Obx(() {
                    final img = controller.profileImage.value;
                    return Container(
                      width: 80.w,
                      height: 80.h,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        shape: BoxShape.circle,
                      ),
                      child: ClipOval(
                        child: img == null
                            ? Image.asset(
                          'assets/images/CompleteProfile/Cloud.png',
                          color: const Color(0xFF6F7E8D),
                          height: 30.h,
                          width: 30.w,
                        )
                            : Image.file(
                          File(img.path),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }),
                ),
                SizedBox(height: 8.h),
                Text('Upload Profile Picture',
                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: const Color(0xFF020711))),
              ],
            ),
          ),
          SizedBox(height: 40.h),

          GetInTouchTextField(
            headingText: 'Full Name',
            fieldText: 'Enter full name',
            iconImagePath: '',
            controller: controller.nameController,  // <— from GetX
            isRequired: false,
          ),
          SizedBox(height: 20.h),
          GetInTouchTextField(
            headingText: 'Phone Number',
            fieldText: 'Enter phone number',
            iconImagePath: '',
            controller: controller.phoneController, // <— from GetX
            isRequired: false,
          ),
          SizedBox(height: 20.h),

          CustomCategoryField(
            fieldName: 'Language',
            isRequired: false,
            selectedCategory: 'English',
            categories: ['English', 'Spanish', 'German', 'French'],
            onCategorySelected: (v) => controller.language.value = v,
          ),

          const Spacer(),
        ],
      ),
    );
  }
}

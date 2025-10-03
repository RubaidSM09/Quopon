import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil
import 'package:quopon/app/modules/signUpProcess/controllers/sign_up_process_vendor_controller.dart';

import '../../../../common/customTextButton.dart';
import '../../../data/model/vendor_category.dart';

class BusinessProfileVendorView extends GetView<SignUpProcessVendorController> {
  final VoidCallback onNext;
  final VoidCallback onSkip;

  BusinessProfileVendorView({super.key, required this.onNext, required this.onSkip});

  @override
  Widget build(BuildContext context) {
    Get.put(SignUpProcessVendorController());
    controller.fetchVendorCategories();

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.w), // Use ScreenUtil for padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Business Profile Setup',
              style: TextStyle(
                fontSize: 28.sp, // Use ScreenUtil for font size
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8.h), // Use ScreenUtil for height spacing
            Text(
              'Provide your business details to begin onboarding with Qoupon.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp, // Use ScreenUtil for font size
                color: Colors.grey[600],
              ),
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

            _buildTextField(
              'Store Name',
              'Enter store name',
              controller.nameController,
            ),
            SizedBox(height: 20.h), // Use ScreenUtil for height spacing
            _buildTextField(
              'KVK Number',
              'Enter KVK number',
              controller.kvkNumberController,
            ),
            SizedBox(height: 20.h), // Use ScreenUtil for height spacing
            _buildTextField(
              'Phone Number',
              'Enter phone number',
              controller.phoneController,
            ),
            SizedBox(height: 20.h), // Use ScreenUtil for height spacing
            _buildTextField(
              'Store Address',
              'Enter store address',
              controller.addressController,
            ),
            SizedBox(height: 20.h), // Use ScreenUtil for height spacing
            Obx(() {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Category',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: DropdownButton<int>(
                      value: controller.selectedCategoryId.value == 0
                          ? null
                          : controller.selectedCategoryId.value,
                      isExpanded: true,
                      underline: Container(),
                      items: [
                        DropdownMenuItem<int>(
                          value: 0,
                          child: Text('Select'),
                        ),
                        ...controller.vendorCategories.map((VendorCategory category) {
                          return DropdownMenuItem<int>(
                            value: category.id, // Store the id
                            child: Text(category.categoryTitle),
                          );
                        }),
                      ],
                      onChanged: (int? newValue) {
                        controller.selectedCategoryId.value = newValue!;
                      },
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String hint, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16.sp, // Use ScreenUtil for font size
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 8.h), // Use ScreenUtil for height spacing
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey[500]),
            filled: true,
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r), // Use ScreenUtil for border radius
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h), // Use ScreenUtil for padding
          ),
        ),
      ],
    );
  }
}
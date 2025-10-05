import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../common/custom_textField.dart';
import '../../signUpProcess/views/vendor_business_hour_row_view.dart';
import '../controllers/vendor_side_profile_controller.dart';
import '../../../../common/ChooseField.dart';
import '../../../../common/EditProfileField.dart';
import '../../../../common/customTextButton.dart';

class EditBusinessProfileView extends GetView<VendorSideProfileController> {
  const EditBusinessProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    // ❌ Do NOT create controllers or call network in build
    // Get.put(VendorSideProfileController());
    // controller.fetchBusinessHours();

    return Scaffold(
      backgroundColor: const Color(0xFFF9FBFC),
      body: SafeArea(
        child: Obx(() {
          final profile = controller.profileData;

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                children: [
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(onTap: () => Get.back(), child: const Icon(Icons.arrow_back)),
                      Text("Edit Business Profile", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp)),
                      const SizedBox(width: 24),
                    ],
                  ),
                  SizedBox(height: 16.h),

                  // Avatar (logo)
                  Column(
                    children: [
                      // in EditProfileView build()
                      GestureDetector(
                        onTap: controller.pickProfileImage,
                        child: Obx(() {
                          final picked = controller.profileImage.value;
                          final existingUrl = controller.profilePictureUrl.value;

                          Widget img;
                          if (picked != null) {
                            // freshly picked local file
                            img = Image.file(File(picked.path), fit: BoxFit.cover);
                          } else if (existingUrl.isNotEmpty) {
                            // show existing backend image
                            img = Image.network(existingUrl, fit: BoxFit.cover);
                          } else {
                            // placeholder
                            img = Image.asset(
                              'assets/images/CompleteProfile/Cloud.png',
                              color: const Color(0xFF6F7E8D),
                              height: 30.h,
                              width: 30.w,
                            );
                          }

                          return Container(
                            width: 80.w,
                            height: 80.h,
                            decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                            clipBehavior: Clip.antiAlias,
                            child: img,
                          );
                        }),
                      ),
                      SizedBox(height: 10.h),
                      Text("Upload Profile Picture",
                          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp)
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),

                  // Fields (use controller.*.text; hints from profile map if you want)
                  EditProfileField(
                    label: 'Name',
                    defaultText: controller.nameController.text,
                    hintText: (profile['name'] ?? '').toString(),
                    editProfileController: controller.nameController,
                  ),
                  // Vendor email often read-only (but you can keep it editable if your API allows)
                  EditProfileField(
                    label: 'Email Address',
                    defaultText: controller.emailController.text,
                    hintText: (profile['vendor_email'] ?? '').toString(),
                    editProfileController: controller.emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  EditProfileField(
                    label: 'Phone Number',
                    defaultText: controller.phoneController.text,
                    hintText: (profile['phone_number'] ?? '').toString(),
                    editProfileController: controller.phoneController,
                    keyboardType: TextInputType.phone,
                  ),
                  EditProfileField(
                    label: 'Address',
                    defaultText: controller.addressController.text,
                    hintText: (profile['address'] ?? '').toString(),
                    editProfileController: controller.addressController,
                    keyboardType: TextInputType.streetAddress,
                    maxLines: 2,
                  ),
                  EditProfileField(
                    label: 'KVK Number',
                    defaultText: controller.kvkController.text,
                    hintText: (profile['kvk_number'] ?? '').toString(),
                    editProfileController: controller.kvkController,
                  ),

                  Obx(() {
                    final names = controller.categoryNames;
                    final selectedName = controller.selectedCategoryName.value;

                    return CustomCategoryField(
                      fieldName: 'Category',
                      isRequired: true,
                      selectedCategory: names.isNotEmpty ? selectedName : 'Select',
                      categories: names.isNotEmpty ? names : const ['Select'],
                      onCategorySelected: (name) {
                        controller.selectedCategoryName.value = name;
                        controller.setCategoryId(controller.nameToId[name] ?? 0);
                      },
                    );
                  }),

                  SizedBox(height: 20.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Business Hours', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: const Color(0xFF020711))),
                      const SizedBox.shrink(),
                    ],
                  ),
                  SizedBox(height: 8.h),

                  Obx(() {
                    return Container(
                      padding: EdgeInsets.all(16.r),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: Colors.white,
                        boxShadow: [BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 16)],
                      ),
                      child: Column(
                        children: List.generate(controller.businessSchedule.length, (index) {
                          final schedule = controller.businessSchedule[index];
                          return VendorBusinessHourRowView(
                            isActive: !schedule.isClosed,
                            day: schedule.day,
                            startTimeRx: controller.startTimes[index],
                            endTimeRx: controller.endTimes[index],
                            index: index,
                          );
                        }),
                      ),
                    );
                  }),

                  SizedBox(height: 20.h),
                ],
              ),
            ),
          );
        }),
      ),

      bottomNavigationBar: Container(
        padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h, bottom: 32.h),
        height: 106.h,
        decoration: const BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 16)]),
        child: GradientButton(
          text: 'Save Changes',
          onPressed: () async {
            // ✅ PATCH vendor info first
            await controller.updateProfile();
            // ✅ then (separately) patch hours (unchanged behavior)
            await controller.patchBusinessHours();

            // pop after both complete
            Get.back();
          },
          colors: const [Color(0xFFD62828), Color(0xFFC21414)],
        ),
      ),
    );
  }
}

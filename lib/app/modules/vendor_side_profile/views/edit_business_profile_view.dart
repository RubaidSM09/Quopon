import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil
import '../../signUpProcess/views/vendor_business_hour_row_view.dart';
import '../controllers/vendor_side_profile_controller.dart';
import '../../../../common/ChooseField.dart';
import '../../../../common/EditProfileField.dart';
import '../../../../common/customTextButton.dart';
import '../../../../common/custom_textField.dart';

class EditBusinessProfileView extends GetView<VendorSideProfileController> {
  const EditBusinessProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(VendorSideProfileController());
    controller.fetchBusinessHours();

    // controller.nameController.text = controller.profileData.value['name'] ?? '';
    // controller.phoneController.text = controller.profileData.value['phone_number'] ?? '';
    // controller.addressController.text = controller.profileData.value['address'] ?? '';
    // controller.kvkController.text = controller.profileData.value['kvk_number'] ?? '';

    return Scaffold(
      backgroundColor: Color(0xFFF9FBFC),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              // Title and Back Button
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(Icons.arrow_back),
                  ),
                  Text(
                    "Edit Business Profile",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(),
                ],
              ),

              // Avatar and Name Editing
              Obx(() {
                final profile = controller.profileData.value;
                return Column(
                  children: [
                    CircleAvatar(
                      radius: 40.r,
                      backgroundImage: profile['logo_image'] != null
                          ? NetworkImage(profile['logo_image'])
                          : AssetImage(
                        "assets/images/deals/details/Starbucks_Logo.png",
                      ),
                    ),
                    SizedBox(height: 10.h),
                    EditProfileField(
                      label: 'Name',
                      editProfileController: controller.nameController,
                      hintText: profile['name'],
                      defaultText: profile['name'],
                    ),
                    EditProfileField(
                      label: 'Email Address',
                      editProfileController: controller.emailController,
                      defaultText: profile['vendor_email'],
                      hintText: profile['vendor_email'],
                    ),
                    EditProfileField(
                      label: 'Phone Number',
                      editProfileController: controller.phoneController,
                      hintText: profile['phone_number'],
                      defaultText: profile['phone_number'],
                    ),
                    EditProfileField(
                      label: 'Address',
                      editProfileController: controller.addressController,
                      hintText: profile['address'],
                      defaultText: profile['address'],
                    ),

                    Obx(() {
                      final names = controller.categoryNames;
                      final selectedName =
                          controller.selectedCategoryName.value;

                      return CustomCategoryField(
                        fieldName: 'Category',
                        isRequired: true,
                        selectedCategory: names.isNotEmpty
                            ? selectedName
                            : 'Select',
                        categories: names.isNotEmpty ? names : const ['Select'],
                        onCategorySelected: (name) {
                          controller.selectedCategoryName.value = name;
                          controller.setCategoryId(
                            controller.nameToId[name] ?? 0,
                          );
                        },
                      );
                    }),
                  ],
                );
              }),
              SizedBox(height: 20.h), // Use ScreenUtil for spacing

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Business Hours',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF020711),
                    ),
                  ),
                  SizedBox.shrink(),
                ],
              ),
              SizedBox(height: 8.h),

              Obx(() {
                return Container(
                  padding: EdgeInsets.all(16.r),  // Use ScreenUtil for padding
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),  // Use ScreenUtil for radius
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
                        // 🔧 pass the RxString and index instead of a plain String
                        endTimeRx: controller.endTimes[index],
                        index: index,
                      );
                    }),
                  ),
                );
              }),

              SizedBox(height: 20.h), // Use ScreenUtil for spacing
            ],
          ),
        ),
      ),

      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
          left: 16.w,
          right: 16.w,
          top: 16.h,
          bottom: 32.h,
        ), // Use ScreenUtil for padding
        height: 106.h, // Use ScreenUtil for height
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 16),
          ],
        ),
        child: GradientButton(
          text: 'Save Changes',
          onPressed: () {
            // Send updated profile info using the patch method
            controller.updateProfile(
              controller.nameController.text != '' ? controller.nameController.text : controller.profileData.value['name'],
              controller.kvkController.text != '' ? controller.kvkController.text : controller.profileData.value['kvk_number'],
              controller.phoneController.text != '' ? controller.phoneController.text : controller.profileData.value['phone_number'],
              controller.addressController.text != '' ? controller.addressController.text : controller.profileData.value['address'],
              controller.selectedCategoryId.value,
            );

            controller.patchBusinessHours();
            // Optionally navigate back or show a confirmation
            Get.back();
          },
          colors: [Color(0xFFD62828), Color(0xFFC21414)],
        ),
      ),
    );
  }

  String? _NumberToDay (int day) {
    if(day == 0) {
      return 'Monday';
    }
    else if (day == 1) {
      return 'Tuesday';
    }
    else if (day == 2) {
      return 'Wednesday';
    }
    else if (day == 3) {
      return 'Thursday';
    }
    else if (day == 4) {
      return 'Friday';
    }
    else if (day == 5) {
      return 'Saturday';
    }
    else if (day == 6) {
      return 'Sunday';
    }
    else {
      return null;
    }
  }
}

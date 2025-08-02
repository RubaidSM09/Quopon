import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';  // Import ScreenUtil
import 'package:quopon/app/modules/vendor_menu/views/vendor_menu_view.dart';

import '../../../../common/PictureUploadField.dart';
import '../../../../common/customTextButton.dart';
import '../../../../common/custom_textField.dart';
import '../controllers/vendor_add_menu_controller.dart';

class VendorAddMenuView extends GetView<VendorAddMenuController> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  final RxString startDate = ''.obs;

  VendorAddMenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9FBFC),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16.r, 32.h, 16.r, 16.h),  // Use ScreenUtil for padding
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(Icons.arrow_back, size: 24.sp),  // Use ScreenUtil for icon size
                ),
                Text(
                  'Add Menu Item',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18.sp,  // Use ScreenUtil for font size
                      color: Color(0xFF020711)
                  ),
                ),
                SizedBox.shrink()
              ],
            ),

            SizedBox(height: 20.h),  // Use ScreenUtil for spacing

            PictureUploadField(height: 220.h, width: 398.w),  // Use ScreenUtil for height and width

            SizedBox(height: 20.h),  // Use ScreenUtil for spacing

            GetInTouchTextField(
              headingText: 'Title',
              fieldText: 'Enter deal title',
              iconImagePath: '',
              controller: _titleController,
              isRequired: true,
            ),

            SizedBox(height: 20.h),  // Use ScreenUtil for spacing

            GetInTouchTextField(
              headingText: 'Description',
              fieldText: 'Write here...',
              iconImagePath: '',
              controller: _descriptionController,
              isRequired: true,
              maxLine: 6,
            ),

            SizedBox(height: 20.h),  // Use ScreenUtil for spacing

            CustomCategoryField(
              fieldName: 'Category',
              isRequired: true,
              selectedCategory: 'Breakfast',
              categories: ['Breakfast', 'Lunch', 'Dinner'],
            ),

            SizedBox(height: 20.h),  // Use ScreenUtil for spacing

            GetInTouchTextField(
              headingText: 'Description',
              fieldText: '0.00',
              iconImagePath: 'assets/images/Menu/USD.png',
              controller: _descriptionController,
              isRequired: true,
            ),

            SizedBox(height: 20.h),  // Use ScreenUtil for spacing

            CustomCategoryField(
              fieldName: 'Choose Modifier Groups',
              isRequired: true,
            ),
          ],
        ),
      ),

      bottomNavigationBar: Container(
        padding: EdgeInsets.only(left: 16.r, right: 16.r, top: 16.h, bottom: 32.h),  // Use ScreenUtil for padding
        height: 106.h,  // Use ScreenUtil for height
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 16)]
        ),
        child: GradientButton(
          text: 'Save',
          onPressed: () {
            Get.to(VendorMenuView());
          },
          colors: [Color(0xFFD62828), Color(0xFFC21414)],
        ),
      ),
    );
  }
}

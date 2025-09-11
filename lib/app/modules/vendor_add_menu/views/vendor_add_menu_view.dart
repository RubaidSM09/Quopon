import 'dart:io';

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
  final _priceController = TextEditingController(); // ✅ add price controller

  VendorAddMenuView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(VendorAddMenuController());

    return Scaffold(
      backgroundColor: const Color(0xFFF9FBFC),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16.r, 32.h, 16.r, 16.h),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: Get.back,
                  child: Icon(Icons.arrow_back, size: 24.sp),
                ),
                Text(
                  'Add Menu Item',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18.sp,
                    color: const Color(0xFF020711),
                  ),
                ),
                const SizedBox.shrink(),
              ],
            ),

            SizedBox(height: 20.h),

            // 🖼 Picture upload (expects a callback; keep your widget API, just pass the callback)
            Obx(() => PictureUploadField(
              height: 220.h,
              width: 398.w,
              file: controller.imageFile.value,          // shows preview if picked
              onImageSelected: (file) => controller.setImageFile(file),
            )),

            SizedBox(height: 20.h),

            GetInTouchTextField(
              headingText: 'Title',
              fieldText: 'Enter deal title',
              iconImagePath: '',
              controller: _titleController,
              isRequired: true,
            ),

            SizedBox(height: 20.h),

            GetInTouchTextField(
              headingText: 'Description',
              fieldText: 'Write here...',
              iconImagePath: '',
              controller: _descriptionController,
              isRequired: true,
              maxLine: 6,
            ),

            SizedBox(height: 20.h),

            // 🏷 Category picker (assumes your widget can give back the id)
            Obx(() {
              final names = controller.categoryNames;
              final selectedName = controller.selectedCategoryName.value;

              return CustomCategoryField(
                fieldName: 'Category',
                isRequired: true,
                selectedCategory: names.isNotEmpty ? selectedName : 'Select',
                categories: names.isNotEmpty ? names : const ['Select'],

                // from our earlier widget change:
                onCategorySelected: (name) {
                  controller.selectedCategoryName.value = name;
                  controller.setCategoryId(controller.nameToId[name] ?? 0);
                },
              );
            }),

            SizedBox(height: 20.h),

            // 💲 Price
            GetInTouchTextField(
              headingText: 'Price', // (your earlier label said Description — fixed)
              fieldText: '0.00',
              iconImagePath: 'assets/images/Menu/USD.png',
              controller: _priceController,
              isRequired: true,
            ),

            SizedBox(height: 20.h),

            // 🧩 Modifier groups (multi-select)
            Obx(() {
              final names = controller.categoryNames;
              final selectedName = controller.selectedCategoryName.value;

              return CustomCategoryField(
                fieldName: 'Category',
                isRequired: true,
                selectedCategory: names.isNotEmpty ? selectedName : 'Select',
                categories: names.isNotEmpty ? names : const ['Select'],

                // from our earlier widget change:
                onCategorySelected: (name) {
                  controller.selectedCategoryName.value = name;
                  controller.setCategoryId(controller.nameToId[name] ?? 0);
                },
              );
            }),
          ],
        ),
      ),

      bottomNavigationBar: Container(
        padding: EdgeInsets.only(left: 16.r, right: 16.r, top: 16.h, bottom: 32.h),
        height: 106.h,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 16)],
        ),
        child: GradientButton(
          text: 'Save',
          onPressed: () async {
            await controller.addMenu(
              title: _titleController.text.trim(),
              description: _descriptionController.text.trim(),
              price: _priceController.text.trim(),
              // You can omit overrides because we already set selectedCategoryId in the controller
            );
            // On success, you can navigate
            Get.to(VendorMenuView());
          },
          colors: const [Color(0xFFD62828), Color(0xFFC21414)],
        ),
      ),
    );
  }
}

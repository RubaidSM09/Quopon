import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quopon/app/modules/landing/views/landing_vendor_view.dart';
import 'package:quopon/app/modules/vendor_menu/views/vendor_menu_view.dart';

import '../../../../common/PictureUploadField.dart';
import '../../../../common/customTextButton.dart';
import '../../../../common/custom_textField.dart';
import '../controllers/vendor_add_menu_controller.dart';

class VendorAddMenuView extends GetView<VendorAddMenuController> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();

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
            // Header
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

            // Image
            Obx(() => PictureUploadField(
              height: 220.h,
              width: 398.w,
              file: controller.imageFile.value,
              onImageSelected: (file) => controller.setImageFile(file),
            )),

            SizedBox(height: 20.h),

            // Title
            GetInTouchTextField(
              headingText: 'Title',
              fieldText: 'Enter deal title',
              iconImagePath: '',
              controller: _titleController,
              isRequired: true,
            ),

            SizedBox(height: 20.h),

            // Description
            GetInTouchTextField(
              headingText: 'Description',
              fieldText: 'Write here...',
              iconImagePath: '',
              controller: _descriptionController,
              isRequired: true,
              maxLine: 6,
            ),

            SizedBox(height: 20.h),

            // Category picker
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

            // Price
            GetInTouchTextField(
              headingText: 'Price',
              fieldText: '0.00',
              iconImagePath: 'assets/images/Menu/USD.png',
              controller: _priceController,
              isRequired: true,
            ),

            SizedBox(height: 20.h),

            // ====== Modifiers UI ======
            _ModifiersSection(controller: controller),
          ],
        ),
      ),

      // Save button
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
            );
            Get.offAll(LandingVendorView());
            Get.to(VendorMenuView());
          },
          colors: const [Color(0xFFD62828), Color(0xFFC21414)],
        ),
      ),
    );
  }
}

/// ---------- UI WIDGET FOR MODIFIERS ----------
class _ModifiersSection extends StatelessWidget {
  final VendorAddMenuController controller;
  const _ModifiersSection({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Modifier*',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
            color: const Color(0xFF020711),
          ),
        ),
        SizedBox(height: 10.h),

        for (int i = 0; i < controller.modifiers.length; i++)
          _ModifierCard(
            group: controller.modifiers[i],
            onAddOption: () => controller.addOption(i),
          ),

        SizedBox(height: 10.h),

        // Add Modifiers
        GestureDetector(
          onTap: controller.addModifier,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 14.h),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add, size: 20.sp),
                SizedBox(width: 6.w),
                Text(
                  'Add Modifiers',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15.sp),
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}

class _ModifierCard extends StatelessWidget {
  final ModifierGroup group;
  final VoidCallback onAddOption;

  const _ModifierCard({
    required this.group,
    required this.onAddOption,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F8FA),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          // Modifier name + Required
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: group.nameController,
                  decoration: InputDecoration(
                    hintText: 'Modifier Name',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Row(
                children: [
                  Obx(() => Checkbox(
                    value: group.isRequired.value,
                    onChanged: (v) => group.isRequired.value = v ?? false,
                  )),
                  Text('Required', style: TextStyle(fontSize: 13.sp)),
                ],
              ),
            ],
          ),

          SizedBox(height: 10.h),

          // Options
          Obx(() => Column(
            children: [
              for (int j = 0; j < group.options.length; j++)
                _OptionRow(option: group.options[j]),
              SizedBox(height: 10.h),

              // Add Options
              GestureDetector(
                onTap: onAddOption,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add, size: 20.sp),
                      SizedBox(width: 6.w),
                      Text(
                        'Add Options',
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15.sp),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }
}

class _OptionRow extends StatelessWidget {
  final ModifierOption option;
  const _OptionRow({required this.option});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(
        children: [
          // Option title
          Expanded(
            flex: 3,
            child: TextField(
              controller: option.nameController,
              decoration: InputDecoration(
                hintText: 'Option Name',
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
              ),
            ),
          ),
          SizedBox(width: 8.w),

          // Price (null = free)
          Expanded(
            flex: 2,
            child: TextField(
              controller: option.priceController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                prefixText: '\$ ',
                hintText: '0.00 (blank = free)',
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/PictureUploadField.dart';
import '../../../../common/customTextButton.dart';
import '../../../../common/custom_textField.dart';
import '../../vendor_add_menu/controllers/vendor_add_menu_controller.dart'
    show ModifierGroup, ModifierOption;
import '../controllers/vendor_edit_menu_controller.dart';

class VendorEditMenuView extends GetView<VendorEditMenuController> {
  final int menuId;
  const VendorEditMenuView({required this.menuId, super.key});

  @override
  Widget build(BuildContext context) {
    // create controller with the required id
    final controller = Get.put(VendorEditMenuController(menuId: menuId));

    return Scaffold(
      backgroundColor: const Color(0xFFF9FBFC),
      body: Obx(() {
        if (controller.error.isNotEmpty) {
          return Center(child: Text(controller.error.value));
        }
        return SingleChildScrollView(
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
                    'Edit Menu Item',
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

              // Image (new upload + show existing if no new)
              Column(
                children: [
                  Obx(() => PictureUploadField(
                    height: 220.h,
                    width: 398.w,
                    file: controller.imageFile.value,
                    onImageSelected: controller.setImageFile,
                  )),
                  SizedBox(height: 8.h),
                  Obx(() {
                    final url = controller.existingImageUrl.value;
                    if (controller.imageFile.value == null && url.isNotEmpty) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(12.r),
                        child: Image.network(url,
                            height: 120.h, width: 398.w, fit: BoxFit.cover),
                      );
                    }
                    return const SizedBox.shrink();
                  }),
                ],
              ),

              SizedBox(height: 20.h),

              GetInTouchTextField(
                headingText: 'Title',
                fieldText: 'Enter deal title',
                iconImagePath: '',
                controller: controller.titleController,
                isRequired: true,
              ),

              SizedBox(height: 20.h),

              GetInTouchTextField(
                headingText: 'Description',
                fieldText: 'Write here...',
                iconImagePath: '',
                controller: controller.descriptionController,
                isRequired: true,
                maxLine: 6,
              ),

              SizedBox(height: 20.h),

              // Category picker
              Obx(() {
                final names = controller.categoryNames;
                final selectedName = controller.selectedCategoryName.value.isNotEmpty
                    ? controller.selectedCategoryName.value
                    : 'Select';

                return CustomCategoryField(
                  fieldName: 'Category',
                  isRequired: true,
                  selectedCategory: names.isNotEmpty ? selectedName : 'Select',
                  categories: names.isNotEmpty ? names : const ['Select'],
                  onCategorySelected: (name) {
                    controller.selectedCategoryName.value = name;
                    controller.selectedCategoryId.value =
                        controller.nameToId[name] ?? 0;
                  },
                );
              }),

              SizedBox(height: 20.h),

              GetInTouchTextField(
                headingText: 'Price',
                fieldText: '0.00',
                iconImagePath: 'assets/images/Menu/USD.png',
                controller: controller.priceController,
                isRequired: true,
              ),

              SizedBox(height: 20.h),

              _ModifiersSectionEdit(controller: controller),
            ],
          ),
        );
      }),

      // Save button
      bottomNavigationBar: Obx(() => Container(
        padding: EdgeInsets.only(left: 16.r, right: 16.r, top: 16.h, bottom: 32.h),
        height: 106.h,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 16)],
        ),
        child: GradientButton(
          text: controller.saving.value ? 'Saving...' : 'Save Changes',
          onPressed: () async {
            if (controller.saving.value) return;        // guard (keeps button enabled type-wise)
            final ok = await controller.patchMenu();
            if (ok) Get.back();
          },
          colors: const [Color(0xFFD62828), Color(0xFFC21414)],
        ),
      )),
    );
  }
}

class _ModifiersSectionEdit extends StatelessWidget {
  final VendorEditMenuController controller;
  const _ModifiersSectionEdit({required this.controller});

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
          _ModifierCardEdit(
            group: controller.modifiers[i],
            onAddOption: () =>
                controller.modifiers[i].options.add(ModifierOption()),
          ),

        SizedBox(height: 10.h),

        GestureDetector(
          onTap: () => controller.modifiers.add(ModifierGroup()),
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
                  style: TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 15.sp),
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}

class _ModifierCardEdit extends StatelessWidget {
  final ModifierGroup group;
  final VoidCallback onAddOption;

  const _ModifierCardEdit({
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
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: group.nameController,
                  decoration: InputDecoration(
                    hintText: 'Modifier Name',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
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

          Obx(() => Column(
            children: [
              for (int j = 0; j < group.options.length; j++)
                _OptionRowEdit(option: group.options[j]),
              SizedBox(height: 10.h),
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
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 15.sp),
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

class _OptionRowEdit extends StatelessWidget {
  final ModifierOption option;
  const _OptionRowEdit({required this.option});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: TextField(
              controller: option.nameController,
              decoration: InputDecoration(
                hintText: 'Option Name',
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            flex: 2,
            child: TextField(
              controller: option.priceController,
              keyboardType:
              const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                prefixText: '\$ ',
                hintText: '0.00 (blank = free)',
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
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

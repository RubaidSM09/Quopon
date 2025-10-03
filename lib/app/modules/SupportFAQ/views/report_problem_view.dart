import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quopon/app/modules/SupportFAQ/views/report_submit_view.dart';
import 'package:quopon/common/PictureUploadField.dart';
import 'package:quopon/common/custom_textField.dart';

import '../../../../common/customTextButton.dart';
import '../controllers/report_a_problem_controller.dart';

class ReportProblemView extends GetView<ReportProblemController> {
  ReportProblemView({super.key});

  final _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Get.put(ReportProblemController());

    return Dialog(
      backgroundColor: const Color(0xFFF9FBFC),
      child: Container(
        height: 587.5.h,
        padding: EdgeInsets.all(16.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox.shrink(),
                  Text('Report a Problem',
                      style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500, color: const Color(0xFF020711))),
                  GestureDetector(onTap: Get.back, child: Icon(Icons.close, size: 24.w)),
                ],
              ),
              const Divider(thickness: 1, color: Color(0xFFEAECED)),
              SizedBox(height: 20.h),

              // Category (keep your CustomCategoryField look)
              Obx(() => CustomCategoryField(
                fieldName: 'Select Category',
                isRequired: false,
                selectedCategory: controller.selectedCategory.value,
                categories: ReportProblemController.categories,
                onCategorySelected: controller.setCategory,
              )),
              SizedBox(height: 20.h),

              // Description (keep your GetInTouchTextField)
              GetInTouchTextField(
                headingText: 'Describe your issue',
                fieldText: 'Write here...',
                iconImagePath: '',
                controller: _messageController,
                isRequired: false,
                maxLine: 4,
              ),

              SizedBox(height: 20.h),

              Row(
                children: [
                  Text('Upload Screenshot',
                      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: const Color(0xFF020711))),
                  const SizedBox.shrink(),
                ],
              ),

              // Keep your PictureUploadField UI; just make it tappable to pick
              GestureDetector(
                onTap: controller.pickProfileImage,
                child: Column(
                  children: [
                    Obx(() {
                      final img = controller.profileImage.value;
                      return Container(
                        padding: (img == null)
                            ? EdgeInsets.only(top: 20.h, bottom: 20.h, left: 70.w, right: 70.w)
                            : EdgeInsets.zero,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          color: const Color(0xFFF4F6F7),
                          border: Border.all(color: const Color(0xFFEAECED)),
                        ),
                        child: img == null
                            ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/SupportFAQ/UploadImage.png'),
                            Text(
                              'Click to upload images here',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF6F7E8D),
                              ),
                            ),
                          ],
                        )
                            : ClipRRect(
                          borderRadius: BorderRadius.circular(12.r),
                          child: Image.file(
                            File(img.path),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }),
                    // tiny status line (no layout change to your field)

                  ],
                ),
              ),

              SizedBox(height: 20.h),

              // Submit button (same GradientButton)
              Obx(() {
                final loading = controller.isSubmitting.value;

                return GradientButton(
                  text: loading ? 'Sending...' : 'Send Request',
                  colors: const [Color(0xFFD62828), Color(0xFFC21414)],
                  boxShadow: const [BoxShadow(color: Color(0xFF9A0000), spreadRadius: 1)],
                  // keep the button enabled; guard inside
                  onPressed: () {
                    if (loading) return;                 // prevent duplicates
                    controller.setDescription(_messageController.text);
                    () async {
                      final ok = await controller.submitReport();
                      if (!ok) return;
                      Get.back();                         // close dialog
                      Get.dialog(ReportSubmitView());     // success popup
                    }();
                  },
                );
              }),

            ],
          ),
        ),
      ),
    );
  }
}

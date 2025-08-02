import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil
import 'package:quopon/app/modules/SupportFAQ/views/report_submit_view.dart';
import 'package:quopon/common/PictureUploadField.dart';
import 'package:quopon/common/custom_textField.dart';

import '../../../../common/customTextButton.dart';

class ReportProblemView extends GetView {
  final _messageController = TextEditingController();

  ReportProblemView({super.key});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Color(0xFFF9FBFC),
      child: Container(
        height: 587.5.h, // ScreenUtil applied
        padding: EdgeInsets.all(16.w), // ScreenUtil applied
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox.shrink(),
                  Text(
                    'Report a Problem',
                    style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500, color: Color(0xFF020711)), // ScreenUtil applied
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(Icons.close, size: 24.w), // ScreenUtil applied
                  ),
                ],
              ),
              Divider(thickness: 1, color: Color(0xFFEAECED)),
              SizedBox(height: 20.h), // ScreenUtil applied
              CustomCategoryField(fieldName: 'Select Category', isRequired: false),
              SizedBox(height: 20.h), // ScreenUtil applied
              GetInTouchTextField(
                headingText: 'Describe your issue',
                fieldText: 'Write here...',
                iconImagePath: '',
                controller: _messageController,
                isRequired: false,
                maxLine: 4,
              ),
              SizedBox(height: 20.h), // ScreenUtil applied
              Row(
                children: [
                  Text(
                    'Upload Screenshot',
                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: Color(0xFF020711)), // ScreenUtil applied
                  ),
                  SizedBox.shrink()
                ],
              ),
              PictureUploadField(),
              SizedBox(height: 20.h), // ScreenUtil applied
              GradientButton(
                text: 'Send Request',
                onPressed: () {
                  Get.back();
                  Get.dialog(ReportSubmitView());
                },
                colors: [const Color(0xFFD62828), const Color(0xFFC21414)],
                boxShadow: [const BoxShadow(color: Color(0xFF9A0000), spreadRadius: 1)],
                child: Text(
                  'Send Request',
                  style: TextStyle(
                    fontSize: 16.sp,  // Use ScreenUtil for font size
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

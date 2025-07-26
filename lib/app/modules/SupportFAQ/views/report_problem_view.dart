import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quopon/app/modules/SupportFAQ/views/report_submit_view.dart';
import 'package:quopon/common/PictureUploadField.dart';
import 'package:quopon/common/custom_textField.dart';
import 'package:quopon/common/red_button.dart';

class ReportProblemView extends GetView {
  final _messageController = TextEditingController();

  ReportProblemView({super.key});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Color(0xFFF9FBFC),
      child: Container(
        height: 565,
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox.shrink(),
                  Text(
                    'Report a Problem',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Color(0xFF020711)),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(Icons.close),
                  ),
                ],
              ),
              Divider(thickness: 1, color: Color(0xFFEAECED),),
              SizedBox(height: 20,),
              CustomCategoryField(fieldName: 'Select Category', isRequired: false,),
              SizedBox(height: 20,),
              GetInTouchTextField(
                headingText: 'Describe your issue',
                fieldText: 'Write here...', iconImagePath: '',
                controller: _messageController,
                isRequired: false,
                maxLine: 4,
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Text(
                    'Upload Screenshot',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xFF020711)),
                  ),
                  SizedBox.shrink()
                ],
              ),
              PictureUploadField(),
              SizedBox(height: 20,),
              RedButton(buttonText: 'Send Request', onPressed: () {
                Get.back();
                Get.dialog(ReportSubmitView());
              })
            ],
          ),
        ),
      )
    );
  }
}

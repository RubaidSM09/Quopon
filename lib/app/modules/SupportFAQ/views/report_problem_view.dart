import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quopon/app/modules/SupportFAQ/views/report_submit_view.dart';
import 'package:quopon/common/custom_textField.dart';
import 'package:quopon/common/red_button.dart';

class ReportProblemView extends GetView {
  final _messageController = TextEditingController();

  ReportProblemView({super.key});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Color(0xFFF9FBFC),
      child: SingleChildScrollView(
        child: Container(
          height: 542,
          padding: EdgeInsets.all(16),
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
              CustomCategoryField(fieldName: 'Select Category'),
              SizedBox(height: 20,),
              GetInTouchTextField(
                headingText: 'Describe your issue',
                fieldText: 'Write here...', iconImagePath: '',
                controller: _messageController,
                isRequired: false,
                maxLine: 6,
              ),
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

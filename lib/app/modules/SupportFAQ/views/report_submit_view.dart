import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quopon/common/red_button.dart';

class ReportSubmitView extends GetView {
  const ReportSubmitView({super.key});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Color(0xFFFFFFFF),
      child: SingleChildScrollView(
        child: Container(
          height: 296,
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/images/SupportFAQ/Message.gif',
                height: 80,
                width: 80,
              ),
              Column(
                children: [
                  Text(
                    'Request Submitted!',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Color(0xFF020711)),
                  ),
                  Text(
                    'We’ve received your message. You’ll get a notification once it’s reviewed by our support team.',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              RedButton(buttonText: 'Done', onPressed: () {
                Get.back();
              })
            ],
          ),
        ),
      )
    );
  }
}

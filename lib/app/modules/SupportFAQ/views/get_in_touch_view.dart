import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quopon/common/red_button.dart';

import '../../../../common/custom_textField.dart';

class GetInTouchView extends GetView {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  GetInTouchView({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topRight: Radius.circular(16), topLeft: Radius.circular(16))
      ),
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox.shrink(),
                Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Color(0xFFDC143C),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: EdgeInsets.all(12),
                    child: Image.asset(
                      'assets/images/login/Logo Icon.png',
                      fit: BoxFit.cover,
                    )
                ),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(Icons.close),
                )
              ],
            ),
            SizedBox(height: 15,),
            Text(
              'Get in Touch',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: Color(0xFF020711)),
            ),
            SizedBox(height: 15,),
            Text(
              'Need help? Send us a message and our support team will get back to you shortly.',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30,),

            GetInTouchTextField(
                headingText: 'Full Name',
                fieldText: 'Enter full name',
                iconImagePath: '',
                controller: _fullNameController,
                isRequired: false
            ),
            SizedBox(height: 15,),
            GetInTouchTextField(
                headingText: 'Email Address',
                fieldText: 'Enter email address',
                iconImagePath: '',
                controller: _emailController,
                isRequired: false
            ),
            SizedBox(height: 15,),
            CustomCategoryField(fieldName: 'Category',),
            SizedBox(height: 15,),
            GetInTouchTextField(
                headingText: 'Message',
                fieldText: 'Write here...',
                iconImagePath: '',
                controller: _messageController,
                isRequired: false,
              maxLine: 6,
            ),
            SizedBox(height: 25,),
            RedButton(buttonText: 'Send Message', onPressed: () {
              Get.back();
            })
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../common/red_button.dart';

class ReviewSubmitView extends GetView {
  const ReviewSubmitView({super.key});
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
                  'assets/images/Review/Thanks.gif',
                  height: 80,
                  width: 80,
                ),
                Column(
                  children: [
                    Text(
                      'Thanks for your review!',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Color(0xFF020711)),
                    ),
                    Text(
                      'It helps other users and supports your favorite vendors.',
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

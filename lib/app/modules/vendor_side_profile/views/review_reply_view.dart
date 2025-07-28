import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quopon/app/modules/vendor_side_profile/views/reviews_view.dart';
import 'package:quopon/common/customTextButton.dart';

import '../../../../common/custom_textField.dart';

class ReviewReplyView extends GetView {
  final _replyController = TextEditingController();

  ReviewReplyView({super.key});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox.shrink(),
                  Text(
                    'Reply to Review',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Color(0xFF020711)),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(Icons.close),
                  )
                ],
              ),
              SizedBox(height: 10,),
              Divider(color: Color(0xFFEAECED),),
              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundImage: AssetImage('assets/images/deals/details/Starbucks_Logo.png'),
                  ),
                  SizedBox(width: 8,),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF4F6F7), // Light gray background
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const TextField(
                        maxLines: 6,
                        decoration: InputDecoration(
                          hintText: "Write here...",
                          hintStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20,),

              GradientButton(
                text: 'Submit',
                onPressed: () {
                  Get.to(ReviewsView());
                },
                colors: [Color(0xFFD62828), Color(0xFFC21414)],
              )
            ],
          ),
        ),
      ),
    );
  }
}

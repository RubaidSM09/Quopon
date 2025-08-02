import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row with Close Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox.shrink(),
                  Text(
                    'Reply to Review',
                    style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500, color: Color(0xFF020711)),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back(); // Close the dialog
                    },
                    child: Icon(Icons.close),
                  ),
                ],
              ),

              SizedBox(height: 10.h),
              Divider(color: Color(0xFFEAECED)),

              // User Info and Text Field for Reply
              SizedBox(height: 5.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 18.r,
                    backgroundImage: AssetImage('assets/images/deals/details/Starbucks_Logo.png'),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF4F6F7), // Light gray background
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: TextField(
                        controller: _replyController,
                        maxLines: 6,
                        decoration: InputDecoration(
                          hintText: "Write here...",
                          hintStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20.h),

              // Submit Button
              GradientButton(
                text: 'Submit',
                onPressed: () {
                  if (_replyController.text.isNotEmpty) {
                    // Handle the submission of the reply
                    Get.to(ReviewsView()); // Navigate back to Reviews View
                  } else {
                    Get.snackbar('Error', 'Please write a reply before submitting.',
                        snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
                  }
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

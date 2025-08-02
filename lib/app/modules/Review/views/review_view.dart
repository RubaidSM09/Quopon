import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil
import 'package:quopon/app/modules/Review/views/review_submit_view.dart';
import 'package:quopon/common/PictureUploadField.dart';
import 'package:quopon/common/custom_textField.dart';

import '../../../../common/customTextButton.dart';
import '../../Review/controllers/review_controller.dart';

class ReviewView extends GetView<ReviewController> {
  final _messageController = TextEditingController();

  ReviewView({super.key});
  @override
  Widget build(BuildContext context) {
    RxInt rating = 0.obs;

    return Dialog(
      backgroundColor: Colors.white,
      child: Container(
        height: 654.h, // Use ScreenUtil for height
        padding: EdgeInsets.all(16.w), // Use ScreenUtil for padding
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox.shrink(),
                  Text(
                    'Write Review',
                    style: TextStyle(
                      fontSize: 18.sp, // Use ScreenUtil for font size
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF020711),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(Icons.close),
                  ),
                ],
              ),

              Divider(thickness: 1, color: Color(0xFFEAECED)),

              SizedBox(height: 20.h),

              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r), // Use ScreenUtil for border radius
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(26),
                        blurRadius: 20.r, // Use ScreenUtil for blur radius
                      )
                    ]
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 56.h,
                      width: 56.w,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.r), // Use ScreenUtil for border radius
                        child: Image.asset(
                          'assets/images/Review/Iced Matcha Latte.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 190.w,
                          child: Text(
                            'Iced Matcha Latte',
                            style: TextStyle(
                              fontSize: 16.sp, // Use ScreenUtil for font size
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF020711),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 190.w,
                          child: Text(
                            '50% OFF on Any Grande Beverage',
                            style: TextStyle(
                              fontSize: 12.sp, // Use ScreenUtil for font size
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF6F7E8D),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),

              SizedBox(height: 30.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Overall Rating',
                    style: TextStyle(
                      fontSize: 16.sp, // Use ScreenUtil for font size
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF020711),
                    ),
                  ),
                  SizedBox.shrink(),
                ],
              ),
              Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: List.generate(5, (index) {
                    return GestureDetector(
                      onTap: () {
                        rating.value = index + 1;
                      },
                      child: Icon(
                        rating.value >= index + 1
                            ? Icons.star_rounded
                            : Icons.star_border_rounded,
                        size: 31.107.sp, // Use ScreenUtil for icon size
                        color: Color(0xFFFFA81C),
                      ),
                    );
                  }),
                );
              }),

              SizedBox(height: 20.h),

              GetInTouchTextField(
                headingText: 'How was your experience?',
                fieldText: 'Write here...',
                iconImagePath: '',
                controller: _messageController,
                isRequired: false,
                maxLine: 4,
              ),

              SizedBox(height: 10.h),

              PictureUploadField(),

              SizedBox(height: 20.h),

              GradientButton(
                text: 'Submit',
                onPressed: () {
                  Get.back();
                  Get.dialog(ReviewSubmitView());
                },
                colors: [const Color(0xFFD62828), const Color(0xFFC21414)],
                boxShadow: [const BoxShadow(color: Color(0xFF9A0000), spreadRadius: 1)],
                child: Text(
                  'Submit',
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

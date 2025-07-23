import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:get/get.dart';
import 'package:quopon/app/modules/Review/views/review_submit_view.dart';
import 'package:quopon/common/custom_textField.dart';
import 'package:quopon/common/red_button.dart';

import '../controllers/review_controller.dart';

class ReviewView extends GetView<ReviewController> {
  final _messageController = TextEditingController();

  ReviewView({super.key});
  @override
  Widget build(BuildContext context) {
    RxInt rating = 0.obs;

    return Dialog(
      backgroundColor: Colors.white,
      child: SingleChildScrollView(
        child: Container(
          height: 610,
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox.shrink(),
                  Text(
                    'Write Review',
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

              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(26),
                      blurRadius: 20
                    )
                  ]
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 56,
                      width: 56,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          'assets/images/Review/Iced Matcha Latte.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 190,
                          child: Text(
                            'Iced Matcha Latte',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xFF020711)),
                          ),
                        ),
                        SizedBox(
                          width: 190,
                          child: Text(
                            '50% OFF on Any Grande Beverage',
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),

              SizedBox(height: 30,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Overall Rating',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xFF020711)),
                  ),
                  SizedBox.shrink(),
                ],
              ),
              Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        rating.value = 1;
                      },
                      child: rating.value >= 1 ?
                      Icon(
                        Icons.star_rounded,
                        size: 31.107,
                        color: Color(0xFFFFA81C),
                      ) :
                      Icon(
                        Icons.star_border_rounded,
                        size: 31.107,
                        color: Color(0xFFFFA81C),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        rating.value = 2;
                      },
                      child: rating.value >= 2 ?
                      Icon(
                        Icons.star_rounded,
                        size: 31.107,
                        color: Color(0xFFFFA81C),
                      ) :
                      Icon(
                        Icons.star_border_rounded,
                        size: 31.107,
                        color: Color(0xFFFFA81C),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        rating.value = 3;
                      },
                      child: rating.value >= 3 ?
                      Icon(
                        Icons.star_rounded,
                        size: 31.107,
                        color: Color(0xFFFFA81C),
                      ) :
                      Icon(
                        Icons.star_border_rounded,
                        size: 31.107,
                        color: Color(0xFFFFA81C),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        rating.value = 4;
                      },
                      child: rating.value >= 4 ?
                      Icon(
                        Icons.star_rounded,
                        size: 31.107,
                        color: Color(0xFFFFA81C),
                      ) :
                      Icon(
                        Icons.star_border_rounded,
                        size: 31.107,
                        color: Color(0xFFFFA81C),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        rating.value = 5;
                      },
                      child: rating.value >= 5 ?
                      Icon(
                        Icons.star_rounded,
                        size: 31.107,
                        color: Color(0xFFFFA81C),
                      ) :
                      Icon(
                        Icons.star_border_rounded,
                        size: 31.107,
                        color: Color(0xFFFFA81C),
                      ),
                    ),
                  ],
                );
              }),

              SizedBox(height: 20,),

              GetInTouchTextField(
                headingText: 'How was your experience?',
                fieldText: 'Write here...',
                iconImagePath: '',
                controller: _messageController,
                isRequired: false,
                maxLine: 6,
              ),

              SizedBox(height: 20,),

              RedButton(buttonText: 'Submit', onPressed: () {
                Get.back();
                Get.dialog(ReviewSubmitView());
              })
            ],
          ),
        ),
      )
    );
  }
}

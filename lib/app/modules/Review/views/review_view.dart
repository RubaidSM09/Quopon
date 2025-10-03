// lib/app/modules/Review/views/review_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quopon/app/modules/Review/views/review_submit_view.dart';
import 'package:quopon/common/PictureUploadField.dart';
import 'package:quopon/common/custom_textField.dart';
import '../../../../common/customTextButton.dart';
import '../../Review/controllers/review_controller.dart';

class ReviewView extends GetView<ReviewController> {
  final _messageController = TextEditingController();

  /// Pass the menu item id you’re reviewing
  final int menuItemId;

  ReviewView({super.key, required this.menuItemId});

  @override
  Widget build(BuildContext context) {
    Get.put(ReviewController());

    return Dialog(
      backgroundColor: Colors.white,
      child: Container(
        height: 654.h,
        padding: EdgeInsets.all(16.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox.shrink(),
                  Text(
                    'Write Review',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF020711),
                    ),
                  ),
                  GestureDetector(onTap: Get.back, child: const Icon(Icons.close)),
                ],
              ),
              const Divider(thickness: 1, color: Color(0xFFEAECED)),
              SizedBox(height: 20.h),

              // item card (unchanged visuals)
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [BoxShadow(color: Colors.black.withAlpha(26), blurRadius: 20.r)],
                ),
                child: Row(
                  children: [
                    SizedBox(
                      height: 56.h,
                      width: 56.w,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: Image.asset('assets/images/Review/Iced Matcha Latte.jpg', fit: BoxFit.cover),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 190.w,
                          child: Text('Iced Matcha Latte',
                              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: const Color(0xFF020711))),
                        ),
                        SizedBox(
                          width: 190.w,
                          child: Text('50% OFF on Any Grande Beverage',
                              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400, color: const Color(0xFF6F7E8D))),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 30.h),

              // rating label
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Overall Rating',
                      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400, color: const Color(0xFF020711))),
                  const SizedBox.shrink(),
                ],
              ),

              // stars bound to controller.rating
              Obx(() {
                final r = controller.rating.value;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: List.generate(5, (i) {
                    final idx = i + 1;
                    return GestureDetector(
                      onTap: () => controller.rating.value = idx,
                      child: Icon(
                        r >= idx ? Icons.star_rounded : Icons.star_border_rounded,
                        size: 31.107.sp,
                        color: const Color(0xFFFFA81C),
                      ),
                    );
                  }),
                );
              }),

              SizedBox(height: 20.h),

              // message
              GetInTouchTextField(
                headingText: 'How was your experience?',
                fieldText: 'Write here...',
                iconImagePath: '',
                controller: _messageController,
                isRequired: false,
                maxLine: 4,
              ),

              SizedBox(height: 10.h),

              // (kept as-is, not wired to API since no endpoint provided for images in review)
              const PictureUploadField(),

              SizedBox(height: 20.h),

              // submit
              Obx(() {
                final loading = controller.isSubmitting.value;

                return GradientButton(
                  text: 'Submit',
                  onPressed: () async {
                    if (loading) return; // prevent double taps

                    final ok = await controller.submitReview(
                      menuItemId: menuItemId,
                      rating: controller.rating.value,
                      comment: _messageController.text,
                    );
                    if (!ok) return;

                    Get.back();                    // close dialog
                    Get.dialog(ReviewSubmitView()); // success popup
                  },
                  colors: const [Color(0xFFD62828), Color(0xFFC21414)],
                  boxShadow: const [BoxShadow(color: Color(0xFF9A0000), spreadRadius: 1)],
                  child: Text(
                    loading ? 'Submitting...' : 'Submit',
                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: Colors.white),
                  ),
                );
              })
              ,
            ],
          ),
        ),
      ),
    );
  }
}

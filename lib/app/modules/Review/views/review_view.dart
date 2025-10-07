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

  /// NOW: we receive ONLY the menu item NAME
  final String menuName;

  ReviewView({
    super.key,
    required this.menuName,
  });

  @override
  Widget build(BuildContext context) {
    Get.put(ReviewController());

    // Load preview (title + image) using name from /vendors/deals/
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.loadMenuByName(menuName.trim());
    });

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

              // Item card (loaded by name)
              Obx(() {
                final loading = controller.isLoadingItem.value;
                final title = controller.itemTitle.value.isNotEmpty
                    ? controller.itemTitle.value
                    : menuName;
                final subtitle = controller.itemSubtitle.value;
                final img = controller.itemImageUrl.value;

                return Container(
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
                          child: img.isNotEmpty
                              ? Image.network(
                            img,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Image.asset(
                              'assets/images/Review/Iced Matcha Latte.jpg',
                              fit: BoxFit.cover,
                            ),
                          )
                              : Image.asset(
                            'assets/images/Review/Iced Matcha Latte.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 190.w,
                              child: Text(
                                loading ? 'Loading…' : title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF020711),
                                ),
                              ),
                            ),
                            if (subtitle.isNotEmpty) SizedBox(height: 4.h),
                            if (subtitle.isNotEmpty)
                              SizedBox(
                                width: 190.w,
                                child: Text(
                                  subtitle,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF6F7E8D),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),

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
              const PictureUploadField(),
              SizedBox(height: 20.h),

              // submit
              Obx(() {
                final loading = controller.isSubmitting.value;

                return GradientButton(
                  text: 'Submit',
                  onPressed: () async {
                    if (loading) return; // prevent double taps

                    final ok = await controller.submitReviewByName(
                      menuName: menuName,
                      rating: controller.rating.value,
                      comment: _messageController.text,
                    );
                    if (!ok) return;

                    Get.back();                    // close dialog
                    Get.dialog(const ReviewSubmitView()); // success popup
                  },
                  colors: const [Color(0xFFD62828), Color(0xFFC21414)],
                  boxShadow: const [BoxShadow(color: Color(0xFF9A0000), spreadRadius: 1)],
                  child: Text(
                    loading ? 'Submitting...' : 'Submit',
                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: Colors.white),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/reviews_controller.dart';

class ReviewReplyView extends GetView<VendorReviewsController> {
  final int reviewId;
  final _replyController = TextEditingController();

  ReviewReplyView({super.key, required this.reviewId});

  @override
  Widget build(BuildContext context) {
    final logo = controller.myVendorLogoUrl;

    ImageProvider avatarProvider;
    if (logo.isNotEmpty) {
      avatarProvider = NetworkImage(logo);
    } else {
      avatarProvider = const AssetImage('assets/images/Profile/Avatar.png');
    }

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
                  const SizedBox.shrink(),
                  Text(
                    'Reply to Review',
                    style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500, color: const Color(0xFF020711)),
                  ),
                  GestureDetector(onTap: Get.back, child: const Icon(Icons.close)),
                ],
              ),
              SizedBox(height: 10.h),
              const Divider(color: Color(0xFFEAECED)),

              SizedBox(height: 5.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(radius: 18.r, backgroundImage: avatarProvider),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF4F6F7),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: TextField(
                        controller: _replyController,
                        maxLines: 6,
                        decoration: InputDecoration(
                          hintText: "Write here...",
                          hintStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: const Color(0xFF6F7E8D)),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20.h),

              // Submit
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD62828),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                  ),
                  onPressed: () async {
                    final text = _replyController.text.trim();
                    if (text.isEmpty) {
                      Get.snackbar('Error', 'Please write a reply before submitting.',
                          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
                      return;
                    }
                    final ok = await controller.postReply(reviewId: reviewId, comment: text);
                    if (ok) Get.back(); // close dialog on success
                  },
                  child: Text('Submit', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

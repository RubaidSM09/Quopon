import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quopon/app/modules/vendor_side_profile/views/review_reply_view.dart';

import '../controllers/my_reviews_controller.dart';

class MyReviewsCardView extends GetView<MyReviewsController> {
  final String image; // network URL or asset (can be empty)
  final String title;
  final String offer;
  final Review review;
  final VendorFeedback feedback;
  final int rating;
  final bool isVendor;
  final bool isPending;

  /// Needed for vendor reply flow
  final int? reviewId;

  const MyReviewsCardView({
    required this.image,
    required this.title,
    required this.offer,
    this.review = const Review(review: '', reviewer: '', time: ''),
    this.feedback = const VendorFeedback(image: '', title: '', feedback: '', time: ''),
    required this.rating,
    this.isVendor = false,
    this.isPending = false,
    this.reviewId,
    super.key,
  });

  bool get _isNetwork => image.trim().startsWith('http');
  bool get _hasImage => image.trim().isNotEmpty;
  bool get _replyHasNetworkAvatar => feedback.image.startsWith('http');

  @override
  Widget build(BuildContext context) {
    // If no image provided, fall back to a safe local placeholder
    final String imgSrc = _hasImage ? image.trim() : 'assets/images/Review/Iced Matcha Latte.jpg';

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 16)],
      ),
      child: Column(
        children: [
          // Product header (now ALWAYS visible so vendor sees menu name & image)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 56.h,
                    width: 56.w,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: imgSrc.startsWith('http')
                          ? Image.network(imgSrc, fit: BoxFit.cover)
                          : Image.asset(imgSrc, fit: BoxFit.cover),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 190.w,
                        child: Text(
                          (title.trim().isEmpty ? 'Menu item' : title.trim()),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF020711),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 190.w,
                        child: Text(
                          offer,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF6F7E8D),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              // Reorder button only for customers
              if (!isVendor)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD62828),
                    borderRadius: BorderRadius.circular(100.r),
                  ),
                  child: Text(
                    'Reorder',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),

          SizedBox(height: 5.h),
          Divider(thickness: 1.h, color: const Color(0xFFEAECED)),
          SizedBox(height: 5.h),

          // Rating section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(5, (index) {
                  return Icon(
                    rating > index ? Icons.star_rounded : Icons.star_border_rounded,
                    size: 31.107.sp,
                    color: const Color(0xFFFFA81C),
                  );
                }),
              ),
              !isVendor
                  ? Row(
                children: [
                  Image.asset('assets/images/MyReviews/Edit.png'),
                  SizedBox(width: 5.w),
                  Text(
                    'Edit Review',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFFD62828),
                    ),
                  )
                ],
              )
                  : Text(
                '${review.time} ago',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF6F7E8D),
                ),
              ),
            ],
          ),

          review.review.isNotEmpty ? SizedBox(height: 10.h) : const SizedBox.shrink(),

          review.review.isNotEmpty
              ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  review.review,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF6F7E8D),
                  ),
                ),
              ),
              const SizedBox.shrink()
            ],
          )
              : const SizedBox.shrink(),

          review.review.isNotEmpty ? SizedBox(height: 10.h) : const SizedBox.shrink(),

          review.review.isNotEmpty
              ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'by ${review.reviewer}',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF020711),
                ),
              ),
              !isVendor
                  ? Text(
                '${review.time} ago',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF6F7E8D),
                ),
              )
                  : isPending
                  ? GestureDetector(
                onTap: () {
                  if (reviewId == null) {
                    Get.snackbar('Missing ID', 'Cannot reply: reviewId is null');
                    return;
                  }
                  Get.dialog(ReviewReplyView(reviewId: reviewId!));
                },
                child: Row(
                  children: [
                    Image.asset('assets/images/Profile/Vendors/Reply.png'),
                    SizedBox(width: 10.w),
                    Text(
                      'Reply',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                        color: const Color(0xFFD62828),
                      ),
                    )
                  ],
                ),
              )
                  : const SizedBox.shrink(),
            ],
          )
              : const SizedBox.shrink(),

          // Vendor reply (latest)
          feedback.feedback.isNotEmpty ? SizedBox(height: 5.h) : const SizedBox.shrink(),
          feedback.feedback.isNotEmpty ? Divider(thickness: 1.h, color: const Color(0xFFEAECED)) : const SizedBox.shrink(),
          feedback.feedback.isNotEmpty ? SizedBox(height: 5.h) : const SizedBox.shrink(),

          feedback.feedback.isNotEmpty
              ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 18.sp,
                backgroundImage: _replyHasNetworkAvatar && feedback.image.isNotEmpty
                    ? NetworkImage(feedback.image)
                    : const AssetImage('assets/images/Profile/Avatar.png') as ImageProvider,
              ),
              SizedBox(width: 10.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 309.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          feedback.title,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF020711),
                          ),
                        ),
                        Text(
                          '${feedback.time} ago',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF6F7E8D),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 309.w,
                    child: Text(
                      feedback.feedback,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF6F7E8D),
                      ),
                    ),
                  )
                ],
              )
            ],
          )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}

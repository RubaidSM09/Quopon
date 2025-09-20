import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil
import 'package:quopon/app/modules/vendor_side_profile/views/review_reply_view.dart';

import '../controllers/my_reviews_controller.dart';

class MyReviewsCardView extends GetView<MyReviewsController> {
  final String image;
  final String title;
  final String offer;
  final Review review;
  final VendorFeedback feedback;
  final int rating;
  final bool isVendor;
  final bool isPending;

  const MyReviewsCardView({
    required this.image,
    required this.title,
    required this.offer,
    this.review = const Review(review: '', reviewer: '', time: ''),
    this.feedback = const VendorFeedback(image: '', title: '', feedback: '', time: ''),
    required this.rating,
    this.isVendor = false,
    this.isPending = false,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w), // Use ScreenUtil for padding
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r), // Use ScreenUtil for border radius
          boxShadow: [BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 16)]
      ),
      child: Column(
        children: [
          // Vendor section - conditionally display
          !isVendor ? Row(
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
                      child: Image.asset(
                        image,
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
                          title,
                          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: Color(0xFF020711)),
                        ),
                      ),
                      SizedBox(
                        width: 190.w,
                        child: Text(
                          offer,
                          style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                    color: Color(0xFFD62828),
                    borderRadius: BorderRadius.circular(100.r)
                ),
                child: Text(
                  'Reorder',
                  style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500, color: Colors.white),
                ),
              )
            ],
          ) : SizedBox.shrink(),

          !isVendor ? SizedBox(height: 5.h) : SizedBox.shrink(),
          !isVendor ? Divider(thickness: 1.h, color: Color(0xFFEAECED)) : SizedBox.shrink(),
          !isVendor ? SizedBox(height: 5.h) : SizedBox.shrink(),

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
                    color: Color(0xFFFFA81C),
                  );
                }),
              ),

              !isVendor ? Row(
                children: [
                  Image.asset('assets/images/MyReviews/Edit.png'),
                  SizedBox(width: 5.w),
                  Text(
                    'Edit Review',
                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: Color(0xFFD62828)),
                  )
                ],
              ) :
              Text(
                '${review.time} ago',
                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)),
              ),
            ],
          ),

          review.review != '' ? SizedBox(height: 10.h) : SizedBox.shrink(),

          review.review != '' ?
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                review.review,
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)),
              ),

              SizedBox.shrink()
            ],
          ) : SizedBox.shrink(),

          review.review != '' ? SizedBox(height: 10.h) : SizedBox.shrink(),

          review.review != '' ?
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'by ${review.reviewer}',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Color(0xFF020711)),
              ),
              !isVendor ? Text(
                '${review.time} ago',
                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)),
              ) :
              isPending ? GestureDetector(
                onTap: () {
                  Get.dialog(ReviewReplyView());
                },
                child: Row(
                  children: [
                    Image.asset('assets/images/Profile/Vendors/Reply.png'),
                    SizedBox(width: 10.w),
                    Text(
                      'Reply',
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp, color: Color(0xFFD62828)),
                    )
                  ],
                ),
              ) : SizedBox.shrink(),
            ],
          ) : SizedBox.shrink(),

          feedback.feedback != '' ? SizedBox(height: 5.h) : SizedBox.shrink(),
          feedback.feedback != '' ? Divider(thickness: 1.h, color: Color(0xFFEAECED)) : SizedBox.shrink(),
          feedback.feedback != '' ? SizedBox(height: 5.h) : SizedBox.shrink(),

          feedback.feedback != '' ?
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 18.sp,
                backgroundImage: AssetImage(feedback.image),
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
                          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Color(0xFF020711)),
                        ),
                        Text(
                          '${feedback.time} ago',
                          style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 309.w,
                    child: Text(
                      feedback.feedback,
                      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)),
                    ),
                  )
                ],
              )
            ],
          ) : SizedBox.shrink(),
        ],
      ),
    );
  }
}

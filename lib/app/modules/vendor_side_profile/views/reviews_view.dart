import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:quopon/common/Filter.dart';
import 'package:quopon/app/modules/MyReviews/views/my_reviews_card_view.dart';
import '../../MyReviews/controllers/my_reviews_controller.dart';
import '../controllers/reviews_controller.dart';
import 'review_reply_view.dart';

class ReviewsView extends GetView<VendorReviewsController> {
  const ReviewsView({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(VendorReviewsController());
    final isPending = false.obs; // toggle between tabs

    return Scaffold(
      backgroundColor: const Color(0xFFF9FBFC),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 32.h, 16.w, 16.h),
          child: Column(
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(onTap: Get.back, child: const Icon(Icons.arrow_back)),
                  Text('Reviews',
                      style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500, color: const Color(0xFF020711))),
                  const SizedBox(),
                ],
              ),
              SizedBox(height: 20.h),

              // Tab Switcher: Approved / Pending
              Obx(() {
                final approvedCount = c.approvedReviews.length;
                final pendingCount = c.pendingReviews.length;

                return Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: const Color(0xFFF1F3F4),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (isPending.value) isPending.value = false;
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                color: isPending.value ? const Color(0xFFF1F3F4) : const Color(0xFFD62828),
                              ),
                              child: SizedBox(
                                width: 161.w,
                                child: Center(
                                  child: Text(
                                    'Approved Replies ($approvedCount)',
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                        color: isPending.value ? const Color(0xFF6F7E8D) : const Color(0xFFFFFFFF)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (!isPending.value) isPending.value = true;
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                color: !isPending.value ? const Color(0xFFF1F3F4) : const Color(0xFFD62828),
                              ),
                              child: SizedBox(
                                width: 161.w,
                                child: Center(
                                  child: Text(
                                    'Pending Reviews ($pendingCount)',
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                        color: !isPending.value ? const Color(0xFF6F7E8D) : const Color(0xFFFFFFFF)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20.h),

                    // Filters (visual only)
                    const SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          FilterCard(filterName: 'Latest', iconPath: '', active: false),
                          SizedBox(width: 10),
                          FilterCard(filterName: 'All Ratings', iconPath: '', active: false),
                          SizedBox(width: 10),
                          FilterCard(filterName: 'Highest Rated', iconPath: '', active: false),
                          SizedBox(width: 10),
                          FilterCard(filterName: 'Reply Status', iconPath: '', active: false),
                        ],
                      ),
                    ),

                    SizedBox(height: 20.h),

                    // Body
                    Obx(() {
                      if (c.isLoading.value) {
                        return const Padding(
                          padding: EdgeInsets.all(24.0),
                          child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
                        );
                      }

                      final data = isPending.value ? c.pendingReviews : c.approvedReviews;

                      if (data.isEmpty) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 40.h),
                          child: Text(
                            isPending.value ? 'No pending reviews.' : 'No approved replies yet.',
                            style: TextStyle(fontSize: 14.sp, color: const Color(0xFF6F7E8D)),
                          ),
                        );
                      }

                      return Column(
                        children: [
                          for (final r in data) ...[
                            MyReviewsCardView(
                              image: (c.cardImageForMenu(r.menuItemId)).isNotEmpty
                                  ? c.cardImageForMenu(r.menuItemId)
                                  : 'assets/images/Review/Iced Matcha Latte.jpg',
                              title: c.menuTitleFor(r.menuItemId, r.menuTitle),
                              offer: '',
                              review: Review(
                                review: r.comment.isNotEmpty ? '“${r.comment}”' : '',
                                reviewer: r.userEmail.isEmpty ? 'Customer' : r.userEmail,
                                time: c.timeAgo(r.createdAt),
                              ),
                              feedback: (() {
                                final rep = c.latestReplyFor(r.id);
                                if (rep == null) {
                                  return const VendorFeedback(image: '', title: '', feedback: '', time: '');
                                }
                                final tuple = c.vendorNameAndLogoForEmail(rep.user);
                                return VendorFeedback(
                                  image: tuple.$2,
                                  title: tuple.$1,
                                  feedback: rep.comment,
                                  time: c.timeAgo(rep.createdAt),
                                );
                              })(),
                              rating: r.rating,
                              isVendor: true,
                              isPending: (c.repliesByReviewId[r.id]?.isEmpty ?? true),
                              reviewId: r.id, // <-- pass id so dialog can post reply
                            ),
                            SizedBox(height: 10.h),
                            if (c.repliesByReviewId[r.id]?.isEmpty ?? true)
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton.icon(
                                  onPressed: () => Get.dialog(ReviewReplyView(reviewId: r.id)),
                                  icon: const Icon(Icons.reply),
                                  label: const Text('Reply'),
                                ),
                              ),
                          ],
                        ],
                      );
                    }),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

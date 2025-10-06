import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:quopon/app/modules/MyReviews/views/my_reviews_card_view.dart';
import 'package:quopon/app/modules/home/controllers/home_controller.dart';
import 'package:quopon/common/Filter.dart';

import '../controllers/my_reviews_controller.dart';

class MyReviewsView extends GetView<MyReviewsController> {
  const MyReviewsView({super.key});

  @override
  Widget build(BuildContext context) {
    final myReviewsController = Get.put(MyReviewsController());
    Get.put(HomeController());

    return Scaffold(
      backgroundColor: const Color(0xFFF9FBFC),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 32.h, 16.w, 16.h),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(onTap: Get.back, child: const Icon(Icons.arrow_back)),
                  Text('My Reviews',
                      style: TextStyle(
                          fontSize: 20.sp, fontWeight: FontWeight.w500, color: const Color(0xFF020711))),
                  const SizedBox(),
                ],
              ),

              SizedBox(height: 20.h),

              // Search bar (visual only)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Expanded(
                      child: TextField(
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: 'Search review',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Icon(Icons.search, color: Colors.grey[500]),
                  ],
                ),
              ),

              SizedBox(height: 20.h),

              // Filters (kept)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const FilterCard(filterName: 'Latest', iconPath: '', active: false),
                    SizedBox(width: 10.w),
                    const FilterCard(filterName: 'All Ratings', iconPath: '', active: false),
                    SizedBox(width: 10.w),
                    const FilterCard(filterName: 'Highest Rated', iconPath: '', active: false),
                    SizedBox(width: 10.w),
                    const FilterCard(filterName: 'Reply Status', iconPath: '', active: false),
                  ],
                ),
              ),

              SizedBox(height: 20.h),

              Obx(() {
                if (myReviewsController.isLoading.value) {
                  return const Padding(
                    padding: EdgeInsets.all(24.0),
                    child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
                  );
                }

                if (myReviewsController.reviews.isEmpty) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 40.h),
                    child: Text(
                      'No reviews yet.',
                      style: TextStyle(fontSize: 14.sp, color: const Color(0xFF6F7E8D)),
                    ),
                  );
                }

                final widgets = <Widget>[];
                for (final r in myReviewsController.reviews) {
                  final title = myReviewsController.dealTitleFor(r.menuItem);
                  final img = myReviewsController.dealImageFor(r.menuItem);

                  final rep = myReviewsController.latestReplyFor(r.id);
                  final hasReply = rep != null;

                  String replyTitle = '';
                  String replyLogo = '';
                  String replyText = '';
                  String replyAgo = '';

                  if (hasReply) {
                    final tuple = myReviewsController.vendorNameAndLogoForEmail(rep!.user);
                    replyTitle = tuple.$1;
                    replyLogo = tuple.$2; // may be empty
                    replyText = rep.comment;
                    replyAgo = myReviewsController.timeAgo(rep.createdAt);
                  }

                  widgets.add(
                    MyReviewsCardView(
                      image: img.isNotEmpty
                          ? img
                          : 'assets/images/Review/Iced Matcha Latte.jpg',
                      title: title, // deal title or "Menu item #id"
                      offer: '',
                      review: Review(
                        review: r.comment.isNotEmpty ? '“${r.comment}”' : '',
                        reviewer: 'You',
                        time: myReviewsController.timeAgo(r.createdAt),
                      ),
                      feedback: hasReply
                          ? VendorFeedback(
                        image: replyLogo,              // network URL OK
                        title: replyTitle,             // vendor business name
                        feedback: replyText,
                        time: replyAgo,
                      )
                          : const VendorFeedback(
                        image: '',
                        title: '',
                        feedback: '',
                        time: '',
                      ),
                      rating: r.rating,
                      isVendor: false,
                      isPending: !hasReply,
                      reviewId: r.id,
                    ),
                  );
                  widgets.add(SizedBox(height: 10.h));
                }

                return Column(children: widgets);
              }),
            ],
          ),
        ),
      ),
    );
  }
}

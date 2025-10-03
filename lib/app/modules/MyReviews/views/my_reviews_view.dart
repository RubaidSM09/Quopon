// lib/app/modules/MyReviews/views/my_reviews_view.dart
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
    MyReviewsController myReviewsController = Get.put(MyReviewsController());
    HomeController homeController = Get.put(HomeController());

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

              // Search bar (unchanged)
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
                    Expanded(
                      child: TextField(
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: 'Search review',
                          hintStyle: TextStyle(color: Colors.grey[500]),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Icon(Icons.search, color: Colors.grey[500]),
                  ],
                ),
              ),

              SizedBox(height: 20.h),

              // Filters row (unchanged)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const FilterCard(filterName: 'Latest'),
                    SizedBox(width: 10.w),
                    const FilterCard(filterName: 'All Ratings'),
                    SizedBox(width: 10.w),
                    const FilterCard(filterName: 'Highest Rated'),
                    SizedBox(width: 10.w),
                    const FilterCard(filterName: 'Reply Status'),
                  ],
                ),
              ),

              SizedBox(height: 20.h),

              // ---- Reviews from API ----
              Obx(() {
                if (myReviewsController.isLoading.value) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(24.0),
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  );
                }

                if (myReviewsController.reviews.isEmpty) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 40.h),
                    child: Text(
                      'No reviews yet.',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: const Color(0xFF6F7E8D),
                      ),
                    ),
                  );
                }

                // Build the same cards you used, populated from API
                final widgets = <Widget>[];
                for (final r in myReviewsController.reviews) {
                  widgets.add(
                    MyReviewsCardView(
                      // You don’t receive image/title/offer from the API now,
                      // so we keep your original visuals as placeholders:
                      image: 'assets/images/Review/Iced Matcha Latte.jpg',
                      title: 'Menu item #${r.menuItem}',
                      offer: '',
                      review: Review(
                        review: '“${r.comment}”',
                        reviewer: 'You',
                        time: myReviewsController.timeAgo(r.createdAt),
                      ),
                      rating: r.rating,
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

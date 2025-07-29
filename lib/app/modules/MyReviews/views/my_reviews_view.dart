import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil

import 'package:quopon/app/modules/MyReviews/views/my_reviews_card_view.dart';
import 'package:quopon/common/Filter.dart';

import '../controllers/my_reviews_controller.dart';

class MyReviewsView extends GetView<MyReviewsController> {
  const MyReviewsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9FBFC),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 32.h, 16.w, 16.h), // Use ScreenUtil for padding
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(Icons.arrow_back),
                  ),
                  Text(
                    'My Reviews',
                    style: TextStyle(
                        fontSize: 20.sp, // Use ScreenUtil for font size
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF020711)
                    ),
                  ),
                  SizedBox(),
                ],
              ),

              SizedBox(height: 20.h), // Use ScreenUtil for height

              // Search bar
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r), // Use ScreenUtil for border radius
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

              SizedBox(height: 20.h), // Use ScreenUtil for height

              // Filters row
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    FilterCard(filterName: 'Latest'),
                    SizedBox(width: 10.w),
                    FilterCard(filterName: 'All Ratings'),
                    SizedBox(width: 10.w),
                    FilterCard(filterName: 'Highest Rated'),
                    SizedBox(width: 10.w),
                    FilterCard(filterName: 'Reply Status'),
                  ],
                ),
              ),

              SizedBox(height: 20.h), // Use ScreenUtil for height

              // Reviews
              MyReviewsCardView(
                image: 'assets/images/Review/Iced Matcha Latte.jpg',
                title: 'Iced Matcha Latte',
                offer: '50% OFF on Any Grande Beverage',
                review: Review(
                  review: '“Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s.”',
                  reviewer: 'Leslie Alexander',
                  time: '2 days',
                ),
                rating: 4,
              ),

              SizedBox(height: 10.h), // Use ScreenUtil for height

              MyReviewsCardView(
                image: 'assets/images/Review/Iced Matcha Latte.jpg',
                title: 'Iced Matcha Latte',
                offer: '50% OFF on Any Grande Beverage',
                review: Review(
                  review: '“Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s.”',
                  reviewer: 'Leslie Alexander',
                  time: '2 days',
                ),
                feedback: VendorFeedback(
                  image: 'assets/images/deals/details/Starbucks_Logo.png',
                  title: 'Starbucks',
                  feedback: '“Lorem Ipsum is simply dummy text of the printing and typesetting industry.”',
                  time: '1 days',
                ),
                rating: 4,
              ),

              SizedBox(height: 10.h), // Use ScreenUtil for height

              MyReviewsCardView(
                image: 'assets/images/Review/Iced Matcha Latte.jpg',
                title: 'Iced Matcha Latte',
                offer: '50% OFF on Any Grande Beverage',
                rating: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:get/get.dart';
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
          padding: EdgeInsets.fromLTRB(16, 32, 16, 16),
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
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Color(0xFF020711)),
                  ),
                  SizedBox(),
                ],
              ),

              SizedBox(height: 20,),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
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
                        readOnly: true, // <<— prevent actual editing and avoid focus issues
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

              SizedBox(height: 20,),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    FilterCard(filterName: 'Latest',),
                    SizedBox(width: 10,),
                    FilterCard(filterName: 'All Ratings'),
                    SizedBox(width: 10,),
                    FilterCard(filterName: 'Highest Rated'),
                    SizedBox(width: 10,),
                    FilterCard(filterName: 'Reply Status'),
                  ],
                ),
              ),

              SizedBox(height: 20,),

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

              SizedBox(height: 10,),

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

              SizedBox(height: 10,),

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

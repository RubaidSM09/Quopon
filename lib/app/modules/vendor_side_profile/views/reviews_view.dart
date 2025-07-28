import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../common/Filter.dart';
import '../../MyReviews/controllers/my_reviews_controller.dart';
import '../../MyReviews/views/my_reviews_card_view.dart';

class ReviewsView extends GetView {
  const ReviewsView({super.key});
  @override
  Widget build(BuildContext context) {
    RxBool isPending = false.obs;
    
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
                    'Reviews',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Color(0xFF020711)),
                  ),
                  SizedBox(),
                ],
              ),

              SizedBox(height: 20,),
              
              Obx(() {
                return Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Color(0xFFF1F3F4)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if(isPending.value) {
                                isPending.value = !isPending.value;
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: isPending.value ? Color(0xFFF1F3F4) : Color(0xFFD62828),
                              ),
                              child: SizedBox(
                                width: 161,
                                child: Center(
                                  child: Text(
                                    'Approved Replies (134)',
                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: isPending.value ? Color(0xFF6F7E8D) : Color(0xFFFFFFFF)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if(!isPending.value) {
                                isPending.value = !isPending.value;
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 12),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: !isPending.value ? Color(0xFFF1F3F4) : Color(0xFFD62828)
                              ),
                              child: SizedBox(
                                width: 161,
                                child: Center(
                                  child: Text(
                                    'Pending Reviews (89)',
                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: !isPending.value ? Color(0xFF6F7E8D) : Color(0xFFFFFFFF)),
                                  ),
                                ),
                              ),
                            ),
                          ),
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

                    isPending.value ? Column(
                      children: [
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
                          isVendor: true,
                          isPending: true,
                        ),
                      ],
                    ) :
                    Column(
                      children: [
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
                          isVendor: true,
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
                          isVendor: true,
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
                          isVendor: true,
                        ),
                      ],
                    ),
                  ],
                );
              }),



              SizedBox(height: 10,),



              SizedBox(height: 10,),
            ],
          ),
        ),
      ),
    );
  }
}

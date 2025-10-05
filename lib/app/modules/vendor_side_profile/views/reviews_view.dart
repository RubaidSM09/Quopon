import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
          padding: EdgeInsets.fromLTRB(16.w, 32.h, 16.w, 16.h),
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
                    style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500, color: Color(0xFF020711)),
                  ),
                  SizedBox(),
                ],
              ),

              SizedBox(height: 20.h,),
              
              Obx(() {
                return Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
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
                              padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 12.h, bottom: 12.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                color: isPending.value ? Color(0xFFF1F3F4) : Color(0xFFD62828),
                              ),
                              child: SizedBox(
                                width: 161.w,
                                child: Center(
                                  child: Text(
                                    'Approved Replies (134)',
                                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: isPending.value ? Color(0xFF6F7E8D) : Color(0xFFFFFFFF)),
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
                              padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 12.h, bottom: 12.h),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: !isPending.value ? Color(0xFFF1F3F4) : Color(0xFFD62828)
                              ),
                              child: SizedBox(
                                width: 161.w,
                                child: Center(
                                  child: Text(
                                    'Pending Reviews (89)',
                                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: !isPending.value ? Color(0xFF6F7E8D) : Color(0xFFFFFFFF)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20.h,),

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          FilterCard(filterName: 'Latest', iconPath: '', active: false,),
                          SizedBox(width: 10.w,),
                          FilterCard(filterName: 'All Ratings', iconPath: '', active: false,),
                          SizedBox(width: 10.w,),
                          FilterCard(filterName: 'Highest Rated', iconPath: '', active: false,),
                          SizedBox(width: 10.w,),
                          FilterCard(filterName: 'Reply Status', iconPath: '', active: false,),
                        ],
                      ),
                    ),

                    SizedBox(height: 20.h,),

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
                        SizedBox(height: 10.h,),
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
                        SizedBox(height: 10.h,),
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



              SizedBox(height: 10.h,),



              SizedBox(height: 10.h,),
            ],
          ),
        ),
      ),
    );
  }
}

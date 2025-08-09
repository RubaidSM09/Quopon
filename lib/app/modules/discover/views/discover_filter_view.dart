import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:quopon/app/modules/discover/views/discover_filter_card_view.dart';

import '../../../../common/customTextButton.dart';
import '../controllers/discover_controller.dart';

class DiscoverFilterView extends GetView<DiscoverController> {
  const DiscoverFilterView({super.key});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox.shrink(),
                  Text(
                    'Filters',
                    style: TextStyle(
                      color: Color(0xFF020711),
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(
                      Icons.close,
                      size: 24.sp,
                      color: Color(0xFF020711),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16.h),

              Divider(color: Color(0xFFEAECED)),

              SizedBox(height: 16.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Cuisine',
                    style: TextStyle(
                      color: Color(0xFF020711),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox.shrink(),
                ],
              ),
              SizedBox(height: 12.h),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  CuisineFilterCardView(filterTitle: 'Asian', index: 0),

                  CuisineFilterCardView(filterTitle: 'American', index: 1),

                  CuisineFilterCardView(filterTitle: 'European', index: 2),

                  CuisineFilterCardView(filterTitle: 'French', index: 3),

                  CuisineFilterCardView(filterTitle: 'Georgian', index: 4),

                  CuisineFilterCardView(filterTitle: 'Indian', index: 5),

                  CuisineFilterCardView(filterTitle: 'Italian', index: 6),

                  CuisineFilterCardView(filterTitle: 'Middle Eastern', index: 7,),

                  CuisineFilterCardView(filterTitle: 'Russian', index: 8),
                ],
              ),

              SizedBox(height: 16.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Diet',
                    style: TextStyle(
                      color: Color(0xFF020711),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox.shrink(),
                ],
              ),
              SizedBox(height: 12.h),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  DietFilterCardView(filterTitle: 'Vegetarian', index: 0),

                  DietFilterCardView(filterTitle: 'Vegan', index: 1),

                  DietFilterCardView(filterTitle: 'Gluten-free', index: 2),
                ],
              ),

              SizedBox(height: 16.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Price',
                    style: TextStyle(
                      color: Color(0xFF020711),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox.shrink(),
                ],
              ),
              SizedBox(height: 12.h),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  PriceFilterCardView(filterTitle: 'Less \$30', index: 0),

                  PriceFilterCardView(filterTitle: '\$30 - \$40', index: 1),

                  PriceFilterCardView(filterTitle: '\$40 or more', index: 2),
                ],
              ),

              SizedBox(height: 16.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Rating',
                    style: TextStyle(
                      color: Color(0xFF020711),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox.shrink(),
                ],
              ),
              SizedBox(height: 12.h),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  RatingFilterCardView(filterTitle: '1-2 Stars', index: 0),

                  RatingFilterCardView(filterTitle: '3 Stars', index: 1),

                  RatingFilterCardView(filterTitle: '4 Stars', index: 2),

                  RatingFilterCardView(filterTitle: '5 Stars', index: 3),
                ],
              ),

              SizedBox(height: 16.h),

              Divider(color: Color(0xFFEAECED)),

              SizedBox(height: 16.h),

              GradientButton(
                text: 'Apply Filter',
                onPressed: () {
                  Get.back();
                },
                colors: [
                  const Color(0xFFD62828),
                  const Color(0xFFC21414),
                ],
                boxShadow: [
                  const BoxShadow(
                    color: Color(0xFF9A0000),
                    spreadRadius: 1,
                  ),
                ],
                borderRadius: 12,
                child: Text(
                  'Apply Filter',
                  style: TextStyle(
                    fontSize: 16.sp, // Use ScreenUtil for font size
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

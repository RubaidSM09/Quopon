import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';  // Import ScreenUtil
import 'package:quopon/app/modules/VendorProfile/views/vendor_profile_view.dart';
import 'package:quopon/app/modules/vendor_add_menu/views/vendor_add_menu_view.dart';
import 'package:quopon/app/modules/vendor_deals/views/vendor_deals_view.dart';
import 'package:quopon/app/modules/vendor_menu/views/menu_card_view.dart';
import 'package:quopon/app/modules/vendor_side_profile/views/vendor_side_profile_view.dart';

import '../../../../common/customTextButton.dart';
import '../../Search/views/search_view.dart';
import '../../vendor_create_deal/views/vendor_create_deal_view.dart';
import '../../vendor_dashboard/views/vendor_dashboard_view.dart';
import '../controllers/vendor_menu_controller.dart';

class VendorMenuView extends GetView<VendorMenuController> {
  const VendorMenuView({super.key});
  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 3;

    return Scaffold(
      backgroundColor: Color(0xFFF9FBFC),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 60.h, 16.w, 22.h),  // Use ScreenUtil for padding
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Icon(Icons.arrow_back, color: Color(0xFF020711), size: 24.sp,),
                  ),
                  Text(
                    'My Menu',
                    style: TextStyle(
                        color: Color(0xFF020711),
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                  SizedBox.shrink(),
                ],
              ),

              SizedBox(height: 20.h),  // Use ScreenUtil for height

              // Search bar
              GestureDetector(
                onTap: () {
                  Get.to(SearchView());
                },
                child: Container(
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
                            hintText: 'Search food...',
                            hintStyle: TextStyle(color: Colors.grey[500]),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Image.asset('assets/images/Home/Search.png'),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20.h),  // Use ScreenUtil for height

              Row(
                children: [
                  Text(
                    'Breakfast',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,  // Use ScreenUtil for font size
                      color: Color(0xFF020711),
                    ),
                  ),
                  SizedBox.shrink(),
                ],
              ),
              SizedBox(height: 15.h),  // Use ScreenUtil for height
              MenuCardView(
                image: 'assets/images/Menu/Custom Chicken Steak Hoagie.png',
                title: 'Custom Chicken Steak Hoagie',
                description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s.',
                price: 5.29,
              ),
              SizedBox(height: 7.5.h),  // Use ScreenUtil for height
              MenuCardView(
                image: 'assets/images/Menu/Custom Chicken Steak Hoagie.png',
                title: 'Custom Chicken Steak Hoagie',
                description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s.',
                price: 5.29,
              ),
              SizedBox(height: 7.5.h),  // Use ScreenUtil for height
              MenuCardView(
                image: 'assets/images/Menu/Custom Chicken Steak Hoagie.png',
                title: 'Custom Chicken Steak Hoagie',
                description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s.',
                price: 5.29,
              ),

              SizedBox(height: 15.h),  // Use ScreenUtil for height

              Row(
                children: [
                  Text(
                    'Lunch',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,  // Use ScreenUtil for font size
                      color: Color(0xFF020711),
                    ),
                  ),
                  SizedBox.shrink(),
                ],
              ),
              SizedBox(height: 15.h),  // Use ScreenUtil for height
              MenuCardView(
                image: 'assets/images/Menu/Custom Chicken Steak Hoagie.png',
                title: 'Custom Chicken Steak Hoagie',
                description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s.',
                price: 5.29,
              ),
              SizedBox(height: 7.5.h),  // Use ScreenUtil for height
              MenuCardView(
                image: 'assets/images/Menu/Custom Chicken Steak Hoagie.png',
                title: 'Custom Chicken Steak Hoagie',
                description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s.',
                price: 5.29,
              ),
              SizedBox(height: 7.5.h),  // Use ScreenUtil for height
              MenuCardView(
                image: 'assets/images/Menu/Custom Chicken Steak Hoagie.png',
                title: 'Custom Chicken Steak Hoagie',
                description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s.',
                price: 5.29,
              ),

              SizedBox(height: 15.h),  // Use ScreenUtil for height

              Row(
                children: [
                  Text(
                    'Dinner',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,  // Use ScreenUtil for font size
                      color: Color(0xFF020711),
                    ),
                  ),
                  SizedBox.shrink(),
                ],
              ),
              SizedBox(height: 15.h),  // Use ScreenUtil for height
              MenuCardView(
                image: 'assets/images/Menu/Custom Chicken Steak Hoagie.png',
                title: 'Custom Chicken Steak Hoagie',
                description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s.',
                price: 5.29,
              ),
              SizedBox(height: 7.5.h),  // Use ScreenUtil for height
              MenuCardView(
                image: 'assets/images/Menu/Custom Chicken Steak Hoagie.png',
                title: 'Custom Chicken Steak Hoagie',
                description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s.',
                price: 5.29,
              ),
              SizedBox(height: 7.5.h),  // Use ScreenUtil for height
              MenuCardView(
                image: 'assets/images/Menu/Custom Chicken Steak Hoagie.png',
                title: 'Custom Chicken Steak Hoagie',
                description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s.',
                price: 5.29,
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 24.r)]
        ),
        child: GradientButton(
          text: 'Add Menu Item',
          onPressed: () {
            Get.to(VendorAddMenuView());
          },
          borderColor: [Color(0xFFF44646), Color(0xFFC21414)],
          boxShadow: [BoxShadow(color: Color(0xFF9A0000), spreadRadius: 1.r)],
          colors: [Color(0xFFD62828), Color(0xFFC21414)],
        ),
      ),
    );
  }
}

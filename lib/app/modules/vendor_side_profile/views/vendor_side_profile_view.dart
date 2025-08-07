import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';  // Import ScreenUtil
import 'package:quopon/app/modules/my_orders_vendors/views/my_orders_vendors_view.dart';

import 'package:quopon/app/modules/vendor_create_deal/views/vendor_create_deal_view.dart';
import 'package:quopon/app/modules/vendor_dashboard/views/vendor_dashboard_view.dart';
import 'package:quopon/app/modules/vendor_deals/views/vendor_deals_view.dart';
import 'package:quopon/app/modules/vendor_menu/views/vendor_menu_view.dart';
import 'package:quopon/app/modules/vendor_side_profile/views/edit_business_profile_view.dart';
import 'package:quopon/app/modules/vendor_side_profile/views/my_followers_view.dart';
import 'package:quopon/app/modules/vendor_side_profile/views/reviews_view.dart';

import '../../../../common/profileCard.dart';
import '../../login/views/login_vendor_view.dart';
import '../controllers/vendor_side_profile_controller.dart';

class VendorSideProfileView extends GetView {
  const VendorSideProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 4;

    Get.put(VendorSideProfileController());

    return Scaffold(
      backgroundColor: Color(0xFFF9FBFC),
      body: Padding(
        padding: EdgeInsets.all(16.w),  // Use ScreenUtil for padding
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(height: 20.h),  // Use ScreenUtil for spacing
                Center(
                  child: Text(
                    "Profile",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp),  // Use ScreenUtil for font size
                  ),
                ),
              ],
            ),
            CircleAvatar(
              radius: 40.r,  // Use ScreenUtil for radius
              backgroundImage: AssetImage("assets/images/deals/details/Starbucks_Logo.png"),
            ),
            Column(
              children: [
                Text(
                  "Starbucks",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp),
                ),
                Text(
                  "starbucks@email.com",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp, color: Color(0xFF6F7E8D)),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),  // Use ScreenUtil for radius
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.w),  // Use ScreenUtil for padding
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Business Info",
                          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.sp),
                        ),
                        SizedBox(height: 16.h,),
                        GestureDetector(
                          onTap: () {
                            Get.to(EditBusinessProfileView());
                          },
                          child: ProfileCard(icon: 'assets/images/Profile/Edit.png', title: 'Edit Business Profile'),
                        ),
                        SizedBox(height: 16.h,),
                        GestureDetector(
                          onTap: () {
                            Get.to(VendorMenuView());
                          },
                          child: ProfileCard(icon: 'assets/images/Profile/Vendors/MyMenu.png', title: 'My Menu'),
                        ),
                        SizedBox(height: 16.h,),
                        GestureDetector(
                          onTap: () {
                            Get.to(MyFollowersView());
                          },
                          child: ProfileCard(icon: 'assets/images/Profile/Vendors/My Followers.png', title: 'My Followers'),
                        ),
                        SizedBox(height: 16.h,),
                        GestureDetector(
                          onTap: () {
                            Get.to(ReviewsView());
                          },
                          child: ProfileCard(icon: 'assets/images/Profile/MyReviews.png', title: 'Reviews'),
                        ),
                        SizedBox(height: 16.h,),
                        GestureDetector(
                          onTap: () {

                          },
                          child: ProfileCard(icon: 'assets/images/Profile/Vendors/Contact Information.png', title: 'Contact Information'),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),  // Use ScreenUtil for radius
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.w),  // Use ScreenUtil for padding
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Security Settings",
                          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.sp),
                        ),
                        SizedBox(height: 16.h,),
                        GestureDetector(
                          onTap: () {

                          },
                          child: ProfileCard(icon: 'assets/images/Profile/FAQ.png', title: 'Support / FAQ'),
                        ),
                        SizedBox(height: 16.h,),
                        GestureDetector(
                          onTap: () {

                          },
                          child: ProfileCard(icon: 'assets/images/Profile/Vendors/Change Password.png', title: 'Change Password'),
                        ),
                        SizedBox(height: 16.h,),
                        GestureDetector(
                          onTap: () {
                            Get.to(LoginVendorView());
                          },
                          child: ProfileCard(icon: 'assets/images/Profile/Logout.png', title: 'Logout'),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

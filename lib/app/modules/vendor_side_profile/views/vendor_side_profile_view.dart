import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quopon/app/modules/login/views/login_vendor_view.dart';
import 'package:quopon/app/modules/vendor_menu/views/vendor_menu_view.dart';
import 'package:quopon/app/modules/vendor_side_profile/views/edit_business_profile_view.dart';
import 'package:quopon/app/modules/vendor_side_profile/views/my_followers_view.dart';
import 'package:quopon/app/modules/vendor_side_profile/views/reviews_view.dart';

import '../../../../common/profileCard.dart';
import '../../vendor_create_deal/views/vendor_create_deal_view.dart';
import '../../vendor_dashboard/views/vendor_dashboard_view.dart';
import '../../vendor_deals/views/vendor_deals_view.dart';
import '../controllers/vendor_side_profile_controller.dart';

class VendorSideProfileView extends GetView<VendorSideProfileController> {
  const VendorSideProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 4;

    Get.put(VendorSideProfileController());

    return Scaffold(
      backgroundColor: Color(0xFFF9FBFC),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(height: 20),
                Center(
                  child: Text(
                    "Profile",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                )
              ],
            ),
            CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage("assets/images/deals/details/Starbucks_Logo.png"),
            ),
            Column(
              children: [
                Text(
                  "Starbucks",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
                Text(
                  "starbucks@email.com",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Color(0xFF6F7E8D)),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  height: 278,
                  width: 398,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Business Info",
                          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                        ),
                        // Edit Profile card with Get.to() for navigation
                        GestureDetector(
                          onTap: () {
                            Get.to(EditBusinessProfileView());
                          },
                          child: ProfileCard(icon: 'assets/images/Profile/Edit.png', title: 'Edit Business Profile'),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(MyFollowersView());
                          },
                          child: ProfileCard(icon: 'assets/images/Profile/Vendors/My Followers.png', title: 'My Followers'),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(ReviewsView());
                          },
                          child: ProfileCard(icon: 'assets/images/Profile/MyReviews.png', title: 'Reviews'),),
                        GestureDetector(
                          onTap: () {

                          },
                          child: ProfileCard(icon: 'assets/images/Profile/Vendors/Contact Information.png', title: 'Contact Information'),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: 222,
                  width: 398,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Security Settings",
                          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                        ),
                        GestureDetector(
                          onTap: () {

                          },
                          child: ProfileCard(icon: 'assets/images/Profile/FAQ.png', title: 'Support / FAQ'),
                        ),
                        GestureDetector(
                          onTap: () {

                          },
                          child: ProfileCard(icon: 'assets/images/Profile/Vendors/Change Password.png', title: 'Change Password'),
                        ),
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
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFFFFFFFF),
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) {
          if (index == 2) {
            Get.to(VendorCreateDealView());
          }

          if (index == 0) {
            Get.to(VendorDashboardView());
          }

          if (index == 1) {
            Get.to(VendorDealsView());
          }
          if (index == 3) {
            Get.to(VendorMenuView());
          }
        },
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/BottomNavigation/Dashboard.png'),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/BottomNavigation/Deals.png'),
            label: 'Deals',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/BottomNavigation/Create Deal.png'),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/BottomNavigation/Menu.png'),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/BottomNavigation/Profile Active.png'),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

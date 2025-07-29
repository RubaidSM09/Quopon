import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil
import 'package:quopon/app/modules/MyReviews/views/my_reviews_view.dart';
import 'package:quopon/app/modules/Profile/views/follow_vendors_view.dart';
import 'package:quopon/app/modules/Profile/views/settings_view.dart';
import 'package:quopon/app/modules/QuoponPlus/views/quopon_plus_view.dart';
import 'package:quopon/app/modules/SupportFAQ/views/support_f_a_q_view.dart';
import 'package:quopon/common/profileCard.dart';
import '../controllers/profile_controller.dart';
import 'edit_profile_view.dart'; // Make sure to import EditProfileView

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());

    return Scaffold(
      backgroundColor: Color(0xFFF9FBFC),
      body: Padding(
        padding: EdgeInsets.all(16.w), // Use ScreenUtil for padding
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(height: 20.h), // Use ScreenUtil for spacing
                Center(
                  child: Text(
                    "Profile",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp), // Use ScreenUtil for font size
                  ),
                ),
              ],
            ),
            CircleAvatar(
              radius: 40.r, // Use ScreenUtil for radius
              backgroundImage: AssetImage("assets/images/Profile/ProfilePic.jpg"),
            ),
            Column(
              children: [
                Text(
                  "Tanjiro Kamado",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp), // Use ScreenUtil for font size
                ),
                Text(
                  "tanjirokamado@email.com",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp, color: Color(0xFF6F7E8D)), // Use ScreenUtil for font size
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  height: 278.h, // Use ScreenUtil for height
                  width: 398.w, // Use ScreenUtil for width
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r), // Use ScreenUtil for radius
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.w), // Use ScreenUtil for padding
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "User Profile",
                          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.sp), // Use ScreenUtil for font size
                        ),
                        // Edit Profile card with Get.to() for navigation
                        GestureDetector(
                          onTap: () {
                            // Use Get.to() to navigate to EditProfileView
                            Get.to(() => EditProfileView());
                          },
                          child: ProfileCard(icon: 'assets/images/Profile/Edit.png', title: 'Edit Profile'),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => FollowVendorsView());
                          },
                          child: ProfileCard(icon: 'assets/images/Profile/FollowedVendors.png', title: 'Followed Vendors'),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(MyReviewsView());
                          },
                          child: ProfileCard(icon: 'assets/images/Profile/MyReviews.png', title: 'My Reviews'),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.bottomSheet(QuoponPlusView());
                          },
                          child: ProfileCard(icon: 'assets/images/Profile/Quopon.png', title: 'Qoupon+ Info/Upgrade'),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.h), // Use ScreenUtil for spacing
                Container(
                  height: 222.h, // Use ScreenUtil for height
                  width: 398.w, // Use ScreenUtil for width
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r), // Use ScreenUtil for radius
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.w), // Use ScreenUtil for padding
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Security Settings",
                          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.sp), // Use ScreenUtil for font size
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => SupportFAQView());
                          },
                          child: ProfileCard(icon: 'assets/images/Profile/FAQ.png', title: 'Support / FAQ'),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => SettingsView());
                          },
                          child: ProfileCard(icon: 'assets/images/Profile/Settings.png', title: 'Settings'),
                        ),
                        ProfileCard(icon: 'assets/images/Profile/Logout.png', title: 'Logout'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          backgroundColor: const Color(0xFFFFFFFF),
          type: BottomNavigationBarType.fixed,
          currentIndex: controller.selectedIndex.value,
          onTap: controller.onItemTapped,
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(
              icon: Image.asset('assets/images/BottomNavigation/Home.png'),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/images/BottomNavigation/Deals.png'),
              label: 'Deals',
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: EdgeInsets.all(8.w), // Use ScreenUtil for padding
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Image.asset('assets/images/BottomNavigation/QR.png'),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/images/BottomNavigation/My Deals.png'),
              label: 'My Deals',
            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/images/BottomNavigation/Profile Active.png'),
              label: 'Profile',
            ),
          ],
        );
      }),
    );
  }
}

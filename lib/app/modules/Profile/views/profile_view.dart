// lib/app/modules/Profile/views/profile_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quopon/app/modules/MyReviews/views/my_reviews_view.dart';
import 'package:quopon/app/modules/Profile/views/follow_vendors_view.dart';
import 'package:quopon/app/modules/Profile/views/settings_view.dart';
import 'package:quopon/app/modules/QuoponPlus/views/quopon_plus_view.dart';
import 'package:quopon/app/modules/SupportFAQ/views/support_f_a_q_view.dart';
import 'package:quopon/app/modules/my_orders/views/my_orders_view.dart';
import 'package:quopon/common/profileCard.dart';
import '../controllers/profile_controller.dart';
import 'edit_profile_view.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());

    return Scaffold(
      backgroundColor: const Color(0xFFF9FBFC),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Obx(() {
          // header + loader area (keeps your structure)
          final loading = controller.isLoading.value;

          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(height: 20.h),
                  Center(
                    child: Text(
                      "Profile",
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp),
                    ),
                  ),
                ],
              ),

              // avatar (uses network if available, else your asset)
              CircleAvatar(
                radius: 40.r,
                backgroundImage: controller.profilePictureUrl.value.isNotEmpty
                    ? NetworkImage(controller.profilePictureUrl.value)
                    : const AssetImage("assets/images/Profile/ProfilePic.jpg") as ImageProvider,
              ),

              // name + email (fallbacks preserved)
              Column(
                children: [
                  Text(
                    controller.fullName.value.isNotEmpty ? controller.fullName.value : "Tanjiro Kamado",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp),
                  ),
                  Text(
                    controller.email.value.isNotEmpty ? controller.email.value : "tanjirokamado@email.com",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp, color: const Color(0xFF6F7E8D)),
                  ),
                  if (loading) ...[
                    SizedBox(height: 8.h),
                    const SizedBox(
                      height: 16, width: 16, child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ],
                ],
              ),

              // cards (unchanged)
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("User Profile", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.sp)),
                          SizedBox(height: 16.h),
                          GestureDetector(
                            onTap: () => Get.to(() => const EditProfileView()),
                            child: const ProfileCard(icon: 'assets/images/Profile/Edit.png', title: 'Edit Profile'),
                          ),
                          SizedBox(height: 16.h),
                          GestureDetector(
                            onTap: () => Get.to(const MyOrdersView()),
                            child: const ProfileCard(icon: 'assets/images/Profile/MyOrders.png', title: 'My Orders'),
                          ),
                          SizedBox(height: 16.h),
                          GestureDetector(
                            onTap: () => Get.to(() => const FollowVendorsView()),
                            child: const ProfileCard(icon: 'assets/images/Profile/FollowedVendors.png', title: 'Followed Vendors'),
                          ),
                          SizedBox(height: 16.h),
                          GestureDetector(
                            onTap: () => Get.to(const MyReviewsView()),
                            child: const ProfileCard(icon: 'assets/images/Profile/MyReviews.png', title: 'My Reviews'),
                          ),
                          SizedBox(height: 16.h),
                          GestureDetector(
                            onTap: () => Get.bottomSheet(const QuoponPlusView()),
                            child: const ProfileCard(icon: 'assets/images/Profile/Quopon.png', title: 'Qoupon+ Info/Upgrade'),
                          ),
                          SizedBox(height: 16.h),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Security Settings", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.sp)),
                          SizedBox(height: 16.h),
                          GestureDetector(
                            onTap: () => Get.to(() => const SupportFAQView()),
                            child: const ProfileCard(icon: 'assets/images/Profile/FAQ.png', title: 'Support / FAQ'),
                          ),
                          SizedBox(height: 16.h),
                          GestureDetector(
                            onTap: () => Get.to(() => const SettingsView()),
                            child: const ProfileCard(icon: 'assets/images/Profile/Settings.png', title: 'Settings'),
                          ),
                          SizedBox(height: 16.h),
                          GestureDetector(
                            onTap: controller.userLogout,
                            child: const ProfileCard(icon: 'assets/images/Profile/Logout.png', title: 'Logout'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }
}

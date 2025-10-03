// lib/app/modules/vendor_side_profile/views/my_followers_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quopon/app/modules/vendor_side_profile/controllers/my_followers_controller.dart';
import 'package:quopon/common/FollowersCard.dart';

class MyFollowersView extends GetView<MyFollowersController> {
  const MyFollowersView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MyFollowersController());

    return Scaffold(
      backgroundColor: const Color(0xFFF9FBFC),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(onTap: Get.back, child: const Icon(Icons.arrow_back)),
                Text('My Followers',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp)),
                const SizedBox(width: 24), // spacer
              ],
            ),
            SizedBox(height: 25.h),

            // Search (placeholder)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
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
                        hintText: 'Search followers',
                        hintStyle: TextStyle(color: Colors.grey[500]),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Image.asset('assets/images/Home/Search.png'),
                ],
              ),
            ),

            // List
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (controller.error.value != null) {
                  return Center(
                    child: Text(
                      controller.error.value!,
                      style: TextStyle(color: Colors.red, fontSize: 14.sp),
                    ),
                  );
                }
                if (controller.followerList.isEmpty) {
                  return const Center(child: Text('No followers found'));
                }

                return ListView.builder(
                  itemCount: controller.followerList.length,
                  itemBuilder: (context, index) {
                    final f = controller.followerList[index];
                    return FollowersCard(
                      followersProfilePic: f.followersProfilePic, // placeholder asset
                      followerName: f.followerName,               // email for now
                      redeemedDeals: f.redeemedDeals,             // 0 for now
                      pushOpens: f.pushOpens,                     // 0 for now
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

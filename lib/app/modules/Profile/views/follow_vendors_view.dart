import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quopon/common/VendorCard.dart';
import '../controllers/follow_vendors_controller.dart';

class FollowVendorsView extends GetView<FollowVendorsController> {
  const FollowVendorsView({super.key});

  @override
  Widget build(BuildContext context) {
    final FollowVendorsController controller = Get.put(FollowVendorsController());

    return Scaffold(
      backgroundColor: const Color(0xFFF9FBFC),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              children: [
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(Icons.arrow_back, size: 24.sp),
                    ),
                    Text(
                      "Follow Vendors",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(width: 24.w), // Placeholder to balance layout
                  ],
                )
              ],
            ),

            SizedBox(height: 25.h),

            // Search bar
            GestureDetector(
              onTap: () {
                // TODO: Navigate to search
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 0),
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
                          hintText: 'Search food, store, deals...',
                          hintStyle: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 14.sp,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Icon(Icons.search, color: Colors.grey[500], size: 24.sp),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20.h),

            Expanded(
              child: Obx(() {
                if (controller.followedVendors.isEmpty) {
                  return Center(
                    child: Text(
                      "No vendors found",
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: controller.followedVendors.length,
                  itemBuilder: (context, index) {
                    final vendor = controller.followedVendors[index];
                    return VendorCard(
                      brandLogo: vendor.logoUrl,
                      dealStoreName: vendor.title,
                      dealType: vendor.category,
                      activeDeals: vendor.activeDeals,
                    );
                  },
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}

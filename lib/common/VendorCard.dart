import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quopon/app/modules/VendorProfile/views/vendor_profile_view.dart';

class VendorCard extends GetView {
  final String brandLogo;
  final String dealStoreName;
  final String dealType;
  final int activeDeals;

  const VendorCard({
    required this.brandLogo,
    required this.dealStoreName,
    required this.dealType,
    required this.activeDeals,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    brandLogo,
                    width: 40.w, // responsive size for brand logo
                    height: 40.h,
                  ),
                ),
                SizedBox(width: 10.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dealStoreName,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          dealType,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Color(0xFFD62828),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Container(
                          height: 5.h,
                          width: 5.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFCAD9E8),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          "$activeDeals Active Deals",
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => VendorProfileView());
              },
              child: Container(
                width: 93.w,
                height: 32.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.r),
                  color: Color(0xFFD62828),
                ),
                child: Center(
                  child: Text(
                    'View Profile',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 5.h),
        Divider(
          color: Color(0xFFF0F2F3),
          thickness: 2,
        ),
      ],
    );
  }
}

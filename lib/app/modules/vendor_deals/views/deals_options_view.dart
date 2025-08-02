import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quopon/app/modules/vendor_edit_deal/views/vendor_edit_deal_view.dart';
import '../../../../common/profileCard.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';  // Import ScreenUtil

class DealsOptionsView extends GetView {
  const DealsOptionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 266.h,  // Use ScreenUtil for height
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.r),  // Use ScreenUtil for radius
          topRight: Radius.circular(12.r),  // Use ScreenUtil for radius
        ),
        color: Colors.white,
      ),
      padding: EdgeInsets.all(16.w),  // Use ScreenUtil for padding
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox.shrink(),
              Text(
                'Deal Options',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18.sp,  // Use ScreenUtil for font size
                  color: Color(0xFF020711),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Icon(Icons.close),
              )
            ],
          ),
          Divider(color: Color(0xFFEAECED)),

          SizedBox(height: 10.h),  // Use ScreenUtil for height

          GestureDetector(
            onTap: () {
              Get.back();
              Get.to(VendorEditDealView());
            },
            child: ProfileCard(
              icon: 'assets/images/DealOptions/Edit Deal.png',
              title: 'Edit Deal',
            ),
          ),

          SizedBox(height: 10.h),  // Use ScreenUtil for height

          GestureDetector(
            onTap: () {},
            child: ProfileCard(
              icon: 'assets/images/DealOptions/Deactivate Deal.png',
              title: 'Deactivate Deal',
            ),
          ),

          SizedBox(height: 10.h),  // Use ScreenUtil for height

          GestureDetector(
            onTap: () {},
            child: ProfileCard(
              icon: 'assets/images/DealOptions/Delete Deal.png',
              title: 'Delete Deal',
            ),
          ),
        ],
      ),
    );
  }
}

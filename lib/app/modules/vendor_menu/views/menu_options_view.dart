import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';  // Import ScreenUtil

import '../../../../common/profileCard.dart';
import '../../vendor_edit_deal/views/vendor_edit_deal_view.dart';

class MenuOptionsView extends GetView {
  const MenuOptionsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 266.h,  // Use ScreenUtil for height
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.r), topRight: Radius.circular(12.r)),  // Use ScreenUtil for radius
          color: Colors.white
      ),
      padding: EdgeInsets.all(16.w),  // Use ScreenUtil for padding
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox.shrink(),
              Text(
                'Item Options',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.sp, color: Color(0xFF020711)),  // Use ScreenUtil for font size
              ),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Icon(Icons.close),
              )
            ],
          ),
          Divider(color: Color(0xFFEAECED),),

          SizedBox(height: 10.h),  // Use ScreenUtil for height

          GestureDetector(
            onTap: () {
              Get.back();
              Get.to(VendorEditDealView());
            },
            child: ProfileCard(icon: 'assets/images/DealOptions/Edit Deal.png', title: 'Edit Item'),
          ),

          SizedBox(height: 10.h),  // Use ScreenUtil for height

          GestureDetector(
            onTap: () {

            },
            child: ProfileCard(icon: 'assets/images/DealOptions/Deactivate Deal.png', title: 'Deactivate Deal', isActive: true,),
          ),

          SizedBox(height: 10.h),  // Use ScreenUtil for height

          GestureDetector(
            onTap: () {

            },
            child: ProfileCard(icon: 'assets/images/DealOptions/Delete Deal.png', title: 'Delete Item'),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';  // Import ScreenUtil

import 'package:intl/intl.dart';
import 'package:quopon/app/modules/vendor_menu/views/menu_options_view.dart';

class MenuCardView extends GetView {
  final String image;
  final String title;
  final String description;
  final double price;

  const MenuCardView({
    required this.image,
    required this.title,
    required this.description,
    required this.price,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 12.w, left: 8.w, top: 8.h, bottom: 8.h),  // Use ScreenUtil for padding
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),  // Use ScreenUtil for radius
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 16.r)],  // Use ScreenUtil for blur radius
      ),
      child: Row(
        children: [
          Container(
            height: 88.h,  // Use ScreenUtil for height
            width: 88.w,  // Use ScreenUtil for width
            decoration: BoxDecoration(
              color: Color(0xFFF4F6F7),
              borderRadius: BorderRadius.circular(8.r),  // Use ScreenUtil for radius
            ),
            child: Image.asset(
              image,
            ),
          ),
          SizedBox(width: 10.w),  // Use ScreenUtil for width
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 278.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,  // Use ScreenUtil for font size
                        color: Color(0xFF020711),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.bottomSheet(MenuOptionsView());
                      },
                      child: Icon(Icons.more_vert),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 278.w,  // Use ScreenUtil for width
                child: Text(
                  description,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,  // Use ScreenUtil for font size
                    color: Color(0xFF6F7E8D),
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              Text(
                '\$${price.toStringAsFixed(2)}',  // Format price to two decimal points
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,  // Use ScreenUtil for font size
                  color: Color(0xFFD62828),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

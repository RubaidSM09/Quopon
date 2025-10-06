// lib/app/modules/vendor_menu/views/menu_card_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quopon/app/modules/vendor_menu/views/menu_options_view.dart';

class MenuCardView extends GetView {
  final int menuId;
  final String image;
  final String title;
  final String description;
  final double price;

  // 🔹 NEW: tell the card whether to load from network or asset
  final bool isNetworkImage;

  const MenuCardView({
    required this.menuId,
    required this.image,
    required this.title,
    required this.description,
    required this.price,
    this.isNetworkImage = false, // default keeps old behavior
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 12.w, left: 8.w, top: 8.h, bottom: 8.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 16.r)],
      ),
      child: Row(
        children: [
          Container(
            height: 88.h,
            width: 88.w,
            decoration: BoxDecoration(
              color: const Color(0xFFF4F6F7),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: isNetworkImage
                ? ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Image.network(image, fit: BoxFit.cover),
            )
                : Image.asset(image),
          ),
          SizedBox(width: 10.w),
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
                        fontSize: 16.sp,
                        color: const Color(0xFF020711),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.bottomSheet(MenuOptionsView(menuId: menuId,)),
                      child: const Icon(Icons.more_vert),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 278.w,
                child: Text(
                  description,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                    color: const Color(0xFF6F7E8D),
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              Text(
                '\$${price.toStringAsFixed(2)}',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                  color: const Color(0xFFD62828),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

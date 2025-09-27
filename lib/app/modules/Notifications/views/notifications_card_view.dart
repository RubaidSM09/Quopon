import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationsCardView extends GetView {
  final bool isChecked; // read = true -> isChecked = true
  final String icon;
  final Color iconBg;
  final String title;
  final String time;
  final String description;
  final VoidCallback? onTap; // added for tap handling

  const NotificationsCardView({
    required this.isChecked,
    required this.icon,
    required this.iconBg,
    required this.title,
    required this.time,
    required this.description,
    this.onTap,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(right: 16.w, left: 16.w, top: 12.h, bottom: 12.h),
        decoration: BoxDecoration(
          border: const Border(
            top: BorderSide(color: Color(0xFFF0F2F3)),
            bottom: BorderSide(color: Color(0xFFF0F2F3)),
          ),
          color: isChecked ? const Color(0xFFF9FBFC) : const Color(0xFFF8F3F4),
          // Keep your original background logic:
          // read -> light, unread -> slightly tinted
        ),

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(shape: BoxShape.circle, color: iconBg),
              padding: EdgeInsets.all(8.w),
              child: Image.asset(icon),
            ),
            SizedBox(width: 10.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 345.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: const Color(0xFF020711)),
                      ),
                      Row(
                        children: [
                          if (!isChecked)
                            Container(
                              decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFFD62828)),
                              height: 8.h,
                              width: 8.w,
                            ),
                          if (!isChecked) SizedBox(width: 5.w),
                          Text(
                            time,
                            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400, color: const Color(0xFF6F7E8D)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 345.w,
                  child: Text(
                    description,
                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: const Color(0xFF6F7E8D)),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

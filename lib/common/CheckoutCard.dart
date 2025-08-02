import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil

class CheckoutCard extends GetView {
  final String prefixIcon;
  final String title;
  final String subTitle;
  final String? suffixIcon;
  final Color color;

  const CheckoutCard({
    required this.prefixIcon,
    required this.title,
    required this.subTitle,
    this.color = Colors.black,
    this.suffixIcon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 40.w,  // Responsive width
              height: 40.h,  // Responsive height
              decoration: BoxDecoration(
                color: Color(0xFFF5F7F8),
                shape: BoxShape.circle,
              ),
              child: ClipRRect(
                child: Image.asset(
                  prefixIcon,
                  color: color,
                ),
              ),
            ),
            SizedBox(width: 10.w),  // Responsive spacing
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14.sp,  // Responsive font size
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF020711),
                  ),
                ),
                Text(
                  subTitle,
                  style: TextStyle(
                    fontSize: 12.sp,  // Responsive font size
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF6F7E8D),
                  ),
                ),
              ],
            )
          ],
        ),
        suffixIcon != null
            ? IconButton(
          onPressed: () {},
          icon: Image.asset(suffixIcon!),
        )
            : SizedBox.shrink(),
      ],
    );
  }
}

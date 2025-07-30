import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil

class FilterCard extends GetView {
  final String filterName;
  final bool isSortable;

  const FilterCard({
    required this.filterName,
    this.isSortable = true,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 8.h,
          bottom: 8.h,
          left: 12.w,
          right: 12.w
      ), // Use ScreenUtil for padding
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.r), // Use ScreenUtil for border radius
          color: Colors.white,
          boxShadow: [BoxShadow(blurRadius: 12.r, color: Colors.black.withAlpha(15))]
      ),
      child: Row(
        children: [
          Text(
            filterName,
            style: TextStyle(
                fontSize: 14.sp,  // Use ScreenUtil for font size
                fontWeight: FontWeight.w400,
                color: Color(0xFF6F7E8D)
            ),
          ),
          isSortable ? SizedBox(width: 2.5.w) : SizedBox.shrink(), // Use ScreenUtil for width
          isSortable ? Icon(Icons.keyboard_arrow_down, color: Color(0xFF6F7E8D),) : SizedBox.shrink(),
        ],
      ),
    );
  }
}

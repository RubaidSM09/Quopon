import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quopon/app/modules/home/controllers/home_controller.dart'; // Import ScreenUtil

class FilterCard extends GetView<HomeController> {
  final String filterName;
  final bool isSortable;
  final String filterIcon;

  const FilterCard({
    required this.filterName,
    this.isSortable = true,
    this.filterIcon = '',
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
          filterIcon != '' ? SvgPicture.asset(
            filterIcon
          ) : SizedBox.shrink(),
          filterIcon != '' ? SizedBox(width: 8.w,) : SizedBox.shrink(),
          Text(
            filterName,
            style: TextStyle(
                fontSize: 14.sp,  // Use ScreenUtil for font size
                fontWeight: FontWeight.w400,
                color: Color(0xFF6F7E8D)
            ),
          ),
          isSortable ? SizedBox(width: 12.w) : SizedBox.shrink(), // Use ScreenUtil for width
          isSortable ? Obx(() {
            return controller.deliveryHighToLow.value ? Icon(Icons.keyboard_arrow_down, color: Color(0xFF6F7E8D),) : Icon(Icons.keyboard_arrow_up, color: Color(0xFF6F7E8D),);

          }) : SizedBox.shrink(),
        ],
      ),
    );
  }
}

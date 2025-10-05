import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterCard extends StatelessWidget {
  final String filterName;
  final String iconPath;
  final bool active;
  final VoidCallback? onTap;

  /// Show sort arrow (used for Delivery Fee)
  final bool showSort;
  /// Direction of sort arrow if [showSort] is true
  final bool sortHighToLow;

  const FilterCard({
    super.key,
    required this.filterName,
    required this.iconPath,
    required this.active,
    this.onTap,
    this.showSort = false,
    this.sortHighToLow = true,
  });

  @override
  Widget build(BuildContext context) {
    // Inactive design
    const inactiveTextColor = Color(0xFF6F7E8D);
    const inactiveBgColor = Colors.white;

    // Active = flip colors
    const activeBgColor = inactiveTextColor; // gray bg
    const activeTextColor = Colors.white;    // white text

    final bg = active ? activeBgColor : inactiveBgColor;
    final fg = active ? activeTextColor : inactiveTextColor;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(100.r),
        child: Ink(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(100.r),
            boxShadow: [
              // subtle shadow when inactive; lighter when active
              BoxShadow(
                blurRadius: 12.r,
                color: Colors.black.withAlpha(active ? 8 : 15),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (iconPath.isNotEmpty) ...[
                SvgPicture.asset(
                  iconPath,
                  height: 18.h,
                  // re-color the svg to match text color
                  colorFilter: ColorFilter.mode(fg, BlendMode.srcIn),
                ),
                SizedBox(width: 8.w),
              ],
              Text(
                filterName,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: fg,
                ),
              ),
              if (showSort) ...[
                SizedBox(width: 8.w),
                Icon(
                  sortHighToLow ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
                  size: 20.w,
                  color: fg,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

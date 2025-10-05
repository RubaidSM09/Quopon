import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckoutCard extends StatelessWidget {
  final String prefixIcon;               // asset path
  final String title;
  final String subTitle;
  final String? suffixIcon;              // asset path (optional)
  final Color color;                     // tint for prefix icon (optional)
  final VoidCallback? onTap;             // tap entire row
  final VoidCallback? onSuffixTap;       // tap trailing icon only
  final Widget? trailing;                // custom trailing widget (overrides suffixIcon)
  final int titleMaxLines;
  final int subTitleMaxLines;
  final EdgeInsetsGeometry padding;
  final double spacing;                  // space between icon and text

  const CheckoutCard({
    super.key,
    required this.prefixIcon,
    required this.title,
    required this.subTitle,
    this.color = Colors.black,
    this.suffixIcon,
    this.onTap,
    this.onSuffixTap,
    this.trailing,
    this.titleMaxLines = 1,
    this.subTitleMaxLines = 2,
    EdgeInsetsGeometry? padding,
    this.spacing = 10.0,
  }) : padding = padding ?? const EdgeInsets.symmetric(vertical: 6.0);

  @override
  Widget build(BuildContext context) {
    final content = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Leading circular icon
        Container(
          width: 40.w,
          height: 40.h,
          decoration: const BoxDecoration(
            color: Color(0xFFF5F7F8),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Image.asset(
            prefixIcon,
            width: 22.w,
            height: 22.h,
            color: color,
            fit: BoxFit.contain,
          ),
        ),

        SizedBox(width: spacing.w),

        // Text area (expand to avoid overflow)
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                title,
                maxLines: titleMaxLines,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF020711),
                ),
              ),
              // Subtitle
              if (subTitle.isNotEmpty)
                Text(
                  subTitle,
                  maxLines: subTitleMaxLines,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF6F7E8D),
                  ),
                ),
            ],
          ),
        ),

        // Trailing
        SizedBox(width: 8.w),
        if (trailing != null)
          GestureDetector(
            onTap: onSuffixTap ?? onTap,
            behavior: HitTestBehavior.opaque,
            child: trailing,
          )
        else if (suffixIcon != null)
          IconButton(
            onPressed: onSuffixTap ?? onTap,
            icon: Image.asset(suffixIcon!, width: 24.w, height: 24.h),
            splashRadius: 22.r,
            tooltip: title, // minor a11y
          ),
      ],
    );

    // Full-row tap + ripple
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8.r),
        child: Padding(
          padding: padding,
          child: content,
        ),
      ),
    );
  }
}

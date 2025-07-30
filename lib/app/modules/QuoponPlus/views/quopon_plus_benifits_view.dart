import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

class QuoponPlusBenifitsView extends GetView {
  final String icon;
  final String title;
  final String subTitle;

  const QuoponPlusBenifitsView({
    required this.icon,
    required this.title,
    required this.subTitle,
    super.key
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: Color(0xFFFDF4F4),
          child: Image.asset(icon),
        ),
        SizedBox(width: 10.w,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp),
            ),
            SizedBox(
              width: 297.w,
              child: Text(
                subTitle,
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 10.85.sp, color: Color(0xFF6F7E8D)),
              ),
            ),
          ],
        )
      ],
    );
  }
}

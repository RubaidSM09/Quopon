import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

class SearchHistoryView extends GetView {
  final String title;

  const SearchHistoryView({
    required this.title,
    super.key
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Color(0xFFF0F2F3)),
          bottom: BorderSide(color: Color(0xFFF0F2F3)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Color(0xFF6F7E8D),
              fontSize: 14.sp,
              fontWeight: FontWeight.normal,
            ),
          ),
          GestureDetector(
            onTap: () {

            },
            child: Icon(
              Icons.close,
              size: 16.sp,
              color: Color(0xFF6F7E8D),
            ),
          )
        ],
      ),
    );
  }
}

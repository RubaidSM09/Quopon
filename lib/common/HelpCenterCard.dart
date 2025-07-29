import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';  // Import ScreenUtil

class HelpCenterCard extends GetView {
  final String title;
  final String description;

  const HelpCenterCard({
    required this.title,
    required this.description,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r), // Use ScreenUtil for radius
        color: Colors.white,
        boxShadow: [
          BoxShadow(blurRadius: 16, color: Colors.black.withAlpha(41)),
        ],
      ),
      padding: EdgeInsets.all(16.w), // Use ScreenUtil for padding
      child: Column(
        children: [
          Row(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16.sp, // Use ScreenUtil for font size
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF020711),
                ),
              ),
              SizedBox.shrink()
            ],
          ),
          SizedBox(height: 5.h), // Use ScreenUtil for height
          Text(
            description,
            style: TextStyle(
              fontSize: 14.sp, // Use ScreenUtil for font size
              fontWeight: FontWeight.w400,
              color: Color(0xFF6F7E8D),
            ),
          ),
        ],
      ),
    );
  }
}

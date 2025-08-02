import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil

class NotificationsCardView extends GetView {
  final bool isChecked;
  final String icon;
  final Color iconBg;
  final String title;
  final String time;
  final String description;

  const NotificationsCardView({
    required this.isChecked,
    required this.icon,
    required this.iconBg,
    required this.title,
    required this.time,
    required this.description,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 16.w, left: 16.w, top: 12.h, bottom: 12.h), // ScreenUtil applied
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Color(0xFFF0F2F3)),
          bottom: BorderSide(color: Color(0xFFF0F2F3)),
        ),
        color: isChecked ? Color(0xFFF9FBFC) : Color(0xFFF8F3F4),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: iconBg
            ),
            padding: EdgeInsets.all(8.w), // ScreenUtil applied
            child: Image.asset(icon),
          ),
          SizedBox(width: 10.w), // ScreenUtil applied
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 345.w, // ScreenUtil applied
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Color(0xFF020711)), // ScreenUtil applied
                    ),
                    Row(
                      children: [
                        !isChecked ?
                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFD62828)
                          ),
                          height: 8.h, // ScreenUtil applied
                          width: 8.w, // ScreenUtil applied
                        ) : SizedBox.shrink(),
                        !isChecked ? SizedBox(width: 5.w) : SizedBox.shrink(), // ScreenUtil applied
                        Text(
                          time,
                          style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)), // ScreenUtil applied
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 345.w, // ScreenUtil applied
                child: Text(
                  description,
                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)), // ScreenUtil applied
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:get/get.dart';

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
      padding: EdgeInsets.only(right: 16, left: 16, top: 12, bottom: 12),
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
            padding: EdgeInsets.all(8),
            child: Image.asset(icon),
          ),
          SizedBox(width: 10,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 309,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFF020711)),
                    ),
                    Row(
                      children: [
                        !isChecked ?
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFD62828)
                          ),
                          height: 8,
                          width: 8,
                        ) : SizedBox.shrink(),
                        !isChecked ? SizedBox(width: 5,) : SizedBox.shrink(),
                        Text(
                          time,
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 309,
                child: Text(
                  description,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

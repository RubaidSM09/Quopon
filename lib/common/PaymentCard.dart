import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil

class PaymentCard extends GetView {
  final String logo;
  final String name;
  final bool isSelected;
  final VoidCallback onTap;

  const PaymentCard({
    required this.name,
    required this.logo,
    required this.isSelected,
    required this.onTap,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 40.w, // Apply ScreenUtil to width
                height: 40.h, // Apply ScreenUtil to height
                decoration: BoxDecoration(
                    color: Color(0xFFF5F7F8),
                    shape: BoxShape.circle
                ),
                child: ClipRRect(
                  child: Image.asset(logo),
                ),
              ),
              SizedBox(width: 10.w), // Apply ScreenUtil to width
              Text(
                name,
                style: TextStyle(
                    fontSize: 16.sp, // Apply ScreenUtil to fontSize
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF020711)
                ),
              ),
            ],
          ),
          Radio(
            value: true,
            groupValue: isSelected,
            onChanged: (_) => onTap(),
            activeColor: Color(0xFFD62828),
          ),
        ],
      ),
    );
  }
}

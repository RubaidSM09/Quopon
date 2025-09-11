import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil

class ItemCard extends GetView {
  final String title;
  final double price;
  final int calory;
  final String description;
  final String? image;

  // 🔹 NEW: tell the card whether to load from network or asset
  final bool isNetworkImage;

  const ItemCard({
    required this.title,
    required this.price,
    required this.calory,
    required this.description,
    this.image,
    this.isNetworkImage = false, // default keeps old behavior
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp, // Apply ScreenUtil to fontSize
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF020711),
                  ),
                ),
                SizedBox(height: 5.h), // Apply ScreenUtil to height
                Row(
                  children: [
                    Text(
                      "\$$price",
                      style: TextStyle(
                        fontSize: 12.sp, // Apply ScreenUtil to fontSize
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF020711),
                      ),
                    ),
                    SizedBox(width: 10.w), // Apply ScreenUtil to width
                    CircleAvatar(
                      radius: 2.5.sp, // Apply ScreenUtil to radius
                      backgroundColor: Color(0xFFCAD9E8),
                    ),
                    SizedBox(width: 10.w), // Apply ScreenUtil to width
                    Text(
                      "$calory Cal",
                      style: TextStyle(
                        fontSize: 12.sp, // Apply ScreenUtil to fontSize
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF6F7E8D),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5.h), // Apply ScreenUtil to height
                SizedBox(
                  width: 250.w, // Apply ScreenUtil to width
                  child: Text(
                    description,
                    style: TextStyle(
                      fontSize: 12.sp, // Apply ScreenUtil to fontSize
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF6F7E8D),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.sp), // Apply ScreenUtil to borderRadius
                  child: isNetworkImage
                      ? Image.network(
                    image!,
                    width: 84.w, // Apply ScreenUtil to width
                    height: 84.h, // Apply ScreenUtil to height
                    fit: BoxFit.cover,
                  ) : Image.asset(image!),
                ),
                Positioned(
                  bottom: 5.h, // Apply ScreenUtil to height
                  right: 5.w, // Apply ScreenUtil to width
                  child: CircleAvatar(
                    radius: 16.sp, // Apply ScreenUtil to radius
                    backgroundColor: Color(0x87000000),
                    child: Center(
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
        SizedBox(height: 10.h), // Apply ScreenUtil to height
        Divider(
          color: Color(0xFFEAECED),
          thickness: 1.sp, // Apply ScreenUtil to thickness
        ),
      ],
    );
  }
}

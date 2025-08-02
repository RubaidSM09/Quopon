import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil

class PictureUploadField extends GetView {
  final double width;
  final double height;
  final bool isUploaded;
  final String image;

  const PictureUploadField({
    this.width = 366,
    this.height = 95,
    this.isUploaded = false,
    this.image = 'assets/images/DealPerformance/Shakes.jpg',
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Add onTap action if needed
      },

      child: Container(
        width: width.w, // Use ScreenUtil for width
        height: height.h, // Use ScreenUtil for height
        padding: !this.isUploaded
            ? EdgeInsets.only(
            top: 20.h, bottom: 20.h, left: 70.w, right: 70.w) // Use ScreenUtil for padding
            : EdgeInsets.all(0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r), // Use ScreenUtil for border radius
          color: Color(0xFFF4F6F7),
          border: Border.all(color: Color(0xFFEAECED)),
        ),
        child: !this.isUploaded
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/SupportFAQ/UploadImage.png',
            ),
            Text(
              'Click to upload images here',
              style: TextStyle(
                fontSize: 12.sp, // Use ScreenUtil for font size
                fontWeight: FontWeight.w400,
                color: Color(0xFF6F7E8D),
              ),
            ),
          ],
        )
            : ClipRRect(
          borderRadius: BorderRadius.circular(12.r), // Use ScreenUtil for border radius
          child: Image.asset(
            image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PictureUploadField extends GetView {
  final double width;
  final double height;
  final bool isUploaded;
  final String image;

  const PictureUploadField({
    this.width = 366,
    this.height = 90,
    this.isUploaded = false,
    this.image = 'assets/images/DealPerformance/Shakes.jpg',
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {

      },

      child: Container(
        width: width,
        height: height,
        padding: !this.isUploaded ? EdgeInsets.only(top: 20, bottom: 20, left: 70, right: 70) : EdgeInsets.all(0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Color(0xFFF4F6F7),
          border: Border.all(
            color: Color(0xFFEAECED)
          )
        ),
        child: !this.isUploaded ?
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/SupportFAQ/UploadImage.png',
            ),
            Text(
              'Click to upload images here',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)),
            )
          ],
        ) :
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

}
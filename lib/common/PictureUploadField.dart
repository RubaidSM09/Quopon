import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PictureUploadField extends GetView {
  const PictureUploadField({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {

      },

      child: Container(
        padding: EdgeInsets.only(top: 20, bottom: 20, left: 70, right: 70),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Color(0xFFF4F6F7),
          border: Border.all(
            color: Color(0xFFEAECED)
          )
        ),
        child: Column(
          children: [
            Image.asset(
              'assets/images/SupportFAQ/UploadImage.png',
            ),
            Text(
              'Click to upload images here',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)),
            )
          ],
        ),
      ),
    );
  }

}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil

import '../app/modules/Profile/controllers/profile_controller.dart';

class EditProfileField extends GetView<ProfileController> {
  final String label;
  final String defaultText;
  final String hintText;

  const EditProfileField({
    super.key,
    required this.label,
    required this.defaultText,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp), // Use ScreenUtil for font size
            ),
            SizedBox(),
          ],
        ),
        SizedBox(height: 8.h), // Use ScreenUtil for spacing
        TextField(
          controller: TextEditingController(text: defaultText),  // Default text in the field
          style: TextStyle(
            fontSize: 14.sp, // Use ScreenUtil for font size
            fontWeight: FontWeight.w400,
            color: Color(0xFF6F7E8D),
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: Color(0xFFF4F6F7),
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r), // Use ScreenUtil for border radius
              borderSide: const BorderSide(width: 1, color: Color(0xFFEAECED)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r), // Use ScreenUtil for border radius
              borderSide: const BorderSide(width: 1, color: Color(0xFFEAECED)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r), // Use ScreenUtil for border radius
              borderSide: const BorderSide(width: 1, color: Color(0xFFEAECED)),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w), // Use ScreenUtil for content padding
          ),
        ),
        SizedBox(height: 20.h), // Use ScreenUtil for spacing
      ],
    );
  }
}

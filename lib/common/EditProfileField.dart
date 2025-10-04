// common/EditProfileField.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfileField extends StatelessWidget {
  final String label;
  final String defaultText;
  final String hintText;
  final TextEditingController editProfileController;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final int maxLines;

  const EditProfileField({
    super.key,
    required this.label,
    required this.defaultText,
    required this.hintText,
    required this.editProfileController,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    // hydrate once if empty
    if (editProfileController.text.isEmpty && defaultText.isNotEmpty) {
      editProfileController.text = defaultText;
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp),
            ),
            const SizedBox(),
          ],
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: editProfileController,
          validator: validator,
          keyboardType: keyboardType,
          maxLines: maxLines,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF6F7E8D),
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFF4F6F7),
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(width: 1, color: Color(0xFFEAECED)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(width: 1, color: Color(0xFFEAECED)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(width: 1, color: Color(0xFFEAECED)),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
          ),
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}

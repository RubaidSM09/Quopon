import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../app/modules/vendor_create_deal/controllers/vendor_create_deal_controller.dart';

class CustomTextField extends StatefulWidget {
  final String headingText;
  final String fieldText;
  final String iconImagePath;
  final TextEditingController controller;
  final bool isPassword;
  final bool isRequired;

  const CustomTextField({
    super.key,
    required this.headingText,
    required this.fieldText,
    required this.iconImagePath,
    required this.controller,
    required this.isRequired,
    this.isPassword = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _isPasswordVisible;

  @override
  void initState() {
    super.initState();
    _isPasswordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              widget.headingText,
              style: TextStyle(
                fontSize: 14.sp,  // Use ScreenUtil for font size
                fontWeight: FontWeight.w500,
                color: Color(0xFF020711),
              ),
            ),
            widget.isRequired
                ? Text(
              '*',
              style: TextStyle(
                fontSize: 14.sp,  // Use ScreenUtil for font size
                fontWeight: FontWeight.w500,
                color: Color(0xFFD62828),
              ),
            )
                : Text(
              ' (Optional)',
              style: TextStyle(
                fontSize: 14.sp,  // Use ScreenUtil for font size
                fontWeight: FontWeight.w400,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),  // Use ScreenUtil for height spacing
        Container(
          decoration: BoxDecoration(
            color: Color(0xFFF4F6F7),
            borderRadius: BorderRadius.circular(12.r),  // Use ScreenUtil for radius
            border: Border.all(color: Color(0xFFEAECED)),
          ),
          child: TextField(
            controller: widget.controller,
            obscureText: widget.isPassword && !_isPasswordVisible,
            decoration: InputDecoration(
              filled: true,
              fillColor: Color(0xFFF4F6F7),
              hintText: widget.isPassword ? '••••••••••••' : widget.fieldText,
              hintStyle: TextStyle(color: Color(0xFF8F9EAD), fontWeight: FontWeight.w400, fontSize: 14.sp),
              prefixIcon: widget.iconImagePath != ''
                  ? Padding(
                padding: EdgeInsets.all(8.w),  // Use ScreenUtil for padding
                child: Image.asset(
                  widget.iconImagePath,
                  width: 24.w,  // Use ScreenUtil for width
                  height: 24.h,  // Use ScreenUtil for height
                ),
              )
                  : null,
              suffixIcon: widget.isPassword
                  ? IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey[500],
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              )
                  : null,
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),  // Use ScreenUtil for padding
            ),
          ),
        ),
      ],
    );
  }
}

class GetInTouchTextField extends StatelessWidget {
  final String headingText;
  final double headingTextSize;
  final String fieldText;
  final String iconImagePath;
  final int maxLine;
  final TextEditingController controller;
  final bool isPassword;
  final bool isRequired;
  final bool isOptional;

  // added previously
  final bool readOnly;
  final Widget? suffix;
  final VoidCallback? onTap;

  GetInTouchTextField({
    super.key,
    required this.headingText,
    this.headingTextSize = 16,
    required this.fieldText,
    required this.iconImagePath,
    required this.controller,
    required this.isRequired,
    this.isOptional = false,
    this.maxLine = 1,
    this.isPassword = false,
    this.readOnly = false,
    this.suffix,
    this.onTap,
  });

  // local reactive state for password eye
  final RxBool _isPasswordVisible = false.obs;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // header row (unchanged) ...
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF4F6F7),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: const Color(0xFFEAECED)),
          ),
          child: isPassword
          // ✅ Reactive only when password field
              ? Obx(() {
            final obscured = !_isPasswordVisible.value;
            return TextField(
              maxLines: maxLine,
              controller: controller,
              readOnly: readOnly,
              onTap: onTap,
              obscureText: obscured,
              decoration: InputDecoration(
                hintText: '••••••••••••',
                hintStyle: TextStyle(color: const Color(0xFF8F9EAD), fontWeight: FontWeight.w400, fontSize: 14.sp),
                prefixIcon: iconImagePath.isNotEmpty
                    ? Padding(
                  padding: EdgeInsets.all(8.w),
                  child: Image.asset(iconImagePath, width: 24.w, height: 24.h),
                )
                    : null,
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible.value ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey[500],
                  ),
                  onPressed: () => _isPasswordVisible.toggle(),
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                filled: true,
                fillColor: const Color(0xFFF4F6F7),
              ),
            );
          })
              : TextField(
            maxLines: maxLine,
            controller: controller,
            readOnly: readOnly,
            onTap: onTap,
            decoration: InputDecoration(
              hintText: fieldText,
              hintStyle: TextStyle(color: const Color(0xFF8F9EAD), fontWeight: FontWeight.w400, fontSize: 14.sp),
              prefixIcon: iconImagePath.isNotEmpty
                  ? Padding(
                padding: EdgeInsets.all(8.w),
                child: Image.asset(iconImagePath, width: 24.w, height: 24.h),
              )
                  : null,
              suffixIcon: suffix, // spinner / custom suffix
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              filled: true,
              fillColor: const Color(0xFFF4F6F7),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomCategoryField extends GetView {
  final String fieldName;
  final bool isRequired;
  final String selectedCategory;
  final List<String> categories;

  /// 🔹 New: callback to notify parent about selection change
  final ValueChanged<String>? onCategorySelected;

  const CustomCategoryField({
    required this.fieldName,
    required this.isRequired,
    this.selectedCategory = 'Select',
    this.categories = const ['Select'],
    this.onCategorySelected, // 🔹 new (optional)
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              fieldName,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            isRequired
                ? Text(
              '*',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFFD62828),
              ),
            )
                : const SizedBox.shrink(),
          ],
        ),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: const Color(0xFFEAECED)),
          ),
          child: DropdownButton<String>(
            value: selectedCategory,
            isExpanded: true,
            underline: Container(),
            items: categories.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                    color: const Color(0xFF6F7E8D),
                  ),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              if (newValue == null) return;
              // 🔹 Let the parent handle state & id mapping
              onCategorySelected?.call(newValue);
            },
          ),
        ),
      ],
    );
  }
}

class CustomDateFied extends GetView<VendorCreateDealController> {
  final String heading;
  final bool isRequired;
  final String date;

  final RxString startDate;

  CustomDateFied({
    required this.heading,
    required this.isRequired,
    this.date = '',
    super.key,
  }) : startDate = date.obs;

  Future<void> _selectStartDate(BuildContext context) async {
    DateTime initialDate = DateTime.now();
    DateTime firstDate = DateTime(1900);
    DateTime lastDate = DateTime(2100);

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (pickedDate != null) {
      startDate.value = DateFormat('yyyy-MM-dd').format(pickedDate); // Format the date as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              heading,
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: Color(0xFF020711)),
            ),
            isRequired
                ? Text(
              '*',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: Color(0xFFD62828)),
            )
                : SizedBox.shrink(),
          ],
        ),
        SizedBox(height: 5.h),
        Obx(() {
          return GestureDetector(
            onTap: () => _selectStartDate(context),
            child: Container(
              width: 183.w,  // Use ScreenUtil for width
              padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 14.h, bottom: 14.h),  // Use ScreenUtil for padding
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),  // Use ScreenUtil for radius
                  border: Border.all(color: Color(0xFFEAECED))
              ),
              child: Row(
                children: [
                  Text(
                    startDate.value.isEmpty ? 'Select Date' : startDate.value,
                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)),
                  ),
                  SizedBox(width: 10.w),
                  Image.asset('assets/images/CreateDeals/Calender.png')
                ],
              ),
            ),
          );
        })
      ],
    );
  }
}

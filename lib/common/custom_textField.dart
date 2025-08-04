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

class GetInTouchTextField extends StatefulWidget {
  final String headingText;
  final String fieldText;
  final String iconImagePath;
  final int maxLine;
  final TextEditingController controller;
  final bool isPassword;
  final bool isRequired;

  const GetInTouchTextField({
    super.key,
    required this.headingText,
    required this.fieldText,
    required this.iconImagePath,
    required this.controller,
    required this.isRequired,
    this.maxLine = 1,
    this.isPassword = false,
  });

  @override
  State<GetInTouchTextField> createState() => _GetInTouchTextFieldState();
}

class _GetInTouchTextFieldState extends State<GetInTouchTextField> {
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
                fontSize: 16.sp,  // Use ScreenUtil for font size
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            widget.isRequired
                ? Text(
              '*',
              style: TextStyle(
                fontSize: 16.sp,  // Use ScreenUtil for font size
                fontWeight: FontWeight.w500,
                color: Colors.red,
              ),
            )
                : SizedBox.shrink(),
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
            maxLines: widget.maxLine,
            controller: widget.controller,
            obscureText: widget.isPassword && !_isPasswordVisible,
            decoration: InputDecoration(
              hintText: widget.isPassword ? '••••••••••••' : widget.fieldText,
              hintStyle: TextStyle(
                color: Color(0xFF8F9EAD),
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
              ),
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

class CustomCategoryField extends GetView {
  final String fieldName;
  final bool isRequired;
  final String selectedCategory;
  final List<String> categories;

  const CustomCategoryField({
    required this.fieldName,
    required this.isRequired,
    this.selectedCategory = 'Select',
    this.categories = const ['Select'],
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
                fontSize: 16.sp,  // Use ScreenUtil for font size
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            isRequired
                ? Text(
              '*',
              style: TextStyle(
                fontSize: 16.sp,  // Use ScreenUtil for font size
                fontWeight: FontWeight.w500,
                color: Color(0xFFD62828),
              ),
            )
                : SizedBox.shrink(),
          ],
        ),
        SizedBox(height: 8.h),  // Use ScreenUtil for height spacing
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),  // Use ScreenUtil for padding
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),  // Use ScreenUtil for radius
            border: Border.all(color: Color(0xFFEAECED))
          ),
          child: DropdownButton<String>(
            value: selectedCategory,
            isExpanded: true,
            underline: Container(),
            items: categories
                .map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp, color: Color(0xFF6F7E8D)),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              // setState(() {
              //   selectedLanguage = newValue!;
              // });
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

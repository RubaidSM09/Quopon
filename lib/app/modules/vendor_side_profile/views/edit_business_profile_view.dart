import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';  // Import ScreenUtil

import 'package:quopon/app/modules/vendor_side_profile/views/vendor_side_profile_view.dart';
import '../../../../common/ChooseField.dart';
import '../../../../common/EditProfileField.dart';
import '../../../../common/customTextButton.dart';
import '../../../../common/custom_textField.dart';
import '../../signUpProcess/views/vendor_business_hour_row_view.dart';

class EditBusinessProfileView extends GetView {
  const EditBusinessProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9FBFC),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.w),  // Use ScreenUtil for padding
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(height: 20.h),  // Use ScreenUtil for spacing
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(Icons.arrow_back),
                      ),
                      Text(
                        "Edit Business Profile",
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp),  // Use ScreenUtil for font size
                      ),
                      SizedBox(),
                    ],
                  )
                ],
              ),
              Column(
                children: [
                  CircleAvatar(
                    radius: 40.r,  // Use ScreenUtil for radius
                    backgroundImage: AssetImage("assets/images/deals/details/Starbucks_Logo.png"),
                    child: Container(
                      width: 80.w,
                      height: 80.h,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black.withAlpha(100)
                      ),
                      child: Image.asset(
                        "assets/images/Profile/Upload.png",
                        height: 32.h,
                        width: 32.w,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),  // Use ScreenUtil for spacing
                  Text(
                    "Upload Logo",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp),
                  ),
                ],
              ),
              Column(
                children: [
                  EditProfileField(label: 'Name', defaultText: 'Starbucks', hintText: 'Enter Name',),
                  EditProfileField(label: 'Email Address', defaultText: 'starbucks@email.com', hintText: 'Enter Email',),
                  EditProfileField(label: 'Phone Number', defaultText: '01234567890', hintText: 'Enter Phone Number',),
                  EditProfileField(label: 'Address', defaultText: 'Starbucks, 9737 Destiny USA Dr, Syracuse, NY 13290, USA', hintText: 'Enter Address',),
                  CustomCategoryField(fieldName: 'Category', isRequired: false, selectedCategory: 'Food & Beverage', categories: ['Food & Beverage'],),
                  SizedBox(height: 20.h),  // Use ScreenUtil for spacing

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Business Hours',
                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: Color(0xFF020711)),
                      ),
                      SizedBox.shrink()
                    ],
                  ),
                  SizedBox(height: 8.h),
                  VendorBusinessHourRowView(
                    isActive: true,
                    day: 'Mon',
                    startTime: '12:00 AM',
                    endTime: '12:00 AM',
                  ),
                  SizedBox(height: 15.h),
                  VendorBusinessHourRowView(
                    isActive: true,
                    day: 'Tue',
                    startTime: '12:00 AM',
                    endTime: '12:00 AM',
                  ),
                  SizedBox(height: 15.h),
                  VendorBusinessHourRowView(
                    isActive: true,
                    day: 'Wed',
                    startTime: '12:00 AM',
                    endTime: '12:00 AM',
                  ),
                  SizedBox(height: 15.h),
                  VendorBusinessHourRowView(
                    isActive: true,
                    day: 'Thu',
                    startTime: '12:00 AM',
                    endTime: '12:00 AM',
                  ),
                  SizedBox(height: 15.h),
                  VendorBusinessHourRowView(
                    isActive: true,
                    day: 'Fri',
                    startTime: '12:00 AM',
                    endTime: '12:00 AM',
                  ),
                  SizedBox(height: 15.h),
                  VendorBusinessHourRowView(
                    isActive: false,
                    day: 'Sat',
                    startTime: '12:00 AM',
                    endTime: '12:00 AM',
                  ),
                  SizedBox(height: 15.h),
                  VendorBusinessHourRowView(
                    isActive: false,
                    day: 'Sun',
                    startTime: '12:00 AM',
                    endTime: '12:00 AM',
                  ),

                  SizedBox(height: 20.h),  // Use ScreenUtil for spacing
                ],
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: Container(
        padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h, bottom: 32.h),  // Use ScreenUtil for padding
        height: 106.h,  // Use ScreenUtil for height
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 16)]
        ),
        child:
        GradientButton(
          text: 'Save Changes',
          onPressed: () {
            Get.to(VendorSideProfileView());
          },
          colors: [Color(0xFFD62828), Color(0xFFC21414)],
        ),
      ),
    );
  }
}

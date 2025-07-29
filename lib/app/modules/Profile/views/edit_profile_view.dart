import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil
import 'package:quopon/app/modules/Profile/views/profile_view.dart';
import 'package:quopon/common/ChooseField.dart';
import 'package:quopon/common/EditProfileField.dart';
import 'package:quopon/common/customTextButton.dart';

class EditProfileView extends GetView {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9FBFC),
      body: Padding(
        padding: EdgeInsets.all(16.w), // Use ScreenUtil for padding
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(height: 20.h), // Use ScreenUtil for spacing
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
                      "Edit Profile",
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp), // Use ScreenUtil for font size
                    ),
                    SizedBox(),
                  ],
                )
              ],
            ),
            Column(
              children: [
                CircleAvatar(
                  radius: 40.r, // Use ScreenUtil for radius
                  backgroundImage: AssetImage("assets/images/Profile/ProfilePic.jpg"),
                  child: Container(
                    width: 80.w, // Use ScreenUtil for width
                    height: 80.h, // Use ScreenUtil for height
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black.withAlpha(100),
                    ),
                    child: Image.asset(
                      "assets/images/Profile/Upload.png",
                      height: 32.h, // Use ScreenUtil for height
                      width: 32.w,  // Use ScreenUtil for width
                    ),
                  ),
                ),
                SizedBox(height: 10.h), // Use ScreenUtil for spacing
                Text(
                  "Upload Profile Picture",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp), // Use ScreenUtil for font size
                ),
              ],
            ),
            Column(
              children: [
                EditProfileField(label: 'Full Name', defaultText: 'Tanjiro Kamado', hintText: 'Enter Full Name',),
                EditProfileField(label: 'Email Address', defaultText: 'tanjirokamado@email.com', hintText: 'Enter Email',),
                EditProfileField(label: 'Phone Number', defaultText: '01234567890', hintText: 'Enter Phone Number',),
                ChooseCountryField(),
                ChooseCityField(),
                EditProfileField(label: 'Address', defaultText: 'Starbucks, 9737 Destiny USA Dr, Syracuse, NY 13290, USA', hintText: 'Enter Address',),
              ],
            ),
            GradientButton(
              text: 'Save Changes',
              onPressed: () {
                Get.to(ProfileView());
              },
              colors: [const Color(0xFFD62828), const Color(0xFFC21414)],
              boxShadow: [const BoxShadow(color: Color(0xFF9A0000), spreadRadius: 1)],
              child: Text(
                'Save Changes',
                style: TextStyle(
                  fontSize: 16.sp,  // Use ScreenUtil for font size
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox()
          ],
        ),
      ),
    );
  }
}

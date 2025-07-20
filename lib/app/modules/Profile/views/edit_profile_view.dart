import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quopon/common/ChooseField.dart';
import 'package:quopon/common/EditProfileField.dart';
import 'package:quopon/common/red_button.dart';

class EditProfileView extends GetView {
  const EditProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9FBFC),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(height: 20),
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
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    SizedBox(),
                  ],
                )
              ],
            ),
            Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage("assets/images/Profile/ProfilePic.jpg"),
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black.withAlpha(100)
                    ),
                    child: Image.asset(
                      "assets/images/Profile/Upload.png",
                      height: 32,
                      width: 32,
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Text(
                  "Upload Profile Picture",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
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
            RedButton(buttonText: "Save Changes", onPressed: () { }),
            SizedBox()
          ],
        ),
      ),
    );
  }
}

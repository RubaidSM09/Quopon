import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../common/profileCard.dart';

class SettingsView extends GetView {
  const SettingsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9FBFC),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
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
                      "Settings",
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    SizedBox(),
                  ],
                )
              ],
            ),
            SizedBox(height: 20,),
            Container(
              height: 278,
              width: 398,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Edit Profile card with Get.to() for navigation
                    GestureDetector(
                      onTap: () {
                        // Get.to(() => EditProfileView());
                      },
                      child: ProfileCard(icon: 'assets/images/Profile/Settings/Language.png', title: 'Language'),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Get.to(() => SettingsView());
                      },
                      child: ProfileCard(icon: 'assets/images/Profile/Settings/PrivacyPolicy.png', title: 'Privacy Policy'),
                    ),
                    ProfileCard(icon: 'assets/images/Profile/Settings/Notifications.png', title: 'Notifications'),
                    ProfileCard(icon: 'assets/images/Profile/Settings/ChangePassword.png', title: 'Change Password'),
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}

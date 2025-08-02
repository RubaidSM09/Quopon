import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:quopon/app/modules/VendorProfile/views/vendor_profile_view.dart';

class FollowersCard extends GetView {
  final String followersProfilePic;
  final String followerName;
  final int redeemedDeals;
  final int pushOpens;

  const FollowersCard({
    required this.followersProfilePic,
    required this.followerName,
    required this.redeemedDeals,
    required this.pushOpens,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10.h), // Adjust the spacing using ScreenUtil
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 21.w, // Use ScreenUtil for radius
                  backgroundImage: AssetImage(followersProfilePic),
                ),
                SizedBox(
                  width: 10.w, // Adjust the width using ScreenUtil
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      followerName,
                      style: TextStyle(
                        fontSize: 16.sp, // Use ScreenUtil for font size
                        color: Color(0xFF020711),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "Deals Redeemed: $redeemedDeals",
                          style: TextStyle(
                            fontSize: 12.sp, // Use ScreenUtil for font size
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF6F7E8D),
                          ),
                        ),
                        SizedBox(width: 8.w), // Adjust the width using ScreenUtil
                        Container(
                          height: 5.h, // Adjust height using ScreenUtil
                          width: 5.w, // Adjust width using ScreenUtil
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF6F7E8D)
                          ),
                        ),
                        SizedBox(width: 8.w), // Adjust the width using ScreenUtil
                        Text(
                          pushOpens < 10 ? "Push Opens: $pushOpens/10" : "Push Opens: 10/10",
                          style: TextStyle(
                            fontSize: 12.sp, // Use ScreenUtil for font size
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF6F7E8D),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox.shrink()
          ],
        ),
        SizedBox(height: 5.h), // Adjust the height using ScreenUtil
        Divider(
          color: Color(0xFFF0F2F3),
          thickness: 2,
        ),
      ],
    );
  }
}

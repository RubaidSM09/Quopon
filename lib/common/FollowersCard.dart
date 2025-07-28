import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
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
        SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 21,
                  backgroundImage: AssetImage(followersProfilePic,),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      followerName,
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF020711),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "Deals Redeemed: $redeemedDeals",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF6F7E8D),
                          ),
                        ),
                        SizedBox(width: 8,),
                        Container(
                          height: 5,
                          width: 5,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF6F7E8D)
                          ),
                        ),
                        SizedBox(width: 8,),
                        Text(
                          pushOpens < 10 ? "Push Opens: $pushOpens/10" : "Push Opens: 10/10",
                          style: TextStyle(
                            fontSize: 12,
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
        SizedBox(height: 5,),
        Divider(
          color: Color(0xFFF0F2F3),
          thickness: 2,
        ),
      ],
    );
  }

}
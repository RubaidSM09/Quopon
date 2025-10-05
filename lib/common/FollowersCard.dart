import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FollowersCard extends StatelessWidget {
  final String followersProfilePic;
  final String followerName;
  final int redeemedDeals;
  final int pushOpens;

  const FollowersCard({
    required this.followersProfilePic,
    required this.followerName,
    required this.redeemedDeals,
    required this.pushOpens,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isNetwork = followersProfilePic.startsWith('http');

    return Column(
      children: [
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 21.w,
                  backgroundImage: isNetwork
                      ? NetworkImage(followersProfilePic)
                      : AssetImage(followersProfilePic) as ImageProvider,
                ),
                SizedBox(width: 10.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      followerName,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: const Color(0xFF020711),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "Deals Redeemed: $redeemedDeals",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF6F7E8D),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Container(
                          height: 5.h,
                          width: 5.w,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF6F7E8D),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          pushOpens < 10
                              ? "Push Opens: $pushOpens/10"
                              : "Push Opens: 10/10",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF6F7E8D),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox.shrink(),
          ],
        ),
        SizedBox(height: 5.h),
        const Divider(
          color: Color(0xFFF0F2F3),
          thickness: 2,
        ),
      ],
    );
  }
}

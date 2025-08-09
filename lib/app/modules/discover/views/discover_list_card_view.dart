import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

class DiscoverListCardView extends GetView {
  final String title;
  final String image;
  final double rating;
  final int review;
  final double distance;
  final String offer;

  const DiscoverListCardView({
    required this.title,
    required this.image,
    required this.rating,
    required this.review,
    required this.distance,
    required this.offer,
    super.key
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(8.w, 8.h, 12.w, 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 16.r)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            image,
            height: 88.h,
            width: 88.w,
            scale: 4,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Color(0xFF020711),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),

              SizedBox(height: 6.h,),

              Row(
                children: [
                  Icon(
                    Icons.star_rounded,
                    color: Color(0xFFFFA81C),
                    size: 14.sp,
                  ),
                  SizedBox(width: 4.w,),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '$rating ',
                          style: TextStyle(
                            color: Color(0xFF020711),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.normal,
                          )
                        ),
                        TextSpan(
                            text: review > 500 ? '(500+)' : '($rating)',
                            style: TextStyle(
                              color: Color(0xFF6F7E8D),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.normal,
                            )
                        ),
                      ]
                    ),
                  ),
                  SizedBox(width: 8.w,),
                  Container(
                    height: 5.h,
                    width: 5.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFCAD9E8),
                    ),
                  ),
                  SizedBox(width: 8.w,),
                  Text(
                    '$distance km',
                    style: TextStyle(
                      color: Color(0xFF6F7E8D),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(width: 8.w,),
                  Container(
                    height: 5.h,
                    width: 5.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFCAD9E8),
                    ),
                  ),
                  SizedBox(width: 8.w,),
                  SizedBox(
                    width: 122.w,
                    child: Text(
                      'Vegan, Gezond Pizza...',
                      style: TextStyle(
                        color: Color(0xFF6F7E8D),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.normal,
                        overflow: TextOverflow.ellipsis
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 12.h,),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.r),
                  color: Color(0xFFD62828),
                ),
                child: Text(
                  offer,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.normal,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

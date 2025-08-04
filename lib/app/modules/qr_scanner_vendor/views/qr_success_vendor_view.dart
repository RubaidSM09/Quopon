import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../../common/customTextButton.dart';
import '../../dealDetail/views/deal_detail_view.dart';

class QrSuccessVendorView extends GetView {
  final String dealTitle;
  final String dealStoreName;
  final String brandLogo;
  final String time;

  const QrSuccessVendorView({
    super.key,
    required this.dealTitle,
    required this.dealStoreName,
    required this.brandLogo,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black.withOpacity(0.0),
      child: Container(
        padding: EdgeInsets.all(16.w), // Use ScreenUtil for padding
        decoration: BoxDecoration(
          color: Color(0xFFF9FBFC),
          borderRadius: BorderRadius.circular(16.r), // Use ScreenUtil for border radius
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8.r,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/QR/confetti 1.png'),
              SizedBox(height: 20.h),
              Text('Order Verified Successfully', textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF020711), fontSize: 20.sp, fontWeight: FontWeight.w500),), // Use ScreenUtil for font size
              SizedBox(height: 10.h),
              Text('The deal has been redeemed and the order is confirmed. You may now proceed with handing over the items.', textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF6F7E8D), fontSize: 16.sp, fontWeight: FontWeight.normal),), // Use ScreenUtil for font size
              SizedBox(height: 24.h),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r), // Use ScreenUtil for radius
                    color: Colors.white,
                    boxShadow: [BoxShadow(color: Colors.black.withAlpha(26), blurRadius: 20.r)],
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.w), // Use ScreenUtil for padding
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 118.w,
                            child: Text(
                              'Invoice Number',
                              style: TextStyle(color: Color(0xFF6F7E8D), fontSize: 14.sp),
                            ),
                          ),
                          SizedBox(width: 16.w,),
                          SizedBox(
                            width: 4.w,
                            child: Text(
                              ':',
                              style: TextStyle(color: Color(0xFF020711), fontSize: 14.sp),
                            ),
                          ),
                          SizedBox(width: 16.w,),
                          SizedBox(
                            width: 124.w,
                            child: Text(
                              'S564 F5677 G6412',
                              style: TextStyle(color: Color(0xFF020711), fontSize: 14.sp),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 16.h,),

                      Row(
                        children: [
                          SizedBox(
                            width: 118.w,
                            child: Text(
                              'Customer Name',
                              style: TextStyle(color: Color(0xFF6F7E8D), fontSize: 14.sp),
                            ),
                          ),
                          SizedBox(width: 16.w,),
                          SizedBox(
                            width: 4.w,
                            child: Text(
                              ':',
                              style: TextStyle(color: Color(0xFF020711), fontSize: 14.sp),
                            ),
                          ),
                          SizedBox(width: 16.w,),
                          SizedBox(
                            width: 124.w,
                            child: Text(
                              'Mubashir Saleem',
                              style: TextStyle(color: Color(0xFF020711), fontSize: 14.sp),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 16.h,),

                      Row(
                        children: [
                          SizedBox(
                            width: 118.w,
                            child: Text(
                              'Deal',
                              style: TextStyle(color: Color(0xFF6F7E8D), fontSize: 14.sp),
                            ),
                          ),
                          SizedBox(width: 16.w,),
                          SizedBox(
                            width: 4.w,
                            child: Text(
                              ':',
                              style: TextStyle(color: Color(0xFF020711), fontSize: 14.sp),
                            ),
                          ),
                          SizedBox(width: 16.w,),
                          SizedBox(
                            width: 124.w,
                            child: Text(
                              '50% OFF Any Grande Beverage',
                              style: TextStyle(color: Color(0xFF020711), fontSize: 14.sp),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 16.h,),

                      Row(
                        children: [
                          SizedBox(
                            width: 118.w,
                            child: Text(
                              'Timestamp',
                              style: TextStyle(color: Color(0xFF6F7E8D), fontSize: 14.sp),
                            ),
                          ),
                          SizedBox(width: 16.w,),
                          SizedBox(
                            width: 4.w,
                            child: Text(
                              ':',
                              style: TextStyle(color: Color(0xFF020711), fontSize: 14.sp),
                            ),
                          ),
                          SizedBox(width: 16.w,),
                          SizedBox(
                            width: 124.w,
                            child: Text(
                              'Verified at 2:42 PM',
                              style: TextStyle(color: Color(0xFF020711), fontSize: 14.sp),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 32.h),
              GradientButton(
                text: 'Done',
                onPressed: () {
                  Get.back();
                },
                colors: [const Color(0xFFD62828), const Color(0xFFC21414)],
                boxShadow: [const BoxShadow(color: Color(0xFF9A0000), spreadRadius: 1)],
                child: Text(
                  'Done',
                  style: TextStyle(
                    fontSize: 16.sp,  // Use ScreenUtil for font size
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

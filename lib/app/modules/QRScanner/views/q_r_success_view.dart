import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:quopon/app/modules/dealDetail/views/deal_detail_view.dart';

import '../../../../common/customTextButton.dart'; // Import ScreenUtil

class QRSuccessView extends StatelessWidget {
  final String dealTitle;
  final String dealStoreName;
  final String brandLogo;
  final String time;

  const QRSuccessView({
    super.key,
    required this.dealTitle,
    required this.dealStoreName,
    required this.brandLogo,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);  // Close the detail view on tapping outside
      },
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.0),
        body: Center(
          child: GestureDetector(
            onTap: () {}, // Prevent dismiss on card tap
            child: Container(
              width: 398.w, // Use ScreenUtil for width
              height: 451.h, // Use ScreenUtil for height
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/images/QR/confetti 1.png'),
                  SizedBox(height: 20.h),
                  Text('Congratulations! Deal Redeemed', textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF020711), fontSize: 18.sp, fontWeight: FontWeight.w500),), // Use ScreenUtil for font size
                  SizedBox(height: 10.h),
                  Text('You\'ve successfully redeemed the deal at $dealStoreName', textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF020711), fontSize: 14.sp, fontWeight: FontWeight.w400),), // Use ScreenUtil for font size
                  SizedBox(height: 20.h),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r), // Use ScreenUtil for radius
                        color: Colors.white
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8.w), // Use ScreenUtil for padding
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: Image.asset(brandLogo, ),
                              ),
                              SizedBox(width: 10.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    dealTitle,
                                    style: TextStyle(
                                      fontSize: 14.sp, // Use ScreenUtil for font size
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Redeemed at ',
                                        style: TextStyle(
                                          fontSize: 12.sp, // Use ScreenUtil for font size
                                          color: Colors.grey[500],
                                        ),
                                      ),
                                      Icon(Icons.circle, color: Colors.grey[300], size: 12.sp,),
                                      Text(
                                        ' $time',
                                        style: TextStyle(
                                          fontSize: 12.sp, // Use ScreenUtil for font size
                                          color: Colors.grey[500],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h),
                          Container(
                            height: 40.h, // Use ScreenUtil for height
                            width: 334.w, // Use ScreenUtil for width
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r), // Use ScreenUtil for radius
                                color: Color(0xFFECFDF5)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.check, color: Color(0xFF2ECC71), size: 16.sp,), // Use ScreenUtil for size
                                SizedBox(width: 5.w),
                                Text('Verified Redemption', style: TextStyle(color: Color(0xFF2ECC71), fontSize: 14.sp, fontWeight: FontWeight.w400),) // Use ScreenUtil for font size
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  GradientButton(
                    text: 'Done',
                    onPressed: () {
                      Get.back();
                      /*Get.dialog(DealDetailView(
                        dealImage: 'assets/images/deals/Pizza.jpg',
                        dealTitle: dealTitle,
                        dealDescription: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s.',
                        dealValidity: '11:59 PM, May 31',
                        dealStoreName: dealStoreName,
                        brandLogo: brandLogo,
                      )
                      );*/
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
        ),
      ),
    );
  }
}

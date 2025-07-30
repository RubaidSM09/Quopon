import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:quopon/app/modules/ChooseRedemptionDeal/views/choose_redemption_deal_view.dart';
import 'package:quopon/common/red_button.dart';

import '../../../../common/customTextButton.dart';
import '../../home/views/home_view.dart';

class DealDetailView extends StatelessWidget {
  final String dealImage;
  final String dealTitle;
  final String dealDescription;
  final String dealValidity;
  final String dealStoreName;
  final String brandLogo;

  const DealDetailView({
    super.key,
    required this.dealImage,
    required this.dealTitle,
    required this.dealDescription,
    required this.dealValidity,
    required this.dealStoreName,
    required this.brandLogo,
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
              padding: EdgeInsets.only(left: 8.w, right: 8.w, top: 8.h, bottom: 20.h),
              decoration: BoxDecoration(
                color: Color(0xFFF9FBFC),
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Close button (top-right)
                    Stack(
                      children: [
                        // Deal Image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12.r),
                          child: Image.asset(
                            dealImage, // Image of the deal
                            width: double.infinity,
                            height: 220.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                
                        Positioned(
                          top: 12.h,
                          right: 12.w,
                          child: GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              height: 36.h,
                              width: 36.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black.withAlpha(128),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 20.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]
                    ),
                
                    SizedBox(height: 12.h),
                
                    // Deal Title
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            dealTitle,
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 8.h),
                
                          // Deal Description
                          Text(
                            dealDescription,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: 12.h),
                
                          // Deal Store Name and Validity
                          Container(
                            color: Colors.white,
                            height: 76.h,
                            width: 366.w,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: Image.asset(brandLogo, height: 44.h, width: 44.w,),
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            dealStoreName,
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Valid Until: ',
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xFFD62828),
                                                ),
                                              ),
                                              Text(
                                                dealValidity,
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.grey[500],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width: 63.w,
                                    height: 22.h,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        color: Color(0xFFD62828)
                                    ),
                                    child: Center(
                                      child: Text(
                                        '50% OFF',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.sp
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // SizedBox(height: 6),
                
                    // Activate Deal Button
                    GradientButton(
                      text: 'Activate Deal',
                      onPressed: () {
                        Get.dialog(
                            Dialog(
                                backgroundColor: Colors.transparent,
                                child: ChooseRedemptionDealView(dealImage: dealImage, dealTitle: dealTitle, dealDescription: dealDescription, dealValidity: dealValidity, dealStoreName: dealStoreName, brandLogo: brandLogo)
                            )
                        );
                      },
                      colors: [const Color(0xFFD62828), const Color(0xFFC21414)],
                      boxShadow: [const BoxShadow(color: Color(0xFF9A0000), spreadRadius: 1)],
                      child: Text(
                        'Activate Deal',
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
      ),
    );
  }
}

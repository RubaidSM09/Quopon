import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:quopon/app/modules/ChooseRedemptionDeal/views/choose_redemption_deal_view.dart';
import 'package:quopon/app/modules/ChooseRedemptionDeal/views/pickup_view.dart';
import 'package:quopon/app/modules/VendorProfile/views/vendor_profile_view.dart';

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
    RxBool isPickup = true.obs;
    RxBool isSaved = false.obs;

    return Dialog(
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
                ],
              ),
      
              SizedBox(height: 12.h),
      
              // Deal Title
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          dealTitle,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        Obx(() {
                          return isSaved.value ?
                          GestureDetector(
                            onTap: () {
                              if (isSaved.value) {
                                isSaved.value = !isSaved.value;
                              }
                            },
                            child: Icon(
                              Icons.favorite_rounded,
                              color: Color(0xFFD62828),
                            ),
                          ) :
                          GestureDetector(
                            onTap: () {
                              if (!isSaved.value) {
                                isSaved.value = !isSaved.value;
                              }
                              showTopSavedDealBanner(context);
                            },
                            child: Icon(
                              Icons.favorite_outline_rounded,
                              color: Color(0xFFD62828),
                            ),
                          );
                        }
                        ),
                      ],
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
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(26),
                            blurRadius: 20,
                          ),
                        ],
                      ),
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
                                  child: Image.asset(
                                    brandLogo,
                                    height: 44.h,
                                    width: 44.w,
                                  ),
                                ),
                                SizedBox(width: 10.w),
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
                                color: Color(0xFFD62828),
                              ),
                              child: Center(
                                child: Text(
                                  '50% OFF',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      
              SizedBox(height: 12.h),
      
              Obx(() {
                return Column(
                  children: [
                    Text(
                      'Order Type',
                      style: TextStyle(
                        color: Color(0xFF020711),
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Container(
                      padding: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.r),
                        color: Color(0xFFF1F3F4),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (!isPickup.value) {
                                isPickup.value = !isPickup.value;
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 10.h,
                                horizontal: 16.w,
                              ),
                              decoration: BoxDecoration(
                                color: isPickup.value
                                    ? Color(0xFFD62828)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(100.r),
                              ),
                              child: SizedBox(
                                width: 125.w,
                                child: Text(
                                  'Pickup',
                                  style: TextStyle(
                                    color: isPickup.value
                                        ? Colors.white
                                        : Color(0xFF6F7E8D),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.sp,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (isPickup.value) {
                                isPickup.value = !isPickup.value;
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 10.h,
                                horizontal: 16.w,
                              ),
                              decoration: BoxDecoration(
                                color: isPickup.value
                                    ? Colors.transparent
                                    : Color(0xFFD62828),
                                borderRadius: BorderRadius.circular(100.r),
                              ),
                              child: SizedBox(
                                width: 125.w,
                                child: Text(
                                  'Delivery',
                                  style: TextStyle(
                                    color: isPickup.value
                                        ? Color(0xFF6F7E8D)
                                        : Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.sp,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
      
                    SizedBox(height: 20.h),
      
                    // Activate Deal Button
                    GradientButton(
                      text: 'Order Now',
                      onPressed: () {
                        Get.to(VendorProfileView());
                      },
                      colors: [const Color(0xFFD62828), const Color(0xFFC21414)],
                      boxShadow: [
                        const BoxShadow(
                          color: Color(0xFF9A0000),
                          spreadRadius: 1,
                        ),
                      ],
                      child: Text(
                        'Order Now',
                        style: TextStyle(
                          fontSize: 16.sp, // Use ScreenUtil for font size
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  void showTopSavedDealBanner(BuildContext context) {
    final overlay = Overlay.of(context);

    late OverlayEntry overlayEntry; // ✅ Declare it first with 'late'

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 24.h,
        left: 112.w,
        right: 112.w,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(26),
                  blurRadius: 20,
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.favorite_rounded, color: Color(0xFFD62828)),
                    SizedBox(width: 8.w),
                    Text(
                      "Saved to My Deals",
                      style: TextStyle(
                        color: Color(0xFFD62828),
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () => overlayEntry.remove(), // ✅ Now valid
                  child: Icon(Icons.close, color: Color(0xFFD62828), size: 16.sp),
                )
              ],
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    // Auto remove
    Future.delayed(Duration(seconds: 3), () {
      if (overlayEntry.mounted) overlayEntry.remove();
    });
  }
}

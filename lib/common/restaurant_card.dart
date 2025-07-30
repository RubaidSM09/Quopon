import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';  // Import ScreenUtil
import 'package:get/get.dart';
import 'package:quopon/app/modules/QuoponPlus/views/quopon_plus_view.dart';

class RestaurantCard extends StatefulWidget {
  final String discountTxt;
  final String restaurantImg;
  final String restaurantName;
  final String deliveryFee;
  final String distance;
  final String rating;
  final String reviewCount;
  final String deliveryTime;
  final double height;

  const RestaurantCard({
    super.key,
    required this.discountTxt,
    required this.restaurantImg,
    required this.restaurantName,
    required this.deliveryFee,
    required this.distance,
    required this.rating,
    required this.reviewCount,
    required this.deliveryTime,
    this.height = 120,
  });

  @override
  State<RestaurantCard> createState() => _RestaurantCardState();
}

class _RestaurantCardState extends State<RestaurantCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 206.h,  // Use ScreenUtil for height
      width: 195.w,   // Use ScreenUtil for width
      padding: EdgeInsets.all(8.w),  // Use ScreenUtil for padding
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),  // Use ScreenUtil for border radius
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(15),
            blurRadius: 16.r,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Coffee image with red promo badge and heart icon
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.asset(
                  widget.restaurantImg,
                  height: 120.h,
                ),
              ),
              // Red promo badge
              widget.discountTxt == '' ? SizedBox.shrink() : Positioned(
                top: 13.h,
                left: 8.w,
                child: Container(
                  padding: EdgeInsets.all(6.w),
                  decoration: BoxDecoration(
                    color: Color(0xFFD62828),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    widget.discountTxt,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.sp,  // Use ScreenUtil for font size
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              // Heart icon
              Positioned(
                top: 8.h,
                left: 137.w,
                child: Container(
                  width: 34.w,
                  height: 34.h,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.25),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.favorite_border,
                    color: Colors.white,
                    size: 18.sp,
                  ),
                ),
              ),
            ],
          ),

          // Restaurant details
          SizedBox(
            height: 62.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Restaurant name
                Text(
                  widget.restaurantName,
                  style: TextStyle(
                    fontSize: 16.sp,  // Use ScreenUtil for font size
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF020711),
                  ),
                ),

                // Delivery fee and distance
                Row(
                  children: [
                    Text(
                      widget.deliveryFee,
                      style: TextStyle(
                        fontSize: 12.sp,  // Use ScreenUtil for font size
                        color: Color(0xFF6F7E8D),
                      ),
                    ),
                    SizedBox(width: 8.w),  // Use ScreenUtil for width spacing
                    Icon(Icons.circle, size: 8.sp, color: Color(0xFFCAD9E8),),
                    SizedBox(width: 8.w),
                    Text(
                      widget.distance,
                      style: TextStyle(
                        fontSize: 12.sp,  // Use ScreenUtil for font size
                        color: Color(0xFF6F7E8D),
                      ),
                    ),
                  ],
                ),

                // Rating and delivery time
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.orange,
                      size: 14.sp,  // Use ScreenUtil for icon size
                    ),
                    SizedBox(width: 4.w),  // Use ScreenUtil for width spacing
                    Text(
                      '${widget.rating} (${widget.reviewCount})',
                      style: TextStyle(
                        fontSize: 12.sp,  // Use ScreenUtil for font size
                        color: Color(0xFF6F7E8D),
                      ),
                    ),
                    SizedBox(width: 8.w),  // Use ScreenUtil for width spacing
                    Icon(Icons.circle, size: 8.sp, color: Color(0xFFCAD9E8),),
                    SizedBox(width: 8.w),
                    Text(
                      widget.deliveryTime,
                      style: TextStyle(
                        fontSize: 12.sp,  // Use ScreenUtil for font size
                        color: Color(0xFF6F7E8D),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RestaurantCardBlur extends StatefulWidget {
  final String restaurantImg;
  final String restaurantName;
  final String deliveryFee;
  final String distance;
  final String rating;
  final String reviewCount;
  final String deliveryTime;

  const RestaurantCardBlur({
    super.key,
    required this.restaurantImg,
    required this.restaurantName,
    required this.deliveryFee,
    required this.distance,
    required this.rating,
    required this.reviewCount,
    required this.deliveryTime
  });

  @override
  State<RestaurantCardBlur> createState() => _RestaurantCardBlurState();
}

class _RestaurantCardBlurState extends State<RestaurantCardBlur> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.bottomSheet(QuoponPlusView());
      },
      child: Container(
        width: 220.w,  // Use ScreenUtil for width
        height: 206.h,  // Use ScreenUtil for height
        margin: EdgeInsets.all(8.w),  // Use ScreenUtil for margin
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),  // Use ScreenUtil for border radius
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(15),
              blurRadius: 16,
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Coffee image with red promo badge and heart icon
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12.r),
                          topRight: Radius.circular(12.r),
                          bottomLeft: Radius.circular(12.r),
                          bottomRight: Radius.circular(12.r),
                        ),
                        child: Container(
                          height: 120.h,  // Use ScreenUtil for height
                          width: 204.w,   // Use ScreenUtil for width
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(widget.restaurantImg),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Heart icon
                    Positioned(
                      top: 12.h,
                      right: 12.w,
                      child: Container(
                        width: 32.w,
                        height: 32.h,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.25),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                          size: 18.sp,
                        ),
                      ),
                    ),
                  ],
                ),

                // Restaurant details
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Restaurant name
                    Text(
                      widget.restaurantName,
                      style: TextStyle(
                        fontSize: 16.sp,  // Use ScreenUtil for font size
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 4.h),  // Use ScreenUtil for height spacing

                    // Delivery fee and distance
                    Row(
                      children: [
                        Text(
                          widget.deliveryFee,
                          style: TextStyle(
                            fontSize: 12.sp,  // Use ScreenUtil for font size
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(width: 8.w),  // Use ScreenUtil for width spacing
                        Text(
                          widget.distance,
                          style: TextStyle(
                            fontSize: 12.sp,  // Use ScreenUtil for font size
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),  // Use ScreenUtil for height spacing

                    // Rating and delivery time
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.orange,
                          size: 14.sp,  // Use ScreenUtil for icon size
                        ),
                        SizedBox(width: 4.w),  // Use ScreenUtil for width spacing
                        Text(
                          '${widget.rating} (${widget.reviewCount})',
                          style: TextStyle(
                            fontSize: 12.sp,  // Use ScreenUtil for font size
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(width: 8.w),  // Use ScreenUtil for width spacing
                        Text(
                          widget.deliveryTime,
                          style: TextStyle(
                            fontSize: 12.sp,  // Use ScreenUtil for font size
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),

            // Blur overlay with Qoupon+ Exclusive design
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),  // Use ScreenUtil for border radius
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(
                  width: 220.0.w,  // Use ScreenUtil for width
                  height: 206.0.h,  // Use ScreenUtil for height
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),  // Use ScreenUtil for border radius
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white.withOpacity(0.8),
                        Colors.grey.shade100.withOpacity(0.9),
                      ],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Qoupon+ Exclusive badge
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),  // Use ScreenUtil for padding
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(20.r),  // Use ScreenUtil for border radius
                              ),
                              child: Text(
                                'Qoupon+ Exclusive',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.sp,  // Use ScreenUtil for font size
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 41.h),  // Use ScreenUtil for height spacing

                      // Diamond icon
                      Image.asset(
                        'assets/images/Home/Diamond.png',
                        height: 48.h,  // Use ScreenUtil for height
                        width: 48.w,   // Use ScreenUtil for width
                      ),
                      SizedBox(height: 8.h),  // Use ScreenUtil for height spacing

                      // Main title
                      Text(
                        'Unlock with Qoupon+',
                        style: TextStyle(
                          fontSize: 14.sp,  // Use ScreenUtil for font size
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF020711),
                        ),
                      ),
                      SizedBox(height: 4.h),  // Use ScreenUtil for height spacing

                      // Subtitle
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),  // Use ScreenUtil for padding
                        child: Text(
                          'Get full access to exclusive deals,early releases, and premium perks.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12.sp,  // Use ScreenUtil for font size
                            color: Color(0xFF6F7E8D),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ActiveDealCard extends GetView {
  final String dealImg;
  final String dealTitle;
  final String dealDescription;
  final String dealValidity;

  const ActiveDealCard({
    super.key,
    required this.dealImg,
    required this.dealTitle,
    required this.dealDescription,
    required this.dealValidity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220.w,  // Use ScreenUtil for width
      margin: EdgeInsets.all(8.w),  // Use ScreenUtil for margin
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),  // Use ScreenUtil for border radius
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Coffee image with red promo badge and heart icon
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.r),  // Use ScreenUtil for radius
                    topRight: Radius.circular(12.r),  // Use ScreenUtil for radius
                    bottomLeft: Radius.circular(12.r),  // Use ScreenUtil for radius
                    bottomRight: Radius.circular(12.r),  // Use ScreenUtil for radius
                  ),
                  child: Container(
                    height: 120.h,  // Use ScreenUtil for height
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(dealImg),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),

              // Heart icon
              Positioned(
                top: 12.h,
                right: 12.w,
                child: Container(
                  width: 32.w,
                  height: 32.h,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.25),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.favorite_border,
                    color: Colors.white,
                    size: 18.sp,  // Use ScreenUtil for size
                  ),
                ),
              ),
            ],
          ),

          // Deal details
          Padding(
            padding: EdgeInsets.fromLTRB(12.w, 0.h, 12.w, 12.h),  // Use ScreenUtil for padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Deal name
                Text(
                  dealTitle,
                  style: TextStyle(
                    fontSize: 16.sp,  // Use ScreenUtil for font size
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),  // Use ScreenUtil for height spacing

                // Description
                Text(
                  dealDescription,
                  style: TextStyle(
                    fontSize: 12.sp,  // Use ScreenUtil for font size
                    color: Colors.grey[600],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),  // Use ScreenUtil for height spacing

                // Rating and delivery time
                Row(
                  children: [
                    Text(
                      'Valid Until: ',
                      style: TextStyle(
                        fontSize: 12.sp,  // Use ScreenUtil for font size
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFD62828),
                      ),
                    ),
                    Text(
                      dealValidity,
                      style: TextStyle(
                        fontSize: 12.sp,  // Use ScreenUtil for font size
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

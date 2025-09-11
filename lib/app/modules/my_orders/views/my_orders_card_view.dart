import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:quopon/app/modules/OrderDetails/views/order_details_view.dart';
import 'package:quopon/app/modules/OrderDetails/views/track_order_view.dart';

import '../../../../common/customTextButton.dart';

class MyOrdersCardView extends GetView {
  final String itemImg;
  final String itemName;
  final String orderId;
  final double price;
  final String orderType;

  const MyOrdersCardView({
    required this.itemImg,
    required this.itemName,
    required this.orderId,
    required this.price,
    required this.orderType,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withAlpha(26), blurRadius: 20.r)]
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.network(
                  itemImg,
                  scale: 4,
                  height: 72.h,
                  width: 72.w,
                ),
              ),
              SizedBox(width: 12.w,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    itemName,
                    style: TextStyle(
                      color: Color(0xFF020711),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 6.h,),
                  Row(
                    children: [
                      Text(
                        'Order ID: $orderId',
                        style: TextStyle(
                          color: Color(0xFF6F7E8D),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(width: 12.w,),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFCAD9E8),
                        ),
                        height: 6.h,
                        width: 6.w,
                      ),
                      SizedBox(width: 12.w,),
                      Text(
                        '\$$price',
                        style: TextStyle(
                          color: Color(0xFF6F7E8D),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: Color(0xFFD62828).withAlpha(20),
                      borderRadius: BorderRadius.circular(6.r)
                    ),
                    child: Text(
                      orderType,
                      style: TextStyle(
                        color: Color(0xFFD62828),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),

          SizedBox(height: 16.h,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GradientButton(
                text: 'View Details',
                onPressed: () {
                  Get.to(OrderDetailsView());
                },
                colors: [const Color(0xFFF4F5F6), const Color(0xFFEEF0F3)],
                boxShadow: [const BoxShadow(color: Color(0xFFDFE4E9), spreadRadius: 1)],
                borderColor: [Colors.white, const Color(0xFFEEF0F3)],
                width: 181.w,
                height: 42.h,
                borderRadius: 12.r,
                child: Text(
                  'View Details',
                  style: TextStyle(
                    fontSize: 14.sp,  // Use ScreenUtil for font size
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF020711),
                  ),
                ),
              ),

              GradientButton(
                text: 'Track Order',
                onPressed: () {
                  Get.to(TrackOrderView());
                },
                colors: [const Color(0xFFD62828), const Color(0xFFC21414)],
                boxShadow: [const BoxShadow(color: Color(0xFF9A0000), spreadRadius: 1)],
                borderColor: [Color(0xFFF44646), const Color(0xFFC21414)],
                width: 181.w,
                height: 42.h,
                borderRadius: 12.r,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/OrderDetails/Track.png',
                    ),
                    SizedBox(width: 8.w,),
                    Text(
                      'Track Order',
                      style: TextStyle(
                        fontSize: 14.sp,  // Use ScreenUtil for font size
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

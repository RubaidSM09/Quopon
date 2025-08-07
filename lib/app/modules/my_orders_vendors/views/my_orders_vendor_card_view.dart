import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:quopon/app/modules/my_orders_vendors/views/my_order_details_vendor_view.dart';
import 'package:quopon/common/customTextButton.dart';

class MyOrdersVendorCardView extends GetView {
  final String itemImg;
  final String itemName;
  final Map<String, List<String>> itemAddons;
  final bool isNew;
  final String status;
  final String customerName;
  final String orderItem;
  final int quantity;
  final double totalAmount;
  final String orderTime;
  final String orderStatus;

  const MyOrdersVendorCardView({
    required this.itemImg,
    required this.itemName,
    this.itemAddons = const {},
    this.isNew = false,
    required this.status,
    required this.customerName,
    required this.orderItem,
    required this.quantity,
    required this.totalAmount,
    required this.orderTime,
    required this.orderStatus,
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
                child: Image.asset(
                  itemImg,
                  height: 62.h,
                  width: 62.w,
                ),
              ),

              SizedBox(width: 12.w,),

              SizedBox(
                width: 300.w,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          itemName,
                          style: TextStyle(
                            color: Color(0xFF020711),
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp,
                          ),
                        ),
                        Row(
                          children: [
                            isNew ? Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.r),
                                color: Color(0xFFECFDF5),
                              ),
                              child: Text(
                                'New',
                                style: TextStyle(
                                  color: Color(0xFF2ECC71),
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ) : SizedBox.shrink(),

                            SizedBox(width: 6.w,),

                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.r),
                                color: Color(0xFFD62828).withAlpha(20),
                              ),
                              child: Text(
                                status,
                                style: TextStyle(
                                  color: Color(0xFFD62828),
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),

                    SizedBox(height: 8.h,),

                    // Dynamically build addon rows for cheese and spreads
                    ...itemAddons.entries.map((entry) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 6.h),
                        child: Row(
                          children: [
                            Text(
                              'Select ${entry.key}: ',
                              style: TextStyle(
                                color: Color(0xFF6F7E8D),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Text(
                              entry.value.join(', '),
                              style: TextStyle(
                                color: Color(0xFF6F7E8D),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              )
            ],
          ),

          SizedBox(height: 16.h,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 169.w,
                child: Text(
                  'Customer Name',
                  style: TextStyle(
                    color: Color(0xFF6F7E8D),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              Text(
                ':',
                style: TextStyle(
                  color: Color(0xFF020711),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(
                width: 169.w,
                child: Text(
                  customerName,
                  style: TextStyle(
                    color: Color(0xFF020711),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 169.w,
                child: Text(
                  'Ordered Item',
                  style: TextStyle(
                    color: Color(0xFF6F7E8D),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              Text(
                ':',
                style: TextStyle(
                  color: Color(0xFF020711),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(
                width: 169.w,
                child: Text(
                  orderItem,
                  style: TextStyle(
                    color: Color(0xFF020711),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 169.w,
                child: Text(
                  'Quantity',
                  style: TextStyle(
                    color: Color(0xFF6F7E8D),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              Text(
                ':',
                style: TextStyle(
                  color: Color(0xFF020711),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(
                width: 169.w,
                child: Text(
                  'x$quantity',
                  style: TextStyle(
                    color: Color(0xFF020711),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 169.w,
                child: Text(
                  'Total Amount',
                  style: TextStyle(
                    color: Color(0xFF6F7E8D),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              Text(
                ':',
                style: TextStyle(
                  color: Color(0xFF020711),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(
                width: 169.w,
                child: Text(
                  '\$$totalAmount',
                  style: TextStyle(
                    color: Color(0xFF020711),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 169.w,
                child: Text(
                  'Time of Order',
                  style: TextStyle(
                    color: Color(0xFF6F7E8D),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              Text(
                ':',
                style: TextStyle(
                  color: Color(0xFF020711),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(
                width: 169.w,
                child: Text(
                  orderTime,
                  style: TextStyle(
                    color: Color(0xFF020711),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 169.w,
                child: Text(
                  'Order Status',
                  style: TextStyle(
                    color: Color(0xFF6F7E8D),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              Text(
                ':',
                style: TextStyle(
                  color: Color(0xFF020711),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(
                width: 169.w,
                child: Text(
                  orderStatus,
                  style: TextStyle(
                    color: Color(0xFF020711),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GradientButton(
                text: 'View Details',
                onPressed: () {
                  Get.dialog(MyOrderDetailsVendorView(
                    itemImg: itemImg,
                    itemName: itemName,
                    itemAddons: itemAddons,
                    isNew: isNew,
                    status: status,
                    customerName: customerName,
                    orderItem: orderItem,
                    quantity: quantity,
                    totalAmount: totalAmount,
                    orderTime: orderTime,
                    orderStatus: orderStatus,
                  ));
                },
                colors: [const Color(0xFFF4F5F6), const Color(0xFFEEF0F3)],
                boxShadow: [const BoxShadow(color: Color(0xFFDFE4E9), spreadRadius: 1)],
                borderColor: [Colors.white, const Color(0xFFEEF0F3)],
                width: 181.w,
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
                text: 'Move In Preparation',
                onPressed: () {

                },
                colors: [const Color(0xFFD62828), const Color(0xFFC21414)],
                boxShadow: [const BoxShadow(color: Color(0xFF9A0000), spreadRadius: 1)],
                borderColor: [Color(0xFFF44646), const Color(0xFFC21414)],
                width: 181.w,
                borderRadius: 12.r,
                child: Text(
                  'Move In Preparation',
                  style: TextStyle(
                    fontSize: 13.9.sp,  // Use ScreenUtil for font size
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:quopon/app/modules/my_orders_vendors/views/cancel_order_vendor_view.dart';

import '../../../../common/customTextButton.dart';

class MyOrderDetailsVendorView extends GetView {
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

  const MyOrderDetailsVendorView({
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
    return Dialog(
      backgroundColor: Color(0xFFF9FBFC),
      child: Padding(
        padding: EdgeInsets.all(12.r),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox.shrink(),
                  Text(
                    'Order Details',
                    style: TextStyle(
                      color: Color(0xFF020711),
                      fontWeight: FontWeight.w500,
                      fontSize: 18.sp,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Icon(Icons.close, size: 24.sp,),
                  )
                ],
              ),

              SizedBox(height: 16.h,),

              Divider(color: Color(0xFFEAECED),),

              SizedBox(height: 16.h,),

              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: Image.network(
                      itemImg,
                      height: 62.h,
                      width: 62.w,
                    ),
                  ),

                  SizedBox(width: 12.w,),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 245.w,
                        child: Row(
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
                            Text(
                              '\$9.00',
                              style: TextStyle(
                                color: Color(0xFF020711),
                                fontWeight: FontWeight.w500,
                                fontSize: 16.sp,
                              ),
                            )
                          ],
                        ),
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
                  )
                ],
              ),

              SizedBox(height: 16.h,),

              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: Image.network(
                      itemImg,
                      height: 62.h,
                      width: 62.w,
                    ),
                  ),

                  SizedBox(width: 12.w,),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 245.w,
                        child: Row(
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
                            Text(
                              '\$9.00',
                              style: TextStyle(
                                color: Color(0xFF020711),
                                fontWeight: FontWeight.w500,
                                fontSize: 16.sp,
                              ),
                            )
                          ],
                        ),
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
                  )
                ],
              ),

              SizedBox(height: 16.h,),

              Divider(color: Color(0xFFEAECED),),

              SizedBox(height: 16.h,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 150.w,
                    child: Text(
                      'Order Number',
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
                    width: 150.w,
                    child: Text(
                      '#ORD-57321',
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
                    width: 150.w,
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
                    width: 150.w,
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
                    width: 150.w,
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
                    width: 150.w,
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
                    width: 150.w,
                    child: Text(
                      'Order Type',
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
                    width: 150.w,
                    child: Text(
                      status,
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
                    width: 150.w,
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
                    width: 150.w,
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
                    width: 150.w,
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
                    width: 150.w,
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
                    width: 150.w,
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
                    width: 150.w,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 150.w,
                    child: Text(
                      'Delivery Addresss',
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
                    width: 150.w,
                    child: Text(
                      'Jan van Galenstraat 92, 1056 CC Amsterdam',
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 150.w,
                    child: Text(
                      'Notes',
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
                    width: 150.w,
                    child: Text(
                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
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

              Divider(color: Color(0xFFEAECED),),

              SizedBox(height: 16.h,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 150.w,
                    child: Text(
                      'Sub Total',
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
                    width: 150.w,
                    child: Text(
                      '\$18.00',
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
                    width: 150.w,
                    child: Text(
                      'Delivery Charges',
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
                    width: 150.w,
                    child: Text(
                      '\$1.99',
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
                    width: 150.w,
                    child: Text(
                      'Applied Deal Discount',
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
                    width: 150.w,
                    child: Text(
                      '50%',
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 150.w,
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
                    width: 150.w,
                    child: Row(
                      children: [
                        Text(
                          '\$9.99',
                          style: TextStyle(
                            color: Color(0xFF020711),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        SizedBox(width: 12.w,),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.5.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.r),
                            color: Color(0xFF2ECC71),
                          ),
                          child: Text(
                            'Paid',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16.h,),

              Divider(color: Color(0xFFEAECED),),

              SizedBox(height: 16.h,),

              GradientButton(
                text: 'Cancel Order',
                onPressed: () {
                  Get.back();
                  Get.dialog(CancelOrderVendorView(
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
                borderRadius: 12.r,
                child: Text(
                  'Cancel Order',
                  style: TextStyle(
                    fontSize: 14.sp,  // Use ScreenUtil for font size
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF020711),
                  ),
                ),
              ),

              SizedBox(height: 8.h,),

              GradientButton(
                text: 'Move In Preparation',
                onPressed: () {

                },
                colors: [const Color(0xFFD62828), const Color(0xFFC21414)],
                boxShadow: [const BoxShadow(color: Color(0xFF9A0000), spreadRadius: 1)],
                borderColor: [Color(0xFFF44646), const Color(0xFFC21414)],
                borderRadius: 12.r,
                child: Text(
                  'Move In Preparation',
                  style: TextStyle(
                    fontSize: 14.sp,  // Use ScreenUtil for font size
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

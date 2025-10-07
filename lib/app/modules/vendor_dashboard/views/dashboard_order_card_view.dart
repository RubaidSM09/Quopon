import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:quopon/app/modules/my_orders_vendors/views/my_order_details_vendor_view.dart';

class DashboardOrderCardView extends GetView {
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
  final String orderId;

  const DashboardOrderCardView({
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
    required this.orderId,
    super.key
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
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
          orderId: orderId,
        )
        );
      },

      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 16.r)]
        ),
        child: Row(
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

            SizedBox(
              width: 300.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  Row(
                    children: [
                      Text(
                        '\$$totalAmount',
                        style: TextStyle(
                          color: Color(0xFF6F7E8D),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(width: 8.w,),
                      Container(
                        width: 5.w,
                        height: 5.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFCAD9E8),
                        ),
                      ),
                      SizedBox(width: 8.w,),
                      Text(
                        'Qty: x$quantity',
                        style: TextStyle(
                          color: Color(0xFF6F7E8D),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 6.h,),

                  Text(
                    'Time of Order: $orderTime',
                    style: TextStyle(
                      color: Color(0xFF6F7E8D),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:quopon/app/modules/my_orders_vendors/controllers/my_orders_vendors_controller.dart';
import 'package:quopon/common/customTextButton.dart';

import 'my_order_details_vendor_view.dart';

class MyOrdersVendorCardView extends GetView<MyOrdersVendorsController> {
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
  final String note;
  final String orderId; // Changed to String to use order_id (UUID)

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
    this.note = '',
    required this.orderId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withAlpha(26), blurRadius: 20.r)],
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.network(
                  itemImg,
                  height: 62.h,
                  width: 62.w,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
                ),
              ),
              SizedBox(width: 12.w),
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
                            isNew
                                ? Container(
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
                            )
                                : SizedBox.shrink(),
                            SizedBox(width: 6.w),
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
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
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
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 169.w,
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
                width: 169.w,
                child: Text(
                  '#$orderId',
                  style: TextStyle(
                    color: Color(0xFF020711),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 169.w,
                child: Text(
                  'Time',
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
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
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
          SizedBox(height: 16.h),
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
          SizedBox(height: 16.h),
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
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 169.w,
                child: Text(
                  'Note',
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
                  note,
                  style: TextStyle(
                    color: Color(0xFF020711),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
          orderStatus == "RECEIVED" ? SizedBox(height: 16.h) : SizedBox.shrink(),
          orderStatus == "RECEIVED" ? Divider(color: Color(0xFFF2F4F5)) : SizedBox.shrink(),
          orderStatus == "RECEIVED" ? SizedBox(height: 16.h) : SizedBox.shrink(),
          orderStatus == "RECEIVED"
              ? Row(
            children: [
              Text(
                'When will this order be ready?',
                style: TextStyle(
                  color: Color(0xFF020711),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox.shrink(),
            ],
          )
              : SizedBox.shrink(),
          orderStatus == "RECEIVED" ? SizedBox(height: 12.h) : SizedBox.shrink(),
          orderStatus == "RECEIVED"
              ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TimeCardView(time: 15, index: 0, orderId: orderId),
              TimeCardView(time: 30, index: 1, orderId: orderId),
              TimeCardView(time: 45, index: 2, orderId: orderId),
              TimeCardView(time: 60, index: 3, orderId: orderId),
              TimeCardView(time: 90, index: 4, orderId: orderId),
            ],
          )
              : SizedBox.shrink(),
          orderStatus == "RECEIVED" ? SizedBox(height: 12.h) : SizedBox.shrink(),
          orderStatus == "RECEIVED"
              ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/images/my_orders/ready_time.png',
                    scale: 4,
                  ),
                  SizedBox(width: 8.w),
                  Obx(() {
                    return Text(
                      'Ready at ${DateTime.now().add(Duration(minutes: controller.time.value)).hour}:${DateTime.now().add(Duration(minutes: controller.time.value)).minute.toString().padLeft(2, '0')}',
                      style: TextStyle(
                        color: Color(0xFF2ECC71),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    );
                  }),
                ],
              ),
            ],
          )
              : SizedBox.shrink(),
          SizedBox(height: 16.h),
          orderStatus == "RECEIVED" ||
              orderStatus == "PREPARING" ||
              orderStatus == "READY_FOR_PICKUP" ||
              orderStatus == "Picked Up" ||
              orderStatus == "OUT_FOR_DELIVERY" ||
              orderStatus == "Delivered"
              ? Row(
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
                height: 42.h,
                borderRadius: 12.r,
                child: Text(
                  'View Details',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF020711),
                  ),
                ),
              ),
              GradientButton(
                text: _getButtonText(),
                onPressed: () {
                  _handleStatusUpdate();
                },
                colors: [const Color(0xFFD62828), const Color(0xFFC21414)],
                boxShadow: [const BoxShadow(color: Color(0xFF9A0000), spreadRadius: 1)],
                borderColor: [Color(0xFFF44646), const Color(0xFFC21414)],
                width: 181.w,
                height: 42.h,
                borderRadius: 12.r,
                child: Text(
                  _getButtonText(),
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          )
              : GradientButton(
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
            height: 42.h,
            borderRadius: 12.r,
            child: Text(
              'View Details',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Color(0xFF020711),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getButtonText() {
    if (orderStatus == "RECEIVED") {
      return 'Start Preparation';
    } else if (orderStatus == "PREPARING") {
      return status == "Pickup" ? "Ready for Pickup" : "Out for Delivery";
    } else if (orderStatus == "READY_FOR_PICKUP") {
      return "Picked Up";
    } else if (orderStatus == "OUT_FOR_DELIVERY") {
      return "Mark as Delivered";
    } else if (orderStatus == "Delivered" || orderStatus == "Picked Up") {
      return "Mark as Completed";
    }
    return '';
  }

  void _handleStatusUpdate() {
    if (orderStatus == "RECEIVED") {
      controller.updateOrderStatus(orderId, 'PREPARING');
    } else if (orderStatus == "PREPARING") {
      if (status == "Pickup") {
        controller.updateOrderStatus(orderId, 'READY_FOR_PICKUP');
      } else {
        print('Rubaid');
        controller.updateOrderStatus(orderId, 'OUT_FOR_DELIVERY');
      }
    } else if (orderStatus == "READY_FOR_PICKUP") {
      controller.updateOrderStatus(orderId, 'PICKED_UP');
    } else if (orderStatus == "OUT_FOR_DELIVERY") {
      controller.updateOrderStatus(orderId, 'DELIVERED');
    } else if (orderStatus == "Delivered" || orderStatus == "Picked Up") {
      controller.updateOrderStatus(orderId, 'COMPLETED');
    }
  }
}

class TimeCardView extends GetView<MyOrdersVendorsController> {
  final int time;
  final int index;
  final String orderId;

  const TimeCardView({
    required this.time,
    required this.index,
    required this.orderId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GestureDetector(
        onTap: () {
          for (int i = 0; i < 5; i++) {
            controller.selectedTime[i].value = false;
          }
          controller.selectedTime[index].value = true;
          switch (index) {
            case 0:
              controller.time.value = 15;
              break;
            case 1:
              controller.time.value = 30;
              break;
            case 2:
              controller.time.value = 45;
              break;
            case 3:
              controller.time.value = 60;
              break;
            case 4:
              controller.time.value = 90;
              break;
          }
        },
        child: Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: controller.selectedTime[index].value ? Color(0xFFD62828) : Color(0xFFEAECED),
            ),
          ),
          child: Text(
            '$time min',
            style: TextStyle(
              color: controller.selectedTime[index].value ? Color(0xFFD62828) : Color(0xFF6F7E8D),
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    });
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../../common/customTextButton.dart';
import '../../dealDetail/views/deal_detail_view.dart';

class QrSuccessOrderView extends GetView {
  final String invoiceNumber;
  final String customerName;
  final String orderItems;
  final String timestamp;

  const QrSuccessOrderView({
    super.key,
    required this.invoiceNumber,
    required this.customerName,
    required this.orderItems,
    required this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black.withOpacity(0.0),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Color(0xFFF9FBFC),
          borderRadius: BorderRadius.circular(16.r),
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
              Text('Order Verified Successfully', textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF020711), fontSize: 20.sp, fontWeight: FontWeight.w500),),
              SizedBox(height: 10.h),
              Text('The order has been verified and completed. You may now proceed with handing over the items.', textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF6F7E8D), fontSize: 16.sp, fontWeight: FontWeight.normal),),
              SizedBox(height: 24.h),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.black.withAlpha(26), blurRadius: 20.r)],
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.w),
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
                              invoiceNumber,
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
                              customerName,
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
                              'Order Items',
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
                              orderItems,
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
                              timestamp,
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
                    fontSize: 16.sp,
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

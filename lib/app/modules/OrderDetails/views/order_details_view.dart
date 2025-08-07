import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quopon/app/modules/OrderDetails/views/track_order_view.dart';
import 'package:quopon/app/modules/OrderDetails/views/view_receipt_view.dart';
import '../../../../../../common/customTextButton.dart';
import '../controllers/order_details_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil

class OrderDetailsView extends GetView<OrderDetailsController> {
  const OrderDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    RxBool isDelivery = true.obs;

    return Scaffold(
      backgroundColor: Color(0xFFF9FBFC),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 32.h, 16.w, 16.h), // ScreenUtil applied
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(Icons.arrow_back),
                  ),
                  Text(
                    'Order Details',
                    style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500, color: Color(0xFF020711)), // ScreenUtil applied
                  ),
                  SizedBox(),
                ],
              ),

              SizedBox(height: 40.h),

              ClipRRect(
                borderRadius: BorderRadius.circular(16.r), // ScreenUtil applied
                child: Image.asset(
                  'assets/images/OrderDetails/OrderConfirmed.gif',
                  height: 80.h,
                  width: 80.w,
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                'Your Order is Confirmed!',
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500, color: Color(0xFF020711)), // ScreenUtil applied
              ),
              SizedBox(height: 5.h),
              Text(
                'Your order has been placed successfully. We\'ll notify you when it\'s on the way.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)), // ScreenUtil applied
              ),

              SizedBox(height: 20.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Order Details',
                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: Color(0xFF020711)), // ScreenUtil applied
                  ),
                  SizedBox.shrink()
                ],
              ),

              SizedBox(height: 10.h),

              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r), // ScreenUtil applied
                    color: Colors.white
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.w), // ScreenUtil applied
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.r), // ScreenUtil applied
                                child: Image.asset(
                                  'assets/images/Cart/Italian Panini.png',
                                  width: 62.w, // ScreenUtil applied
                                  height: 62.h, // ScreenUtil applied
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Italian Panini',
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp), // ScreenUtil applied
                                      ),
                                      SizedBox(width: 10.w),
                                      Text(
                                        'x2',
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp), // ScreenUtil applied
                                      ),
                                    ],
                                  ),
                                  Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'Select Cheese: ',
                                              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12.sp, color: Color(0xFF6F7E8D)), // ScreenUtil applied
                                            ),
                                            Text(
                                              'a, b, c, d',
                                              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12.sp, color: Color(0xFF6F7E8D)), // ScreenUtil applied
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Select Spreads: ',
                                              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12.sp, color: Color(0xFF6F7E8D)), // ScreenUtil applied
                                            ),
                                            Text(
                                              'Mayo, Ranch, Chipotle',
                                              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12.sp, color: Color(0xFF6F7E8D)), // ScreenUtil applied
                                            ),
                                          ],
                                        ),
                                      ]
                                  ),
                                ],
                              )
                            ],
                          ),
                          Text(
                            '\$9.0',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp), // ScreenUtil applied
                          ),
                        ],
                      ),

                      SizedBox(height: 2.5.h),
                      Divider(color: Color(0xFFEAECED), thickness: 1),

                      SizedBox(height: 2.5.h),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Order#',
                                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp, color: Color(0xFF6F7E8D)), // ScreenUtil applied
                              ),
                              Text(
                                '#ORD-57321',
                                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp, color: Color(0xFF020711)), // ScreenUtil applied
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Order Date',
                                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp, color: Color(0xFF6F7E8D)), // ScreenUtil applied
                              ),
                              Text(
                                '20 June, 2025',
                                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp, color: Color(0xFF020711)), // ScreenUtil applied
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Order Time',
                                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp, color: Color(0xFF6F7E8D)), // ScreenUtil applied
                              ),
                              Text(
                                '01: 09 AM',
                                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp, color: Color(0xFF020711)), // ScreenUtil applied
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Order Type',
                                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp, color: Color(0xFF6F7E8D)), // ScreenUtil applied
                              ),
                              Text(
                                'Delivery',
                                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp, color: Color(0xFF020711)), // ScreenUtil applied
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Estimated Time',
                                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp, color: Color(0xFF6F7E8D)), // ScreenUtil applied
                              ),
                              Text(
                                '10 - 15 mins',
                                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp, color: Color(0xFF020711)), // ScreenUtil applied
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Delivery Address',
                                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp, color: Color(0xFF6F7E8D)), // ScreenUtil applied
                              ),
                              SizedBox(
                                width: 171.w, // ScreenUtil applied
                                child: Text(
                                  textAlign: TextAlign.right,
                                  'Jan van Galenstraat 92, 1056 CC Amsterdam',
                                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp, color: Color(0xFF020711)), // ScreenUtil applied
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 10.h),

              Container(
                width: 500.w, // ScreenUtil applied
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r), // ScreenUtil applied
                ),
                child: Padding(
                  padding: EdgeInsets.all(12.w), // ScreenUtil applied
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Sub Total',
                            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)), // ScreenUtil applied
                          ),
                          Text(
                            '\$36.00',
                            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: Color(0xFF020711)), // ScreenUtil applied
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Delivery Charges',
                            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)), // ScreenUtil applied
                          ),
                          Text(
                            '\$1.99',
                            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: Color(0xFF020711)), // ScreenUtil applied
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Applied Deal Discount',
                            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)), // ScreenUtil applied
                          ),
                          Text(
                            '50% OFF',
                            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: Color(0xFF020711)), // ScreenUtil applied
                          ),
                        ],
                      ),
                      Divider(color: Color(0xFFEAECED), thickness: 1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total',
                            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)), // ScreenUtil applied
                          ),
                          Row(
                            children: [
                              Container(
                                height: 16.h, // ScreenUtil applied
                                width: 36.w, // ScreenUtil applied
                                decoration: BoxDecoration(
                                    color: Color(0xFF2ECC71),
                                    borderRadius: BorderRadius.circular(4.r) // ScreenUtil applied
                                ),
                                child: Center(
                                  child: Text(
                                    'Paid',
                                    style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w500, color: Colors.white), // ScreenUtil applied
                                  ),
                                ),
                              ),
                              SizedBox(width: 5.w), // ScreenUtil applied
                              Text(
                                '\$9.99',
                                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: Color(0xFF020711)), // ScreenUtil applied
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 32.h), // ScreenUtil applied
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GradientButton(
                onPressed: () {
                  Get.dialog(ViewReceiptView());
                },
                text: "View Receipt",
                colors: [Color(0xFFF4F5F6), Color(0xFFEEF0F3)],
                width: 200.w, // ScreenUtil applied
                borderRadius: 12.r, // ScreenUtil applied
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                        'assets/images/OrderDetails/Download.png'
                    ),
                    SizedBox(width: 5.w), // ScreenUtil applied
                    Text(
                      "View Receipt",
                      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: Color(0xFF020711)), // ScreenUtil applied
                    )
                  ],
                ),
              ),
              GradientButton(
                onPressed: () {
                  Get.to(TrackOrderView());
                },
                text: "Follow",
                colors: [Color(0xFFD62828), Color(0xFFC21414)],
                width: 200.w, // ScreenUtil applied
                borderRadius: 12.r, // ScreenUtil applied
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                        'assets/images/OrderDetails/Track.png'
                    ),
                    SizedBox(width: 5.w), // ScreenUtil applied
                    Text(
                      "Track Order",
                      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: Colors.white), // ScreenUtil applied
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

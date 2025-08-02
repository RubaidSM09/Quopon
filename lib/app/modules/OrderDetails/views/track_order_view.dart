import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil
import 'package:quopon/app/modules/ChooseRedemptionDeal/views/pickup_view.dart';

import '../../../../common/CheckoutCard.dart';
import '../../../../common/customTextButton.dart';
import '../../OrderDetails/controllers/track_order_controller.dart';

class TrackOrderView extends GetView<TrackOrderController> {
  const TrackOrderView({super.key});
  @override
  Widget build(BuildContext context) {
    final TrackOrderController controller = Get.put(TrackOrderController());

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
                      child: Icon(Icons.arrow_back, size: 24.w), // ScreenUtil applied
                    ),
                    Text(
                      'Track Order',
                      style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500, color: Color(0xFF020711)), // ScreenUtil applied
                    ),
                    SizedBox(),
                  ],
                ),

                SizedBox(height: 20.h), // ScreenUtil applied

                Row(
                  children: [
                    Text(
                      'Preparing Your Food',
                      style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500, color: Color(0xFF020711)), // ScreenUtil applied
                    ),
                    SizedBox.shrink(),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Real-time updates as your order progresses',
                      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)), // ScreenUtil applied
                    ),
                    SizedBox.shrink(),
                  ],
                ),

                SizedBox(height: 20.h), // ScreenUtil applied

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildStep(0, 'assets/images/OrderDetails/OrderCofirmed.png', controller),
                    _buildLine(controller, 1),
                    _buildStep(1, 'assets/images/OrderDetails/Cooking.png', controller),
                    _buildLine(controller, 2),
                    _buildStep(2, 'assets/images/OrderDetails/Sent.png', controller),
                    _buildLine(controller, 3),
                    _buildStep(3, 'assets/images/OrderDetails/Delivered.png', controller),
                  ],
                ),

                SizedBox(height: 20.h), // ScreenUtil applied

                ClipRRect(
                  borderRadius: BorderRadius.circular(16.r), // ScreenUtil applied
                  child: Image.asset(
                    'assets/images/OrderDetails/Cooking.gif',
                    height: 120.h, // ScreenUtil applied
                    width: 120.w,  // ScreenUtil applied
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 10.h), // ScreenUtil applied
                Container(
                  width: 158.w, // ScreenUtil applied
                  height: 32.h, // ScreenUtil applied
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.r), // ScreenUtil applied
                    color: Color(0xFFF4F6F7),
                    border: Border.all(color: Color(0xFFEAECED)),
                  ),
                  child: Center(
                    child: Text(
                      'Order No: ORD-57321',
                      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)), // ScreenUtil applied
                    ),
                  ),
                ),

                SizedBox(height: 20.h), // ScreenUtil applied

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Delivery Details',
                      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: Color(0xFF020711)), // ScreenUtil applied
                    ),
                    SizedBox.shrink()
                  ],
                ),
                SizedBox(height: 10.h), // ScreenUtil applied
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
                                SizedBox(width: 10.w), // ScreenUtil applied
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Italian Panini',
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp), // ScreenUtil applied
                                        ),
                                        SizedBox(width: 10.w), // ScreenUtil applied
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
                                                'Cheddar',
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
                        SizedBox(height: 5.h), // ScreenUtil applied
                        Divider(color: Color(0xFFF2F4F5), thickness: 1),
                        SizedBox(height: 5.h), // ScreenUtil applied
                        CheckoutCard(prefixIcon: 'assets/images/Checkout/Address.png', title: 'Home Address', subTitle: 'Jan van Galenstraat 92, 1056 CC Amsterdam',),
                        SizedBox(height: 5.h), // ScreenUtil applied
                        Divider(color: Color(0xFFF2F4F5), thickness: 1),
                        SizedBox(height: 5.h), // ScreenUtil applied
                        CheckoutCard(prefixIcon: 'assets/images/Checkout/Phone.png', title: 'Phone Number', subTitle: '01234567890',),
                        SizedBox(height: 5.h), // ScreenUtil applied
                        Divider(color: Color(0xFFF2F4F5), thickness: 1),
                        SizedBox(height: 5.h), // ScreenUtil applied
                        CheckoutCard(prefixIcon: 'assets/images/OrderDetails/Track.png', title: 'Estimated Delivery', subTitle: '25 mins',),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 20.h), // ScreenUtil applied

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Order Summary',
                      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: Color(0xFF020711)), // ScreenUtil applied
                    ),
                    SizedBox.shrink()
                  ],
                ),
                SizedBox(height: 10.h), // ScreenUtil applied
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
                                  '\$37.99',
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
                SizedBox(height: 10.h) // ScreenUtil applied
              ],
            ),
          ),
        ),

      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 24)],
          color: Colors.white,
        ),
        child: GradientButton(
          text: 'Show QR Code',
          onPressed: () {
            Get.dialog(PickupView(
              dealImage: 'assets/images/deals/Pizza.jpg',
              dealTitle: '20% Discount',
              dealDescription: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s.',
              dealValidity: '11:59 PM, May 31',
              dealStoreName: 'Pizzeria Bella Italia',
              brandLogo: 'assets/images/deals/details/Starbucks_Logo.png',
            )
            );
          },
          colors: [const Color(0xFFD62828), const Color(0xFFC21414)],
          boxShadow: [const BoxShadow(color: Color(0xFF9A0000), spreadRadius: 1)],
          child: Text(
            'Show QR Code',
            style: TextStyle(
              fontSize: 16.sp,  // Use ScreenUtil for font size
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStep(int step, String icon, TrackOrderController controller) {
    return Obx(
          () {
        return Column(
          children: [
            // Circle representing the current step
            Container(
              width: 40.w,  // ScreenUtil applied
              height: 40.h, // ScreenUtil applied
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: controller.currentStep.value >= step
                    ? Color(0xFFD62828)
                    : Color(0xFFEAECED),
              ),
              child: Image.asset(
                icon,
                color: controller.currentStep.value >= step
                    ? Colors.white
                    : Color(0xFF6F7E8D),
                height: 24.w, // ScreenUtil applied
                width: 24.w,  // ScreenUtil applied
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildLine(TrackOrderController controller, int step) {
    return Obx(
          () {
        return Container(
          height: 2.h,  // ScreenUtil applied
          width: 70.w,  // ScreenUtil applied
          color: controller.currentStep.value >= step
              ? Color(0xFFD62828)
              : Color(0xFFEAECED),
        );
      },
    );
  }
}

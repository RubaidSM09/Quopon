import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quopon/app/modules/OrderDetails/views/track_order_view.dart';
import 'package:quopon/app/modules/OrderDetails/views/view_receipt_view.dart';

import '../../../../common/customTextButton.dart';
import '../controllers/order_details_controller.dart';

class OrderDetailsView extends GetView<OrderDetailsController> {
  const OrderDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    RxBool isDelivery = true.obs;

    return Scaffold(
      backgroundColor: Color(0xFFF9FBFC),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 32, 16, 16),
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
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Color(0xFF020711)),
                  ),
                  SizedBox(),
                ],
              ),

              SizedBox(height: 40,),

              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/images/OrderDetails/OrderConfirmed.gif',
                  height: 80,
                  width: 80,
                ),
              ),
              SizedBox(height: 5,),
              Text(
                'Your Order is Confirmed!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Color(0xFF020711)),
              ),
              SizedBox(height: 5,),
              Text(
                'Your order has been placed successfully. We\'ll notify you when it\'s on the way.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)),
              ),

              SizedBox(height: 20,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Order Details',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xFF020711)),
                  ),
                  SizedBox.shrink()
                ],
              ),

              SizedBox(height: 10,),

              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
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
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  'assets/images/Cart/Italian Panini.png',
                                  width: 62,
                                  height: 62,
                                ),
                              ),
                              SizedBox(width: 10,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Italian Panini',
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                      ),
                                      SizedBox(width: 10,),
                                      Text(
                                        'x2',
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
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
                                            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12, color: Color(0xFF6F7E8D)),
                                          ),
                                          Text(
                                            'a, b, c, d',
                                            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12, color: Color(0xFF6F7E8D)),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Select Spreads: ',
                                            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12, color: Color(0xFF6F7E8D)),
                                          ),
                                          Text(
                                            'Mayo, Ranch, Chipotle',
                                            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12, color: Color(0xFF6F7E8D)),
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
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                        ],
                      ),

                      SizedBox(height: 2.5,),
                      Divider(color: Color(0xFFEAECED), thickness: 1),

                      SizedBox(height: 2.5,),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Order#',
                                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Color(0xFF6F7E8D)),
                              ),
                              Text(
                                '#ORD-57321',
                                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Color(0xFF020711)),
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Order Date',
                                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Color(0xFF6F7E8D)),
                              ),
                              Text(
                                '20 June, 2025',
                                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Color(0xFF020711)),
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Order Time',
                                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Color(0xFF6F7E8D)),
                              ),
                              Text(
                                '01: 09 AM',
                                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Color(0xFF020711)),
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Estimated Time',
                                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Color(0xFF6F7E8D)),
                              ),
                              Text(
                                '10 - 15 mins',
                                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Color(0xFF020711)),
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Delivery Address',
                                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Color(0xFF6F7E8D)),
                              ),
                              SizedBox(
                                width: 171,
                                child: Text(
                                  textAlign: TextAlign.right,
                                  'Jan van Galenstraat 92, 1056 CC Amsterdam',
                                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Color(0xFF020711)),
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

              SizedBox(height: 10,),

              Container(
                width: 500,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Sub Total',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)),
                          ),
                          Text(
                            '\$36.00',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF020711)),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Delivery Charges',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)),
                          ),
                          Text(
                            '\$1.99',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF020711)),
                          ),
                        ],
                      ),
                      Divider(color: Color(0xFFEAECED), thickness: 1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)),
                          ),
                          Row(
                            children: [
                              Container(
                                height: 16,
                                width: 36,
                                decoration: BoxDecoration(
                                  color: Color(0xFF2ECC71),
                                  borderRadius: BorderRadius.circular(4)
                                ),
                                child: Center(
                                  child: Text(
                                    'Paid',
                                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: Colors.white),
                                  ),
                                ),
                              ),
                              SizedBox(width: 5,),
                              Text(
                                '\$37.99',
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF020711)),
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
          padding: EdgeInsets.fromLTRB(16, 16, 16, 32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GradientButton(
                onPressed: () {
                  Get.dialog(ViewReceiptView());
                },
                text: "View Receipt",
                colors: [Color(0xFFF4F5F6), Color(0xFFEEF0F3)],
                width: 185,
                height: 44,
                borderRadius: 12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/OrderDetails/Download.png'
                    ),
                    SizedBox(width: 5,),
                    Text(
                      "View Receipt",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xFF020711)),
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
                width: 185,
                height: 44,
                borderRadius: 12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                        'assets/images/OrderDetails/Track.png'
                    ),
                    SizedBox(width: 5,),
                    Text(
                      "Track Order",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
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

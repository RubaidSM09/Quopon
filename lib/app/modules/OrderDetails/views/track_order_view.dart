import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quopon/app/modules/OrderDetails/controllers/track_order_controller.dart';

import '../../../../common/CheckoutCard.dart';

class TrackOrderView extends GetView<TrackOrderController> {
  const TrackOrderView({super.key});
  @override
  Widget build(BuildContext context) {
    final TrackOrderController controller = Get.put(TrackOrderController());

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
                    'Track Order',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Color(0xFF020711)),
                  ),
                  SizedBox(),
                ],
              ),

              SizedBox(height: 20,),

              Row(
                children: [
                  Text(
                    'Preparing Your Food',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Color(0xFF020711)),
                  ),
                  SizedBox.shrink(),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Real-time updates as your order progresses',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)),
                  ),
                  SizedBox.shrink(),
                ],
              ),

              SizedBox(height: 20,),

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

              SizedBox(height: 20,),

              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/images/OrderDetails/Cooking.gif',
                  height: 120,
                  width: 120,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 10,),
              Container(
                width: 158,
                height: 32,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Color(0xFFF4F6F7),
                  border: Border.all(color: Color(0xFFEAECED))
                ),
                child: Center(
                  child: Text(
                    'Order No: ORD-57321',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)),
                  ),
                ),
              ),

              SizedBox(height: 20,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Delivery Details',
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
                                              'Cheddar',
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
                      SizedBox(height: 5,),
                      Divider(color: Color(0xFFF2F4F5), thickness: 1),
                      SizedBox(height: 5,),
                      CheckoutCard(prefixIcon: 'assets/images/Checkout/Address.png', title: 'Home Address', subTitle: 'Jan van Galenstraat 92, 1056 CC Amsterdam',),
                      SizedBox(height: 5,),
                      Divider(color: Color(0xFFF2F4F5), thickness: 1),
                      SizedBox(height: 5,),
                      CheckoutCard(prefixIcon: 'assets/images/Checkout/Phone.png', title: 'Phone Number', subTitle: '01234567890',),
                      SizedBox(height: 5,),
                      Divider(color: Color(0xFFF2F4F5), thickness: 1),
                      SizedBox(height: 5,),
                      CheckoutCard(prefixIcon: 'assets/images/OrderDetails/Track.png', title: 'Estimated Delivery', subTitle: '25 mins',),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Order Summary',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xFF020711)),
                  ),
                  SizedBox.shrink()
                ],
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
              SizedBox(height: 10,)
            ],
          ),
        ),
      )
    );
  }

  Widget _buildStep(int step, String icon, TrackOrderController controller) {
    return Obx(
          () {
        return Column(
          children: [
            // Circle representing the current step
            Container(
              width: 40,
              height: 40,
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
                height: 24,
                width: 24,
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
          height: 2,
          width: 70,
          color: controller.currentStep.value >= step
              ? Color(0xFFD62828)
              : Color(0xFFEAECED),
        );
      },
    );
  }
}

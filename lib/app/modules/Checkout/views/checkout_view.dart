import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil
import 'package:quopon/app/modules/Checkout/views/checkout_delivery_view.dart';
import 'package:quopon/app/modules/Checkout/views/checkout_pickup_view.dart';
import 'package:quopon/app/modules/OrderDetails/views/order_details_view.dart';
import '../../../../common/customTextButton.dart';
import '../../Cart/controllers/cart_controller.dart';
import '../../Checkout/controllers/checkout_controller.dart';

class CheckoutView extends GetView<CheckoutController> {
  final int? subTotal;
  final double deliveryCharge;

  const CheckoutView({
    required this.subTotal,
    this.deliveryCharge = 0.0,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    Get.put(CheckoutController());

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
                    child: Icon(Icons.arrow_back, size: 24.w), // ScreenUtil applied
                  ),
                  Text(
                    'Checkout',
                    style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500, color: Color(0xFF020711)), // ScreenUtil applied
                  ),
                  SizedBox(),
                ],
              ),
              SizedBox(height: 20.h), // ScreenUtil applied

              Obx(() {
                return Column(
                  children: [
                    Container(
                      height: 48.h, // ScreenUtil applied
                      width: 398.w, // ScreenUtil applied
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r), // ScreenUtil applied
                          color: Color(0xFFF1F3F4)
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(4.w), // ScreenUtil applied
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                if(!isDelivery.value) {
                                  isDelivery.value = !isDelivery.value;
                                }
                              },
                              child: Container(
                                height: 40.h, // ScreenUtil applied
                                width: 185.w, // ScreenUtil applied
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r), // ScreenUtil applied
                                  color: isDelivery.value ? Color(0xFFD62828) : Color(0xFFF1F3F4),
                                ),
                                child: Center(
                                  child: Text(
                                    'Delivery',
                                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: isDelivery.value ? Color(0xFFFFFFFF) : Color(0xFF6F7E8D)), // ScreenUtil applied
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                if(isDelivery.value) {
                                  isDelivery.value = !isDelivery.value;
                                }
                              },
                              child: Container(
                                height: 40.h, // ScreenUtil applied
                                width: 185.w, // ScreenUtil applied
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r), // ScreenUtil applied
                                    color: !isDelivery.value ? Color(0xFFD62828) : Color(0xFFF1F3F4)
                                ),
                                child: Center(
                                  child: Text(
                                    'Pickup',
                                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: !isDelivery.value ? Color(0xFFFFFFFF) : Color(0xFF6F7E8D)), // ScreenUtil applied
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h), // ScreenUtil applied
                    isDelivery.value ? CheckoutDeliveryView(
                      mapLocationImg: 'assets/images/Checkout/Map.png',
                      subTotal: subTotal,
                      deliveryCharge: deliveryCharge,
                    ) : CheckoutPickupView(
                      mapLocationImg: 'assets/images/Checkout/Map.png',
                      subTotal: subTotal,
                    ),
                  ],
                );
              },
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 32.h), // ScreenUtil applied
          child: GradientButton(
            onPressed: () {
              Get.to(OrderDetailsView());
            },
            text: "Follow",
            colors: [Color(0xFFD62828), Color(0xFFC21414)],
            borderRadius: 12.r, // ScreenUtil applied
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Place Order",
                  style: TextStyle(fontSize: 17.5.sp, fontWeight: FontWeight.w500, color: Colors.white), // ScreenUtil applied
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

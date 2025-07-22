import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quopon/app/modules/Checkout/views/checkout_delivery_view.dart';
import 'package:quopon/app/modules/Checkout/views/checkout_pickup_view.dart';
import '../../../../common/customTextButton.dart';
import '../../Cart/controllers/cart_controller.dart';
import '../controllers/checkout_controller.dart';

class CheckoutView extends GetView<CheckoutController> {
  final double subTotal;
  final double deliveryCharge;

  const CheckoutView({
    required this.subTotal,
    this.deliveryCharge = 0.0,
    super.key
  });

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
                      'Cart',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Color(0xFF020711)),
                    ),
                    SizedBox(),
                  ],
                ),
                SizedBox(height: 20,),

                Obx(() {
                  return Column(
                    children: [
                      Container(
                        height: 48,
                        width: 398,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Color(0xFFF1F3F4)
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(4),
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
                                  height: 40,
                                  width: 185,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: isDelivery.value ? Color(0xFFD62828) : Color(0xFFF1F3F4),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Delivery',
                                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: isDelivery.value ? Color(0xFFFFFFFF) : Color(0xFF6F7E8D)),
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
                                  height: 40,
                                  width: 185,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: !isDelivery.value ? Color(0xFFD62828) : Color(0xFFF1F3F4)
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Pickup',
                                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: !isDelivery.value ? Color(0xFFFFFFFF) : Color(0xFF6F7E8D)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
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
          padding: EdgeInsets.fromLTRB(16, 16, 16, 32),
          child: GradientButton(
            onPressed: () {

            },
            text: "Follow",
            colors: [Color(0xFFD62828), Color(0xFFC21414)],
            width: 195,
            height: 44,
            borderRadius: 12,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Place Order",
                  style: TextStyle(fontSize: 17.5, fontWeight: FontWeight.w500, color: Colors.white),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

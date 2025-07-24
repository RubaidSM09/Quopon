import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quopon/app/modules/Cart/views/cart_card_view.dart';
import 'package:quopon/app/modules/Checkout/views/checkout_view.dart';

import '../../../../common/customTextButton.dart';
import '../../Cart/controllers/cart_controller.dart';
import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  const CartView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(CartController());

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
                  Image.asset("assets/images/Cart/Orders.png"),
                ],
              ),
              SizedBox(height: 20,),

              Obx(() {
                if(controller.cart.isEmpty){
                  return const Text("No active add-ons available.");
                }

                return Container(
                  width: 500,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children:
                    controller.cart.asMap().entries.map((entry) {
                        final option = entry.value;
                        final index = entry.key;

                        return Padding(
                          padding: const EdgeInsets.all(12),
                          child: CartCardView(cart: option,),
                        );
                      }).toList(),
                  ),
                );
              }),

              SizedBox(height: 20,),

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
                            '\$${controller.cart.fold(0.0, (sum, cartItem) => sum + cartItem.price).toStringAsFixed(2)}',
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
                          Text(
                            '\$${(controller.cart.fold(0.0, (sum, cartItem) => sum + cartItem.price) + 1.99).toStringAsFixed(2)}',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF020711)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
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
              Get.to(() => CheckoutView(subTotal: controller.cart.fold(0.0, (sum, cartItem) => sum + cartItem.price), deliveryCharge: 1.99));
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
                  "Continue",
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

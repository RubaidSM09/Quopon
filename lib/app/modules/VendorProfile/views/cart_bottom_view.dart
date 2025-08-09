import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../../common/customTextButton.dart';
import '../../Cart/controllers/cart_controller.dart';
import '../../Cart/views/cart_card_view.dart';
import '../../Checkout/views/checkout_view.dart';

class CartBottomView extends GetView<CartController> {
  const CartBottomView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(CartController());
    
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 38.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(12.r), topRight: Radius.circular(12.r)),
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withAlpha(20), blurRadius: 24.r, offset: Offset(0, -4))],
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Cart',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF020711),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(
                    Icons.keyboard_arrow_down_outlined,
                    size: 24.sp,
                    color: Color(0xFF020711),
                  ),
                )
              ],
            ),
        
            SizedBox(height: 20.h,),
        
            Obx(() {
              if(controller.cart.isEmpty){
                return const Text("No active add-ons available.");
              }
        
              return Container(
                width: 500.w, // ScreenUtil applied
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r), // ScreenUtil applied
                  boxShadow: [BoxShadow(color: Colors.black.withAlpha(26), blurRadius: 20.r,)]
                ),
                child: Column(
                  children: controller.cart.asMap().entries.map((entry) {
                    final option = entry.value;
                    final index = entry.key;
        
                    return Padding(
                      padding: EdgeInsets.all(12.w), // ScreenUtil applied
                      child: CartCardView(cart: option),
                    );
                  }).toList(),
                ),
              );
            }),
        
            SizedBox(height: 20.h), // ScreenUtil applied
        
            Container(
              width: 500.w, // ScreenUtil applied
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r), // ScreenUtil applied
                boxShadow: [BoxShadow(color: Colors.black.withAlpha(26), blurRadius: 20.r,)],
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
                          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)),
                        ),
                        Text(
                          '\$${controller.cart.fold(0.0, (sum, cartItem) => sum + cartItem.price).toStringAsFixed(2)}',
                          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: Color(0xFF020711)),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Delivery Charges',
                          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)),
                        ),
                        Text(
                          '\$1.99',
                          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: Color(0xFF020711)),
                        ),
                      ],
                    ),
                    Divider(color: Color(0xFFEAECED), thickness: 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)),
                        ),
                        Text(
                          '\$${(controller.cart.fold(0.0, (sum, cartItem) => sum + cartItem.price) + 1.99).toStringAsFixed(2)}',
                          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: Color(0xFF020711)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 36.h,),

            GradientButton(
              text: 'Continue',
              onPressed: () {
                Get.to(() => CheckoutView(subTotal: controller.cart.fold(0.0, (sum, cartItem) => sum + cartItem.price), deliveryCharge: 1.99));
              },
              colors: [
                const Color(0xFFD62828),
                const Color(0xFFC21414),
              ],
              boxShadow: [
                const BoxShadow(
                  color: Color(0xFF9A0000),
                  spreadRadius: 1,
                ),
              ],
              borderRadius: 12.r,
              child: Text(
                'Continue',
                style: TextStyle(
                  fontSize: 16.sp, // Use ScreenUtil for font size
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

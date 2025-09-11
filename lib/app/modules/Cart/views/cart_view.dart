import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quopon/app/modules/Cart/views/cart_card_view.dart';
import 'package:quopon/app/modules/Checkout/views/checkout_view.dart';

import '../../../../common/customTextButton.dart';
// ✅ Keep only the correct controller import (remove the other to avoid conflicts)
import '../../../data/model/cart.dart';
import '../../Cart/controllers/cart_controller.dart';
// import '../controllers/cart_controller.dart'; // ❌ remove if duplicate

class CartView extends GetView<CartController> {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    // ❌ Don’t create controllers in build()
    // Get.put(CartController());

    String money(num v) => v.toStringAsFixed(2);

    return Scaffold(
      backgroundColor: const Color(0xFFF9FBFC),

      body: Obx(() {
        // Safely derive current cart and data
        final current = controller.cart.isNotEmpty ? controller.cart.first : null;
        final items = current?.items ?? const <Items>[];
        final summary = current?.priceSummary;

        final subTotal = (summary?.subTotalPrice ?? 0).toDouble();
        final delivery = (summary?.deliveryCharges ?? 0).toDouble();
        final total = (summary?.inTotalPrice ?? (subTotal + delivery)).toDouble();

        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16.w, 32.h, 16.w, 16.h),
            child: Column(
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: Get.back,
                      child: Icon(Icons.arrow_back, size: 24.sp),
                    ),
                    Text(
                      'Cart',
                      style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500, color: const Color(0xFF020711)),
                    ),
                    Image.asset("assets/images/Cart/Orders.png", width: 24.w, height: 24.h),
                  ],
                ),

                SizedBox(height: 20.h),

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
                            if(!controller.isDelivery.value) {
                              controller.isDelivery.value = !controller.isDelivery.value;
                            }
                          },
                          child: Container(
                            height: 40.h, // ScreenUtil applied
                            width: 185.w, // ScreenUtil applied
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r), // ScreenUtil applied
                              color: controller.isDelivery.value ? Color(0xFFD62828) : Color(0xFFF1F3F4),
                            ),
                            child: Center(
                              child: Text(
                                'Delivery',
                                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: controller.isDelivery.value ? Color(0xFFFFFFFF) : Color(0xFF6F7E8D)), // ScreenUtil applied
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if(controller.isDelivery.value) {
                              controller.isDelivery.value = !controller.isDelivery.value;
                            }
                          },
                          child: Container(
                            height: 40.h, // ScreenUtil applied
                            width: 185.w, // ScreenUtil applied
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r), // ScreenUtil applied
                                color: !controller.isDelivery.value ? Color(0xFFD62828) : Color(0xFFF1F3F4)
                            ),
                            child: Center(
                              child: Text(
                                'Pickup',
                                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: !controller.isDelivery.value ? Color(0xFFFFFFFF) : Color(0xFF6F7E8D)), // ScreenUtil applied
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 20.h),

                // Items
                if (items.isEmpty)
                  const Text("Your cart is empty.")
                else
                  Container(
                    width: 500.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Column(
                      children: List.generate(items.length, (i) {
                        return Padding(
                          padding: EdgeInsets.all(12.w),
                          child: CartCardView(items: items[i]),
                        );
                      }),
                    ),
                  ),

                SizedBox(height: 20.h),

                // Price summary (only when a cart exists)
                if (current != null)
                  Container(
                    width: 500.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(12.w),
                      child: Column(
                        children: [
                          _priceRow('Sub Total', '\$${money(subTotal)}'),
                          _priceRow('Delivery Charges', '\$${money(delivery)}'),
                          const Divider(color: Color(0xFFEAECED), thickness: 1),
                          _priceRow('Total', '\$${money(total)}'),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      }),

      bottomNavigationBar: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 32.h), // ScreenUtil applied
          child: GradientButton(
            onPressed: () {
              Get.to(() => CheckoutView(subTotal: (controller.cart[0].priceSummary!.subTotalPrice)!.toInt(), deliveryCharge: 1.99));
            },
            text: "Follow",
            colors: [Color(0xFFD62828), Color(0xFFC21414)],
            borderRadius: 12.r, // ScreenUtil applied
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Continue",
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

Widget _priceRow(String left, String right) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(left, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: const Color(0xFF6F7E8D))),
      Text(right, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: const Color(0xFF020711))),
    ],
  );
}
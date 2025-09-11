import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../../common/customTextButton.dart';
import '../../../data/model/cart.dart';
import '../../Cart/controllers/cart_controller.dart';
import '../../Cart/views/cart_card_view.dart';
import '../../Checkout/views/checkout_view.dart';

class CartBottomView extends GetView<CartController> {
  const CartBottomView({super.key});

  @override
  Widget build(BuildContext context) {
    String money(num v) => v.toStringAsFixed(2);
    Get.put(CartController());

    return Obx(() {
      final current = controller.currentCart;
      final items = current?.items ?? const <Items>[];
      final summary = current?.priceSummary;

      // Coerce to double for formatting
      final subTotal = (summary?.subTotalPrice ?? 0).toInt();
      final delivery = (summary?.deliveryCharges ?? 0).toDouble();
      final total = (summary?.inTotalPrice ?? (subTotal + delivery)).toDouble();

      return Container(
        padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 38.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(12.r), topRight: Radius.circular(12.r)),
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black.withAlpha(20), blurRadius: 24.r, offset: const Offset(0, -4))],
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Cart', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500, color: const Color(0xFF020711))),
                  GestureDetector(
                    onTap: Get.back,
                    child: Icon(Icons.keyboard_arrow_down_outlined, size: 24.sp, color: const Color(0xFF020711)),
                  ),
                ],
              ),

              SizedBox(height: 20.h),

              // Items
              if (items.isEmpty)
                const Text('Your cart is empty.')
              else
                Container(
                  width: 500.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [BoxShadow(color: Colors.black.withAlpha(26), blurRadius: 20.r)],
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

              // Price summary (only when we have a cart)
              if (current != null) ...[
                Container(
                  width: 500.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [BoxShadow(color: Colors.black.withAlpha(26), blurRadius: 20.r)],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(12.w),
                    child: Column(
                      children: [
                        _row('Sub Total', '\$${money(subTotal)}'),
                        _row('Delivery Charges', '\$${money(delivery)}'),
                        const Divider(color: Color(0xFFEAECED), thickness: 1),
                        _row('Total', '\$${money(total)}'),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 36.h),

                GradientButton(
                  text: 'Continue',
                  onPressed: () {
                    Get.to(() => CheckoutView(
                      subTotal: subTotal,
                      deliveryCharge: delivery,
                    ));
                  },
                  colors: const [Color(0xFFD62828), Color(0xFFC21414)],
                  boxShadow: const [BoxShadow(color: Color(0xFF9A0000), spreadRadius: 1)],
                  borderRadius: 12.r,
                  child: Text('Continue', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: Colors.white)),
                ),
              ],
            ],
          ),
        ),
      );
    });
  }
}

Widget _row(String left, String right) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(left, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: const Color(0xFF6F7E8D))),
      Text(right, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: const Color(0xFF020711))),
    ],
  );
}

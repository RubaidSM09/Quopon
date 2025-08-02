import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quopon/app/modules/Cart/controllers/cart_controller.dart';

class CartCardView extends GetView {
  final Cart cart;

  const CartCardView({
    required this.cart,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r), // ScreenUtil applied
              child: Image.asset(
                cart.image!,
                width: 62.w, // ScreenUtil applied
                height: 62.h, // ScreenUtil applied
              ),
            ),
            SizedBox(width: 10.w), // ScreenUtil applied
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cart.title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp), // ScreenUtil applied
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: cart.selectedAddons!.asMap().entries.map((entry) {
                    final option = entry.value;

                    return Row(
                      children: [
                        Text(
                          'Select ${option.selectTitle}: ',
                          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12.sp, color: Color(0xFF6F7E8D)), // ScreenUtil applied
                        ),
                        Text(
                          option.selectOptions.join(", "),
                          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12.sp, color: Color(0xFF6F7E8D)), // ScreenUtil applied
                        ),
                      ],
                    );
                  }).toList(),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () { },
                      icon: Image.asset('assets/images/Cart/Delete.png', width: 24.w, height: 24.h), // ScreenUtil applied
                    ),
                    Text(
                      '0${cart.quantity}',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp), // ScreenUtil applied
                    ),
                    IconButton(
                      onPressed: () { },
                      icon: Image.asset('assets/images/Cart/Add.png', width: 24.w, height: 24.h), // ScreenUtil applied
                    ),
                  ],
                )
              ],
            )
          ],
        ),
        Text(
          '\$${cart.price}',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp), // ScreenUtil applied
        ),
      ],
    );
  }
}

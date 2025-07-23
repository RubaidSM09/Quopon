import 'package:flutter/material.dart';

import 'package:get/get.dart';
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
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                cart.image!,
                width: 62,
                height: 62,
              ),
            ),
            SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cart.title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: cart.selectedAddons!.asMap().entries.map((entry) {
                    final option = entry.value;

                    return Row(
                      children: [
                        Text(
                          'Select ${option.selectTitle}: ',
                          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12, color: Color(0xFF6F7E8D)),
                        ),
                        Text(
                          option.selectOptions.join(", "),
                          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12, color: Color(0xFF6F7E8D)),
                        ),
                      ],
                    );
                  }).toList(),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () { },
                      icon: Image.asset('assets/images/Cart/Delete.png'),
                    ),
                    Text(
                      '0${cart.quantity}',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    IconButton(
                      onPressed: () { },
                      icon: Image.asset('assets/images/Cart/Add.png'),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
        Text(
          '\$${cart.price}',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
      ],
    );
  }
}

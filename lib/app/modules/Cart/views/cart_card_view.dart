import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quopon/app/modules/Cart/controllers/cart_controller.dart';

import '../../../data/model/cart.dart';

class CartCardView extends GetView {
  final Items items;

  const CartCardView({
    required this.items,
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
              child: Image.network(
                items.menuItem!.imageUrl!,
                width: 62.w, // ScreenUtil applied
                height: 62.h, // ScreenUtil applied
              ),
            ),
            SizedBox(width: 10.w), // ScreenUtil applied
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  items.menuItem!.name!,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp), // ScreenUtil applied
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: items.selectedOptions!.asMap().entries.map((entry) {
                    final option = entry.value;

                    return Row(
                      children: [
                        Text(
                          'Select ${option.name}: ',
                          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12.sp, color: Color(0xFF6F7E8D)), // ScreenUtil applied
                        ),
                        Text(
                          option.name!,
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
                      '0${items.quantity}',
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
          '\$${items.addToCartPrice}',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp), // ScreenUtil applied
        ),
      ],
    );
  }
}

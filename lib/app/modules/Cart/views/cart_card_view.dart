// lib/app/modules/Cart/views/cart_card_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Cart/controllers/cart_controller.dart';
import '../../../data/model/cart.dart';

class CartCardView extends GetView<CartController> {
  final Items items;

  const CartCardView({
    required this.items,
    super.key,
  });

  String _money(num v) => v.toStringAsFixed(2);

  @override
  Widget build(BuildContext context) {
    final imageUrl = items.image;
    final title = items.title;
    final qty = items.quantity;
    final note = items.specialInstructions;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: imageUrl.isNotEmpty
                  ? Image.network(
                imageUrl,
                width: 62.w,
                height: 62.h,
                fit: BoxFit.cover,
              )
                  : Container(
                width: 62.w,
                height: 62.h,
                color: const Color(0xFFEAEAEA),
                child: const Icon(Icons.image_not_supported),
              ),
            ),
            SizedBox(width: 10.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),

                if (note.isNotEmpty) ...[
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Text(
                        'Note: ',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                          color: const Color(0xFF6F7E8D),
                        ),
                      ),
                      Text(
                        note,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                          color: const Color(0xFF6F7E8D),
                        ),
                      ),
                    ],
                  ),
                ],

                SizedBox(height: 6.h),

                Row(
                  children: [
                    // Delete
                    IconButton(
                      onPressed: () => controller.removeItem(items.id),
                      icon: Image.asset(
                        'assets/images/Cart/Delete.png',
                        width: 24.w,
                        height: 24.h,
                      ),
                    ),

                    // NEW: Decrease (use Icon)
                    IconButton(
                      onPressed: () => controller.decrementItem(items.id),
                      icon: const Icon(
                        Icons.remove,
                        color: Colors.black87,
                      ),
                      iconSize: 20.sp,
                    ),

                    // Quantity
                    Text(
                      '0$qty',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                      ),
                    ),

                    // Increase
                    IconButton(
                      onPressed: () => controller.incrementItem(items.id),
                      icon: Image.asset(
                        'assets/images/Cart/Add.png',
                        width: 24.w,
                        height: 24.h,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        Text(
          '\$${_money(items.itemTotal)}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14.sp,
          ),
        ),
      ],
    );
  }
}

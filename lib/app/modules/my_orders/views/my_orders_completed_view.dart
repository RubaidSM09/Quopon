import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../data/model/order.dart';
import 'my_orders_card_view.dart';

class MyOrdersCompletedView extends GetView {
  final List<Order> orders;
  const MyOrdersCompletedView({super.key, required this.orders});

  String _cap(String? s) => s == null || s.isEmpty ? 'Unknown' : s[0].toUpperCase() + s.substring(1).toLowerCase();

  @override
  Widget build(BuildContext context) {
    if (orders.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 24.h),
        child: Text(
          'No completed orders',
          style: TextStyle(color: const Color(0xFF6F7E8D), fontSize: 14.sp),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: orders.length,
      separatorBuilder: (_, __) => SizedBox(height: 8.h),
      itemBuilder: (context, i) {
        final o = orders[i];
        final price = double.tryParse(o.totalAmount ?? '0.0') ?? 0.0;
        String productName = o.items.isNotEmpty ? (o.items[0].itemName ?? 'No item name') : 'No items';
        if (o.items.length > 1) {
          productName += ' and ${o.items.length - 1} more';
        }
        String imageUrl = o.items.isNotEmpty ? (o.items[0].itemImage ?? '') : '';
        return MyOrdersCardView(
          itemImg: imageUrl,
          itemName: productName,
          orderId: '#${o.orderId ?? 'Unknown'}'.substring(0, 8),
          price: price,
          orderType: _cap(o.deliveryType),
          status: o.status ?? 'COMPLETED', // Pass status
        );
      },
    );
  }
}
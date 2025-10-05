import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quopon/app/modules/my_orders/views/my_orders_card_view.dart';
import '../../../data/model/order.dart';

class MyOrdersActiveView extends StatelessWidget {
  final List<Order> orders;
  const MyOrdersActiveView({super.key, required this.orders});

  String _cap(String s) => s.isEmpty ? s : s[0].toUpperCase() + s.substring(1).toLowerCase();

  @override
  Widget build(BuildContext context) {
    if (orders.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 24.h),
        child: Text(
          'No active orders',
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
        final price = double.tryParse(o.totalAmount!) ?? 0.0;
        String productName = o.items.isNotEmpty ? (o.items[0].itemName ?? 'No item name') : 'No items';
        if (o.items.length > 1) {
          productName += ' and ${o.items.length - 1} more';
        }
        String imageUrl = o.items.isNotEmpty ? (o.items[0].itemImage ?? '') : '';
        return MyOrdersCardView(
          itemImg: imageUrl,
          itemName: productName,
          orderId: o.orderId ?? 'Unknown',
          price: price,
          orderType: _cap(o.deliveryType ?? 'Unknown'),
          status: o.status ?? 'ACTIVE', // Pass status
        );
      },
    );
  }
}
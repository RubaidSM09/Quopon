import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'my_orders_card_view.dart';

class MyOrdersCancelledView extends GetView {
  const MyOrdersCancelledView({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyOrdersCardView(
          itemImg: 'assets/images/my_orders/Shakes.png',
          itemName: '50% OFF Any Grande Beverage',
          orderId: '#ORD-57321',
          price: 9.99,
          orderType: 'Delivery',
        ),

        SizedBox(height: 8.h,),

        MyOrdersCardView(
          itemImg: 'assets/images/my_orders/Shakes.png',
          itemName: '50% OFF Any Grande Beverage',
          orderId: '#ORD-57321',
          price: 9.99,
          orderType: 'Pickup',
        ),

        SizedBox(height: 8.h,),

        MyOrdersCardView(
          itemImg: 'assets/images/my_orders/Shakes.png',
          itemName: '50% OFF Any Grande Beverage',
          orderId: '#ORD-57321',
          price: 9.99,
          orderType: 'Pickup',
        ),

        SizedBox(height: 8.h,),

        MyOrdersCardView(
          itemImg: 'assets/images/my_orders/Shakes.png',
          itemName: '50% OFF Any Grande Beverage',
          orderId: '#ORD-57321',
          price: 9.99,
          orderType: 'Delivery',
        ),

        SizedBox(height: 8.h,),

        MyOrdersCardView(
          itemImg: 'assets/images/my_orders/Shakes.png',
          itemName: '50% OFF Any Grande Beverage',
          orderId: '#ORD-57321',
          price: 9.99,
          orderType: 'Pickup',
        ),
      ],
    );
  }
}

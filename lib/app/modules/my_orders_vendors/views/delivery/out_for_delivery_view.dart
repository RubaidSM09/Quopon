import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../my_orders_vendor_card_view.dart';

class OutForDeliveryView extends GetView {
  RxString selectedDate;
  List<String> categories;

  OutForDeliveryView({
    super.key
  }) : selectedDate = 'Today'.obs, categories = ['Today', 'Yesterday', 'Last Week', 'Last Month'];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Date: ',
              style: TextStyle(
                color: Color(0xFF020711),
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
            ),
            Obx(() {
              // Using Obx to automatically update UI when selectedDate changes
              return Flexible(
                fit: FlexFit.loose,
                child: DropdownButton<String>(
                  value: selectedDate.value,
                  isExpanded: true,
                  underline: Container(),
                  items: categories.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp, color: Color(0xFF6F7E8D)),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    // Update selected value in the controller
                    selectedDate.value = newValue!;
                  },
                ),
              );
            }),
          ],
        ),

        SizedBox(height: 8.h,),

        MyOrdersVendorCardView(
          itemImg: 'assets/images/Cart/Italian Panini.png',
          itemName: 'Italian Panini',
          itemAddons: {'Cheese':['Cheddar'], 'Spreads':['Mayo', 'Ranch', 'Chipotle']},
          isNew: true,
          status: 'Delivery',
          customerName: 'Mubashir Saleem',
          orderItem: 'Item Name/Deal Name',
          quantity: 2,
          totalAmount: 9.99,
          orderTime: '03 Aug 2025, 5:49 PM',
          orderStatus: 'Out for Delivery',
        ),

        SizedBox(height: 8.h,),

        MyOrdersVendorCardView(
          itemImg: 'assets/images/Cart/Italian Panini.png',
          itemName: 'Italian Panini',
          itemAddons: {'Cheese':['Cheddar'], 'Spreads':['Mayo', 'Ranch', 'Chipotle']},
          status: 'Delivery',
          customerName: 'Mubashir Saleem',
          orderItem: 'Item Name/Deal Name',
          quantity: 2,
          totalAmount: 9.99,
          orderTime: '03 Aug 2025, 5:49 PM',
          orderStatus: 'Out for Delivery',
        ),

        SizedBox(height: 8.h,),

        MyOrdersVendorCardView(
          itemImg: 'assets/images/Cart/Italian Panini.png',
          itemName: 'Italian Panini',
          itemAddons: {'Cheese':['Cheddar'], 'Spreads':['Mayo', 'Ranch', 'Chipotle']},
          status: 'Delivery',
          customerName: 'Mubashir Saleem',
          orderItem: 'Item Name/Deal Name',
          quantity: 2,
          totalAmount: 9.99,
          orderTime: '03 Aug 2025, 5:49 PM',
          orderStatus: 'Out for Delivery',
        ),

        SizedBox(height: 8.h,),
      ],
    );
  }
}

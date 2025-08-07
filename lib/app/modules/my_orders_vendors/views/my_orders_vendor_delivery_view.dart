import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'my_orders_vendor_card_view.dart';

class MyOrdersVendorDeliveryView extends GetView {
  const MyOrdersVendorDeliveryView({super.key});
  @override
  Widget build(BuildContext context) {
    RxList<RxBool> filters = [true.obs, false.obs, false.obs, false.obs, false.obs, false.obs].obs;
    return Obx(() {
      return Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    for (int i=0; i<6; i++) {
                      filters[i].value = false;
                    }
                    filters[0].value = true;
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.r),
                      color: filters[0].value ? Color(0xFFD62828) : Colors.white,
                      boxShadow: [BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 12.r)],
                    ),
                    child: Text(
                      'Order Received (03)',
                      style: TextStyle(
                        color: filters[0].value ? Colors.white : Color(0xFF6F7E8D),
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 8.w,),

                GestureDetector(
                  onTap: () {
                    for (int i=0; i<6; i++) {
                      filters[i].value = false;
                    }
                    filters[1].value = true;
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.r),
                      color: filters[1].value ? Color(0xFFD62828) : Colors.white,
                      boxShadow: [BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 12.r)],
                    ),
                    child: Text(
                      'In Preparation (04)',
                      style: TextStyle(
                        color: filters[1].value ? Colors.white : Color(0xFF6F7E8D),
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 8.w,),

                GestureDetector(
                  onTap: () {
                    for (int i=0; i<6; i++) {
                      filters[i].value = false;
                    }
                    filters[2].value = true;
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.r),
                      color: filters[2].value ? Color(0xFFD62828) : Colors.white,
                      boxShadow: [BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 12.r)],
                    ),
                    child: Text(
                      'Ready for Pickup (03)',
                      style: TextStyle(
                        color: filters[2].value ? Colors.white : Color(0xFF6F7E8D),
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 8.w,),

                GestureDetector(
                  onTap: () {
                    for (int i=0; i<6; i++) {
                      filters[i].value = false;
                    }
                    filters[3].value = true;
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.r),
                      color: filters[3].value ? Color(0xFFD62828) : Colors.white,
                      boxShadow: [BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 12.r)],
                    ),
                    child: Text(
                      'Picked Up (02)',
                      style: TextStyle(
                        color: filters[3].value ? Colors.white : Color(0xFF6F7E8D),
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 8.w,),

                GestureDetector(
                  onTap: () {
                    for (int i=0; i<6; i++) {
                      filters[i].value = false;
                    }
                    filters[4].value = true;
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.r),
                      color: filters[4].value ? Color(0xFFD62828) : Colors.white,
                      boxShadow: [BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 12.r)],
                    ),
                    child: Text(
                      'Completed (51)',
                      style: TextStyle(
                        color: filters[4].value ? Colors.white : Color(0xFF6F7E8D),
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 8.w,),

                GestureDetector(
                  onTap: () {
                    for (int i=0; i<6; i++) {
                      filters[i].value = false;
                    }
                    filters[5].value = true;
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.r),
                      color: filters[5].value ? Color(0xFFD62828) : Colors.white,
                      boxShadow: [BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 12.r)],
                    ),
                    child: Text(
                      'Cancelled (05)',
                      style: TextStyle(
                        color: filters[5].value ? Colors.white : Color(0xFF6F7E8D),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 16.h,),

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
            orderStatus: 'Order Received',
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
            orderStatus: 'Order Received',
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
            orderStatus: 'Order Received',
          ),

          SizedBox(height: 8.h,),
        ],
      );
    });
  }
}

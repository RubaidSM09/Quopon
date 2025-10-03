import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/Get.dart';

import '../../controllers/my_orders_vendors_controller.dart';
import '../my_orders_vendor_card_view.dart';
import 'delivery_order_received_view.dart';

class DeliveryCancelledView extends GetView<MyOrdersVendorsController> {
  DeliveryCancelledView({super.key});

  final RxString selectedDate = 'Today'.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var filtered = controller.orders.where((o) => o.deliveryType == 'DELIVERY' && o.status == 'CANCELLED' && isDateMatch(selectedDate.value, o.createdAt)).toList();
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
              Flexible(
                fit: FlexFit.loose,
                child: DropdownButton<String>(
                  value: selectedDate.value,
                  isExpanded: true,
                  underline: Container(),
                  items: ['Today', 'Yesterday', 'Last Week', 'Last Month'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp, color: Color(0xFF6F7E8D)),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    selectedDate.value = newValue!;
                  },
                ),
              ),
            ],
          ),

          SizedBox(height: 8.h,),

          ...filtered.map((order) => Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: MyOrdersVendorCardView(
              itemImg: order.items.isNotEmpty ? order.items[0].itemImage : '',
              itemName: order.items.isNotEmpty ? order.items[0].itemName : '',
              isNew: false,
              status: 'Delivery',
              customerName: 'Customer #${order.user}',
              orderItem: order.items.map((i) => '${i.itemName} x${i.quantity}').join(', '),
              quantity: order.items.fold(0, (sum, i) => sum + i.quantity),
              totalAmount: double.parse(order.totalAmount),
              orderTime: formatDate(order.createdAt),
              orderStatus: order.status,
              note: order.note ?? 'No notes',
              orderId: order.orderId, // Pass orderId
            ),
          )).toList(),
        ],
      );
    });
  }
}

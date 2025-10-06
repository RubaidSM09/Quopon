import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../common/customTextButton.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // ScreenUtil
import '../controllers/order_details_controller.dart';

class ViewReceiptView extends GetView<OrderDetailsController> {
  const ViewReceiptView({super.key});

  String _money(String v) {
    // API sends numbers as strings (e.g., "12.00")
    final d = double.tryParse(v) ?? 0.0;
    return d.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    // Ensure controller is available (it’s already put in OrderDetailsView)
    final c = Get.find<OrderDetailsController>();

    // Derive dynamic fields
    final invoiceNumber = c.orderId.isNotEmpty ? c.orderId : (c.order.value?['id']?.toString() ?? '—');
    final orderTimeFull = '${c.orderTime}, ${c.orderDate}';
    final paymentStatusPretty = (c.paymentStatus.toUpperCase() == 'PAID')
        ? 'Successful'
        : (c.paymentStatus.isEmpty ? '—' : c.paymentStatus[0].toUpperCase() + c.paymentStatus.substring(1).toLowerCase());
    final paymentMethod = (c.paymentStatus.toUpperCase() == 'PAID') ? 'Online' : '—';

    // Totals
    final subtotal = '\$${_money(c.subtotal)}';
    final deliveryFee = '\$${_money(c.deliveryFee)}';
    final discount = c.discountAmount == '0.00' ? '—' : '\$${_money(c.discountAmount)}';
    final totalAmount = '\$${_money(c.totalAmount)}';

    final items = c.items; // list<Map<String, dynamic>>

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        height: 664.h,
        width: 398.w,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(16.r), topRight: Radius.circular(16.r)),
          image: const DecorationImage(
            image: AssetImage('assets/images/OrderDetails/PaymentSuccessContainer.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: [
            // Close
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox.shrink(),
                GestureDetector(onTap: Get.back, child: const Icon(Icons.close)),
              ],
            ),

            // Header GIF + Title
            Image.asset('assets/images/OrderDetails/Receipt.gif', height: 80.h, width: 80.w),
            SizedBox(height: 17.h),
            Text('Payment Successful',
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500, color: const Color(0xFF020711))),

            SizedBox(height: 17.h),
            const DottedLine(dashColor: Color(0xFFEAECED), lineThickness: 1.0, dashLength: 6.0, dashGapLength: 6.0),
            SizedBox(height: 17.h),

            // Payment Details
            Row(
              children: [
                Text('Payment Details',
                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: const Color(0xFF020711))),
                const SizedBox.shrink(),
              ],
            ),

            SizedBox(height: 10.h),

            // Invoice Number
            _kvRow(
              left: 'Invoice Number',
              right: invoiceNumber,
            ),

            SizedBox(height: 10.h),

            // Order Time
            _kvRow(
              left: 'Order Time',
              right: orderTimeFull,
            ),

            SizedBox(height: 10.h),

            // Payment Method
            _kvRow(
              left: 'Payment Method',
              right: paymentMethod,
            ),

            SizedBox(height: 10.h),

            // Payment Status
            _kvRow(
              left: 'Payment Status',
              right: paymentStatusPretty,
            ),

            SizedBox(height: 10.h),

            // Amount (Total)
            _kvRow(
              left: 'Amount',
              right: totalAmount,
            ),

            SizedBox(height: 17.h),
            const DottedLine(dashColor: Color(0xFFEAECED), lineThickness: 1.0, dashLength: 6.0, dashGapLength: 6.0),
            SizedBox(height: 17.h),

            // Product Details
            Row(
              children: [
                Text('Product Details',
                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: const Color(0xFF020711))),
                const SizedBox.shrink(),
              ],
            ),

            SizedBox(height: 10.h),

            // Items (name x qty : total_price)
            ...List.generate(items.length, (i) {
              final it = items[i];
              final name = (it['item_name'] ?? '').toString();
              final qty = (it['quantity'] is int)
                  ? it['quantity'] as int
                  : int.tryParse('${it['quantity']}') ?? 0;
              final total = '\$${_money((it['total_price'] ?? '0').toString())}';

              return Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: _kvRow(
                  left: '$name x$qty',
                  right: total,
                  leftWidth: 150.w,
                  rightWidth: 130.w,
                ),
              );
            }),

            // Delivery Charges
            _kvRow(
              left: 'Delivery Charges',
              right: deliveryFee,
              leftWidth: 150.w,
              rightWidth: 130.w,
            ),

            SizedBox(height: 10.h),

            // Applied Deal Discount
            _kvRow(
              left: 'Applied Deal Discount',
              right: discount,
              leftWidth: 150.w,
              rightWidth: 130.w,
            ),

            SizedBox(height: 10.h),

            // Total Amount (again at bottom)
            _kvRow(
              left: 'Total Amount',
              right: totalAmount,
              leftWidth: 150.w,
              rightWidth: 130.w,
            ),

            SizedBox(height: 17.h),
            const DottedLine(dashColor: Color(0xFFEAECED), lineThickness: 1.0, dashLength: 6.0, dashGapLength: 6.0),
            SizedBox(height: 17.h),

            // Get PDF Receipt (kept same)
            GradientButton(
              onPressed: () {}, // hook up when backend is ready
              text: "Get PDF Receipt",
              colors: const [Color(0xFFF4F5F6), Color(0xFFEEF0F3)],
              height: 52.h,
              borderRadius: 12.r,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/OrderDetails/Download.png'),
                  SizedBox(width: 5.w),
                  Text("Get PDF Receipt",
                      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: const Color(0xFF020711))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Key/Value row like your static layout
  Widget _kvRow({
    required String left,
    required String right,
    double? leftWidth,
    double? rightWidth,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: leftWidth ?? 110.w,
          child: Text(
            left,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: const Color(0xFF6F7E8D)),
          ),
        ),
        Text(':', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp, color: const Color(0xFF020711))),
        SizedBox(
          width: rightWidth ?? 170.w,
          child: Text(
            right,
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp, color: const Color(0xFF020711)),
          ),
        ),
      ],
    );
  }
}

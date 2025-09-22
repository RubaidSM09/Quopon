import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quopon/app/modules/OrderDetails/views/track_order_view.dart';
import 'package:quopon/app/modules/OrderDetails/views/view_receipt_view.dart';
import '../../../../../../common/customTextButton.dart';
import '../controllers/order_details_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderDetailsView extends GetView<OrderDetailsController> {
  const OrderDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OrderDetailsController());
    RxBool isDelivery = true.obs;

    return Scaffold(
      backgroundColor: const Color(0xFFF9FBFC),
      body: Obx(() {
        if (controller.error.value != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Get.snackbar("Order", controller.error.value!);
          });
        }

        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16.w, 32.h, 16.w, 16.h),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: const Icon(Icons.arrow_back),
                    ),
                    Text(
                      'Order Details',
                      style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500, color: const Color(0xFF020711)),
                    ),
                    const SizedBox(),
                  ],
                ),

                SizedBox(height: 40.h),

                ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: Image.asset(
                    'assets/images/OrderDetails/OrderConfirmed.gif',
                    height: 80.h,
                    width: 80.w,
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  'Your Order is Confirmed!',
                  style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500, color: const Color(0xFF020711)),
                ),
                SizedBox(height: 5.h),
                Text(
                  'Your order has been placed successfully. We\'ll notify you when it\'s on the way.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400, color: const Color(0xFF6F7E8D)),
                ),

                SizedBox(height: 20.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Order Details',
                      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: const Color(0xFF020711)),
                    ),
                    const SizedBox.shrink()
                  ],
                ),

                SizedBox(height: 10.h),

                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      children: [
                        /// ---------- ALL ORDER ITEMS ----------
                        ...List.generate(controller.items.length, (index) {
                          final it = controller.items[index];
                          final name = it['item_name']?.toString() ?? '—';
                          final qty = (it['quantity'] is int)
                              ? it['quantity'] as int
                              : int.tryParse('${it['quantity']}') ?? 0;
                          final price = it['total_price']?.toString() ?? '0.00';
                          final desc = it['item_description']?.toString() ?? '';
                          final image = it['item_image']?.toString() ?? 'assets/images/Cart/Italian Panini.png';

                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8.r),
                                        child: Image.network(
                                          // API doesn't return image; keep your placeholder
                                          image,
                                          width: 62.w,
                                          height: 62.h,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(width: 10.w),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                name,
                                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                                              ),
                                              SizedBox(width: 10.w),
                                              Text(
                                                'x$qty',
                                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
                                              ),
                                            ],
                                          ),
                                          if (desc.isNotEmpty) ...[
                                            SizedBox(height: 6.h),
                                            Text(
                                              desc,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12.sp,
                                                color: const Color(0xFF6F7E8D),
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '\$$price',
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
                                  ),
                                ],
                              ),
                              // Divider between items (but not after the last one)
                              if (index != controller.items.length - 1) ...[
                                SizedBox(height: 8.h),
                                const Divider(color: Color(0xFFEAECED), thickness: 1),
                                SizedBox(height: 8.h),
                              ],
                            ],
                          );
                        }),

                        SizedBox(height: 8.h),
                        const Divider(color: Color(0xFFEAECED), thickness: 1),
                        SizedBox(height: 8.h),

                        /// ---------- META FIELDS ----------
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _muted('Order#'),
                            _strong(controller.orderId.isEmpty ? '#—' : controller.orderId),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _muted('Order Date'),
                            _strong(controller.orderDate),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _muted('Order Time'),
                            _strong(controller.orderTime),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _muted('Order Type'),
                            _strong(controller.deliveryType.isEmpty ? '—' : controller.deliveryType),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _muted('Estimated Time'),
                            _strong('10 - 15 mins'),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _muted('Delivery Address'),
                            SizedBox(
                              width: 171.w,
                              child: Text(
                                controller.deliveryAddress.isEmpty ? '—' : controller.deliveryAddress,
                                textAlign: TextAlign.right,
                                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp, color: const Color(0xFF020711)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 10.h),

                // totals (bound to API)
                Container(
                  width: 500.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(12.w),
                    child: Column(
                      children: [
                        _totalRow('Sub Total', '\$${controller.subtotal}'),
                        _totalRow('Delivery Charges', '\$${controller.deliveryFee}'),
                        _totalRow('Applied Deal Discount', '\$${controller.discountAmount}'),
                        const Divider(color: Color(0xFFEAECED), thickness: 1),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _muted('Total'),
                            Row(
                              children: [
                                Container(
                                  height: 16.h,
                                  width: 36.w,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF2ECC71),
                                    borderRadius: BorderRadius.circular(4.r),
                                  ),
                                  child: Center(
                                    child: Text('Paid',
                                        style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w500, color: Colors.white)),
                                  ),
                                ),
                                SizedBox(width: 5.w),
                                _strong('\$${controller.totalAmount}'),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),

      bottomNavigationBar: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 32.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GradientButton(
                onPressed: () => Get.dialog(const ViewReceiptView()),
                text: "View Receipt",
                colors: const [Color(0xFFF4F5F6), Color(0xFFEEF0F3)],
                width: 200.w,
                borderRadius: 12.r,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/OrderDetails/Download.png'),
                    SizedBox(width: 5.w),
                    Text(
                      "View Receipt",
                      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: const Color(0xFF020711)),
                    )
                  ],
                ),
              ),
              GradientButton(
                onPressed: () => Get.to(const TrackOrderView()),
                text: "Follow",
                colors: const [Color(0xFFD62828), Color(0xFFC21414)],
                width: 200.w,
                borderRadius: 12.r,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/OrderDetails/Track.png'),
                    SizedBox(width: 5.w),
                    Text(
                      "Track Order",
                      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: Colors.white),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _muted(String s) => Text(
    s,
    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp, color: const Color(0xFF6F7E8D)),
  );

  Widget _strong(String s) => Text(
    s,
    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp, color: const Color(0xFF020711)),
  );

  Widget _totalRow(String l, String r) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      _muted(l),
      _strong(r),
    ],
  );
}

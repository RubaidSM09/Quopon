import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil
import 'package:quopon/app/modules/ChooseRedemptionDeal/views/pickup_view.dart';

import '../../../../common/CheckoutCard.dart';
import '../../../../common/customTextButton.dart';
import '../../OrderDetails/controllers/track_order_controller.dart';

class TrackOrderView extends GetView<TrackOrderController> {
  TrackOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    final TrackOrderController controller = Get.put(TrackOrderController());

    return Scaffold(
      backgroundColor: Color(0xFFF9FBFC),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 32.h, 16.w, 16.h),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(Icons.arrow_back, size: 24.w),
                  ),
                  Text(
                    'Track Order',
                    style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500, color: Color(0xFF020711)),
                  ),
                  SizedBox(),
                ],
              ),

              SizedBox(height: 20.h),

              Row(
                children: [
                  Obx(() => Text(
                    controller.title.value,
                    style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500, color: Color(0xFF020711)),
                  )),
                  SizedBox.shrink(),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Real-time updates as your order progresses',
                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)),
                  ),
                  SizedBox.shrink(),
                ],
              ),

              SizedBox(height: 20.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildStep(0, 'assets/images/OrderDetails/OrderConfirmed.png', controller),
                  _buildLine(controller, 1),
                  _buildStep(1, 'assets/images/OrderDetails/Cooking.png', controller),
                  _buildLine(controller, 2),
                  _buildStep(2, 'assets/images/OrderDetails/Sent.png', controller),
                  _buildLine(controller, 3),
                  _buildStep(3, 'assets/images/OrderDetails/Delivered.png', controller),
                ],
              ),

              SizedBox(height: 20.h),

              Obx(() => ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: Image.asset(
                  controller.gif.value,
                  height: 120.h,
                  width: 120.w,
                  fit: BoxFit.cover,
                ),
              )),
              SizedBox(height: 10.h),
              Obx(() => Container(
                width: 158.w,
                height: 32.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.r),
                  color: Color(0xFFF4F6F7),
                  border: Border.all(color: Color(0xFFEAECED)),
                ),
                child: Center(
                  child: Text(
                    'Order No: ${controller.orderData['order_id'] ?? '—'}',
                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)),
                  ),
                ),
              )),

              SizedBox(height: 20.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Delivery Details',
                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: Color(0xFF020711)),
                  ),
                  SizedBox.shrink()
                ],
              ),
              SizedBox(height: 10.h),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    color: Colors.white
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    children: [
                      // ---------- ITEMS WITH MODIFIERS INSTEAD OF DESCRIPTION ----------
                      Obx(() => Column(
                        children: (controller.orderData['items'] as List? ?? [])
                            .map<Widget>((raw) {
                          final it = raw as Map<String, dynamic>;
                          final name = (it['item_name'] ?? '—').toString();
                          final qty = (it['quantity'] ?? 0).toString();
                          final price = (it['total_price'] ?? '0.00').toString();
                          final image = (it['item_image'] ?? 'assets/images/Cart/Italian Panini.png').toString();

                          final modifiers = (it['modifiers'] as List? ?? [])
                              .whereType<Map<String, dynamic>>()
                              .toList();

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

                                          // --- REPLACED DESCRIPTION WITH MODIFIERS ---
                                          if (modifiers.isNotEmpty) ...[
                                            SizedBox(height: 6.h),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: modifiers.map((m) {
                                                final gName = (m['group_name'] ?? '').toString();
                                                final selected = (m['selected_options'] as List? ?? [])
                                                    .map((e) => e.toString())
                                                    .where((e) => e.isNotEmpty)
                                                    .join(', ');
                                                if (gName.isEmpty || selected.isEmpty) return const SizedBox.shrink();
                                                return Padding(
                                                  padding: EdgeInsets.only(bottom: 4.h),
                                                  child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        'Select $gName: ',
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.w400,
                                                          fontSize: 12.sp,
                                                          color: const Color(0xFF6F7E8D),
                                                        ),
                                                      ),
                                                      Text(
                                                        selected,
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.w400,
                                                          fontSize: 12.sp,
                                                          color: const Color(0xFF6F7E8D),
                                                        ),
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          ],
                                        ],
                                      )
                                    ],
                                  ),
                                  Text(
                                    '\$$price',
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5.h),
                              Divider(color: Color(0xFFF2F4F5), thickness: 1),
                              SizedBox(height: 5.h),
                            ],
                          );
                        }).toList(),
                      )),

                      Obx(() => CheckoutCard(
                        prefixIcon: 'assets/images/Checkout/Address.png',
                        title: 'Home Address',
                        subTitle: controller.orderData['delivery_address'] ?? '—',
                      )),
                      SizedBox(height: 5.h),
                      Divider(color: Color(0xFFF2F4F5), thickness: 1),
                      SizedBox(height: 5.h),
                      CheckoutCard(prefixIcon: 'assets/images/Checkout/Phone.png', title: 'Phone Number', subTitle: '01234567890',),
                      SizedBox(height: 5.h),
                      Divider(color: Color(0xFFF2F4F5), thickness: 1),
                      SizedBox(height: 5.h),
                      Obx(() => CheckoutCard(
                        prefixIcon: 'assets/images/OrderDetails/Track.png',
                        title: 'Estimated Delivery',
                        subTitle: controller.orderData['estimated_delivery_time'] ?? '25 mins',
                      )),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Order Summary',
                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: Color(0xFF020711)),
                  ),
                  SizedBox.shrink()
                ],
              ),
              SizedBox(height: 10.h),
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
                      Obx(() => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Sub Total',
                            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)),
                          ),
                          Text(
                            '\$${controller.orderData['subtotal'] ?? '0.00'}',
                            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: Color(0xFF020711)),
                          ),
                        ],
                      )),
                      Obx(() => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Delivery Charges',
                            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)),
                          ),
                          Text(
                            '\$${controller.orderData['delivery_fee'] ?? '0.00'}',
                            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: Color(0xFF020711)),
                          ),
                        ],
                      )),
                      Divider(color: Color(0xFFEAECED), thickness: 1),
                      Obx(() => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total',
                            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)),
                          ),
                          Row(
                            children: [
                              Container(
                                height: 16.h,
                                width: 36.w,
                                decoration: BoxDecoration(
                                    color: Color(0xFF2ECC71),
                                    borderRadius: BorderRadius.circular(4.r)
                                ),
                                child: Center(
                                  child: Text(
                                    'Paid',
                                    style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w500, color: Colors.white),
                                  ),
                                ),
                              ),
                              SizedBox(width: 5.w),
                              Text(
                                '\$${controller.orderData['total_amount'] ?? '0.00'}',
                                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: Color(0xFF020711)),
                              ),
                            ],
                          ),
                        ],
                      )),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.h)
            ],
          ),
        ),
      ),

      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 24)],
          color: Colors.white,
        ),
        child: Obx(() {
          final qr = (controller.orderData['qr_code'] as Map<String, dynamic>?) ?? const {};
          final qrImage = qr['image'];
          final verifyCode = controller.orderData['delivery_code'];
          return GradientButton(
            text: 'Show QR Code',
            onPressed: () {
              Get.dialog(PickupView(
                qRCodeImage: qrImage,
                verificationCOde: verifyCode,
              ));
            },
            colors: [const Color(0xFFD62828), const Color(0xFFC21414)],
            boxShadow: [const BoxShadow(color: Color(0xFF9A0000), spreadRadius: 1)],
            child: Text(
              'Show QR Code',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildStep(int step, String icon, TrackOrderController controller) {
    return Obx(
          () => Column(
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 500),
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: controller.currentStep.value >= step
                  ? Color(0xFFD62828)
                  : Color(0xFFEAECED),
            ),
            child: TweenAnimationBuilder<Color?>(
              duration: Duration(milliseconds: 500),
              tween: ColorTween(
                end: controller.currentStep.value >= step ? Colors.white : Color(0xFF6F7E8D),
              ),
              builder: (context, color, _) {
                return Center(
                  child: Image.asset(
                    icon,
                    color: color,
                    height: 24.w,
                    width: 24.w,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLine(TrackOrderController controller, int step) {
    return Obx(
          () => AnimatedContainer(
        duration: Duration(milliseconds: 500),
        height: 2.h,
        width: 70.w,
        color: controller.currentStep.value >= step
            ? Color(0xFFD62828)
            : Color(0xFFEAECED),
      ),
    );
  }
}

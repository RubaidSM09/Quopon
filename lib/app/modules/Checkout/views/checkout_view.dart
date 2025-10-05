import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quopon/app/modules/Checkout/views/checkout_delivery_view.dart';
import 'package:quopon/app/modules/Checkout/views/checkout_pickup_view.dart';
import '../../../../common/customTextButton.dart';
import '../../Checkout/controllers/checkout_controller.dart';

class CheckoutView extends GetView<CheckoutController> {
  final int? subTotal;          // legacy from Cart (int)
  final double deliveryCharge;  // legacy from Cart
  final int vendorId;

  const CheckoutView({
    required this.subTotal,
    this.deliveryCharge = 0.0,
    required this.vendorId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Get.put(CheckoutController());

    // hydrate controller once
    controller.setBaseInputs(
      subTotal: (subTotal ?? 0).toDouble(),
      delivery: deliveryCharge,
      vendorId: vendorId,
    );
    controller.hydrateForVendor(vendorId);

    RxBool isDelivery = true.obs;

    return Scaffold(
      backgroundColor: const Color(0xFFF9FBFC),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 32.h, 16.w, 16.h),
          child: Column(
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(onTap: Get.back, child: Icon(Icons.arrow_back, size: 24.w)),
                  Text('Checkout',
                      style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500, color: const Color(0xFF020711))),
                  const SizedBox(width: 24),
                ],
              ),
              SizedBox(height: 20.h),

              // Toggle Delivery / Pickup
              Obx(() {
                return Container(
                  height: 48.h,
                  width: 398.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    color: const Color(0xFFF1F3F4),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(4.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () { if (!isDelivery.value) isDelivery.value = true; },
                          child: Container(
                            height: 40.h, width: 185.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              color: isDelivery.value ? const Color(0xFFD62828) : const Color(0xFFF1F3F4),
                            ),
                            child: Center(
                              child: Text('Delivery',
                                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500,
                                      color: isDelivery.value ? const Color(0xFFFFFFFF) : const Color(0xFF6F7E8D))),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () { if (isDelivery.value) isDelivery.value = false; },
                          child: Container(
                            height: 40.h, width: 185.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              color: !isDelivery.value ? const Color(0xFFD62828) : const Color(0xFFF1F3F4),
                            ),
                            child: Center(
                              child: Text('Pickup',
                                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500,
                                      color: !isDelivery.value ? const Color(0xFFFFFFFF) : const Color(0xFF6F7E8D))),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
              SizedBox(height: 10.h),

              // Body panes
              Obx(() => isDelivery.value
                  ? CheckoutDeliveryView(
                mapLocationImg: 'assets/images/Checkout/Map.png',
                subTotal: subTotal,                  // legacy: child still accepts int?
                deliveryCharge: deliveryCharge,
              )
                  : CheckoutPickupView(
                mapLocationImg: 'assets/images/Checkout/Map.png',
                subTotal: subTotal,
              )),
            ],
          ),
        ),
      ),

      // Place Order button
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 32.h),
          child: GradientButton(
            onPressed: () {
              controller.placeOrderAndPay(
                isDelivery: isDelivery.value,
                note: controller.noteController.text,
              );
            },
            text: "Follow",
            colors: const [Color(0xFFD62828), Color(0xFFC21414)],
            borderRadius: 12.r,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.lock_outline, size: 18, color: Colors.white),
                SizedBox(width: 8.w),
                Text("Place Order",
                    style:
                    TextStyle(fontSize: 17.5.sp, fontWeight: FontWeight.w500, color: Colors.white)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

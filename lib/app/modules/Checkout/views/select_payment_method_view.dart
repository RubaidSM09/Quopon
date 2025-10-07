import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil
import '../../../../common/PaymentCard.dart';
import '../../Checkout/controllers/checkout_controller.dart';

void showPaymentMethodDialog(BuildContext context) {
  final controller = Get.find<CheckoutController>();

  Get.bottomSheet(
    Container(
      height: 260.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(16.r), topLeft: Radius.circular(16.r),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 8.h, left: 16.w, right: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Select Payment Method',
                    style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
                IconButton(onPressed: Get.back, icon: const Icon(Icons.close)),
              ],
            ),
          ),
          const Divider(color: Color(0xFFEAECED), thickness: 1),

          // ✅ Only two options: Cash & Online Mollie Payment
          Expanded(
            child: Obx(() {
              return ListView(
                children: [
                  ListTile(
                    title: PaymentCard(
                      logo: 'assets/images/Payment Method/Cash.png',
                      name: 'Cash',
                      isSelected: controller.selectedPaymentMethod.value == 'Cash',
                      onTap: () {
                        controller.updatePaymentMethod(
                          'Cash',
                          'assets/images/Payment Method/Cash.png',
                        );
                      },
                    ),
                  ),
                  ListTile(
                    title: PaymentCard(
                      logo: 'assets/images/Payment Method/Stripe.png', // use any Mollie icon asset you have
                      name: 'Online Mollie Payment',
                      isSelected: controller.selectedPaymentMethod.value == 'Online Mollie Payment',
                      onTap: () {
                        controller.updatePaymentMethod(
                          'Online Mollie Payment',
                          'assets/images/Payment Method/Stripe.png',
                        );
                      },
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    ),
  );
}

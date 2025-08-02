import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil
import '../../../../common/PaymentCard.dart';
import '../../Checkout/controllers/checkout_controller.dart';

void showPaymentMethodDialog(BuildContext context) {
  final controller = Get.find<CheckoutController>();

  Get.bottomSheet(
    Container(
      height: 420.h, // ScreenUtil applied
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topRight: Radius.circular(16.r), topLeft: Radius.circular(16.r),) // ScreenUtil applied
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 8.h, left: 16.w, right: 16.w), // ScreenUtil applied
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Select Payment Method',
                  style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold), // ScreenUtil applied
                ),
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(Icons.close),
                )
              ],
            ),
          ),
          Divider(color: Color(0xFFEAECED), thickness: 1),
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
                        controller.updatePaymentMethod('Cash', 'assets/images/Payment Method/Cash.png',);
                      },
                    ),
                  ),
                  ListTile(
                    title: PaymentCard(
                      logo: 'assets/images/Payment Method/Stripe.png',
                      name: 'Stripe',
                      isSelected: controller.selectedPaymentMethod.value == 'Stripe',
                      onTap: () {
                        controller.updatePaymentMethod('Stripe', 'assets/images/Payment Method/Stripe.png',);
                      },
                    ),
                  ),
                  ListTile(
                    title: PaymentCard(
                      logo: 'assets/images/Payment Method/iDeal.png',
                      name: 'iDeal',
                      isSelected: controller.selectedPaymentMethod.value == 'iDeal',
                      onTap: () {
                        controller.updatePaymentMethod('iDeal', 'assets/images/Payment Method/iDeal.png',);
                      },
                    ),
                  ),
                  ListTile(
                    title: PaymentCard(
                      logo: 'assets/images/Payment Method/Apple Pay.png',
                      name: 'Apple Pay',
                      isSelected: controller.selectedPaymentMethod.value == 'Apple Pay',
                      onTap: () {
                        controller.updatePaymentMethod('Apple Pay', 'assets/images/Payment Method/Apple Pay.png',);
                      },
                    ),
                  ),
                  ListTile(
                    title: PaymentCard(
                      logo: 'assets/images/Payment Method/Google Pay.png',
                      name: 'Google Pay',
                      isSelected: controller.selectedPaymentMethod.value == 'Google Pay',
                      onTap: () {
                        controller.updatePaymentMethod('Google Pay', 'assets/images/Payment Method/Google Pay.png',);
                      },
                    ),
                  ),
                  ListTile(
                    title: PaymentCard(
                      logo: 'assets/images/Payment Method/Paypal.png',
                      name: 'Paypal',
                      isSelected: controller.selectedPaymentMethod.value == 'Paypal',
                      onTap: () {
                        controller.updatePaymentMethod('Paypal', 'assets/images/Payment Method/Paypal.png',);
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

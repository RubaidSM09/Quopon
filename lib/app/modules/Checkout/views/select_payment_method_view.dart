import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/PaymentCard.dart';
import '../controllers/checkout_controller.dart';

void showPaymentMethodDialog(BuildContext context) {
  final controller = Get.find<CheckoutController>();
  
  Get.bottomSheet(
    Container(
      height: 420,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topRight: Radius.circular(16), topLeft: Radius.circular(16),)
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Select Payment Method',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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

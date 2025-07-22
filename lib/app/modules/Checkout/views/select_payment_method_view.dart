import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/PaymentCard.dart';
import '../controllers/checkout_controller.dart';

void showPaymentMethodDialog(BuildContext context) {
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
            child: ListView(
              children: [
                ListTile(
                  title: PaymentCard(logo: 'assets/images/Payment Method/Stripe.png', name: 'Stripe',),
                  onTap: () {
                    Get.find<CheckoutController>().updatePaymentMethod("Stripe");
                    Get.back();  // Close the bottom sheet
                  },
                ),
                ListTile(
                  title: PaymentCard(logo: 'assets/images/Payment Method/iDeal.png', name: 'iDeal',),
                  onTap: () {
                    Get.find<CheckoutController>().updatePaymentMethod("iDeal");
                    Get.back();  // Close the bottom sheet
                  },
                ),
                ListTile(
                  title: PaymentCard(logo: 'assets/images/Payment Method/Apple Pay.png', name: 'Apple Pay',),
                  onTap: () {
                    Get.find<CheckoutController>().updatePaymentMethod("Apple Pay");
                    Get.back();  // Close the bottom sheet
                  },
                ),
                ListTile(
                  title: PaymentCard(logo: 'assets/images/Payment Method/Google Pay.png', name: 'Google Pay',),
                  onTap: () {
                    Get.find<CheckoutController>().updatePaymentMethod("Google Pay");
                    Get.back();  // Close the bottom sheet
                  },
                ),
                ListTile(
                  title: PaymentCard(logo: 'assets/images/Payment Method/Paypal.png', name: 'Paypal',),
                  onTap: () {
                    Get.find<CheckoutController>().updatePaymentMethod("PayPal");
                    Get.back();  // Close the bottom sheet
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil
import 'package:quopon/app/modules/Checkout/views/select_payment_method_view.dart';
import 'package:quopon/common/CheckoutCard.dart';
import 'package:quopon/common/customTextButton.dart';

import '../../../../common/custom_textField.dart';
import '../controllers/checkout_controller.dart';

class CheckoutDeliveryView extends GetView {
  final int? subTotal;
  final double deliveryCharge;
  final String mapLocationImg;

  CheckoutDeliveryView({
    required this.subTotal,
    required this.deliveryCharge,
    required this.mapLocationImg,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    RxBool isStandard = true.obs;
    final checkoutCtl = Get.find<CheckoutController>();

    return Column(
      children: [
        Container(
          width: 398.w, // ScreenUtil applied
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r), // ScreenUtil applied
            boxShadow: [BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 16.r)],
          ),
          child: Padding(
            padding: EdgeInsets.all(12.w), // ScreenUtil applied
            child: Column(
              children: [
                SizedBox(
                  width: 398.w, // ScreenUtil applied
                  height: 140.h, // ScreenUtil applied
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.r), // ScreenUtil applied
                    child: Image.asset(
                      mapLocationImg,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 10.h), // ScreenUtil applied

                // Address from controller
                Obx(() {
                  final addr = checkoutCtl.deliveryAddress.value;
                  return CheckoutCard(
                    prefixIcon: 'assets/images/Checkout/Address.png',
                    title: 'Home Address',
                    subTitle: addr.isEmpty ? '—' : addr,
                    suffixIcon: 'assets/images/Checkout/Edit.png',
                  );
                }),
                const Divider(color: Color(0xFFEAECED), thickness: 1),

                CheckoutCard(prefixIcon: 'assets/images/Checkout/Phone.png', title: 'Phone Number', subTitle: '01234567890', suffixIcon: 'assets/images/Checkout/Edit.png',),
                const Divider(color: Color(0xFFEAECED), thickness: 1),
                CheckoutCard(prefixIcon: 'assets/images/Checkout/Time.png', title: 'Delivery Time', subTitle: '10 - 20 mins', suffixIcon: 'assets/images/Checkout/Edit.png',),
                const Divider(color: Color(0xFFEAECED), thickness: 1),
                CheckoutCard(prefixIcon: 'assets/images/Checkout/Deals.png', title: 'Use Deal', subTitle: 'No deal selected', suffixIcon: 'assets/images/Checkout/UseDeal.png',),
                const Divider(color: Color(0xFFEAECED), thickness: 1),

                SizedBox(height: 20.h), // ScreenUtil applied
                Obx(() {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (!isStandard.value) {
                            isStandard.value = !isStandard.value;
                          }
                        },
                        child: Container(
                          height: 72.h, // ScreenUtil applied
                          width: 175.w, // ScreenUtil applied
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r), // ScreenUtil applied
                            border: BoxBorder.all(
                              color: isStandard.value ? const Color(0xFFD62828) : const Color(0xFFEAECED),
                              width: 1.6.w, // ScreenUtil applied
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 16.w), // ScreenUtil applied
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Standard', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: const Color(0xFF020711))),
                                Text('10 - 20 mins', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: const Color(0xFF6F7E8D))),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (isStandard.value) {
                            isStandard.value = !isStandard.value;
                          }
                        },
                        child: Container(
                          height: 72.h, // ScreenUtil applied
                          width: 175.w, // ScreenUtil applied
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r), // ScreenUtil applied
                            border: BoxBorder.all(
                              color: isStandard.value ? const Color(0xFFEAECED) : const Color(0xFFD62828),
                              width: 1.6.w, // ScreenUtil applied
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 16.w), // ScreenUtil applied
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Schedule', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: const Color(0xFF020711))),
                                Text('Select', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: const Color(0xFF6F7E8D))),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
                SizedBox(height: 20.h), // ScreenUtil applied
                const Divider(color: Color(0xFFEAECED), thickness: 1),
                SizedBox(height: 20.h), // ScreenUtil applied

                // Payment
                Column(
                  children: [
                    Row(
                      children: [
                        Text('Payment', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: const Color(0xFF020711))), // ScreenUtil applied
                        const SizedBox.shrink(),
                      ],
                    ),
                    SizedBox(height: 10.h), // ScreenUtil applied
                    GestureDetector(
                      onTap: () {
                        showPaymentMethodDialog(context);
                      },
                      child: Obx(() {
                        final method = Get.find<CheckoutController>().selectedPaymentMethod.value;
                        final logo = Get.find<CheckoutController>().selectedPaymentMethodLogo.value;

                        return Container(
                          height: 48.h, // ScreenUtil applied
                          width: 374.w, // ScreenUtil applied
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r), // ScreenUtil applied
                            border: Border.all(width: 1.w, color: const Color(0xFFEAECED)), // ScreenUtil applied
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(8.w), // ScreenUtil applied
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                method.isEmpty
                                    ? Text(
                                  'Select Payment Method',
                                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: const Color(0xFF6F7E8D)), // ScreenUtil applied
                                )
                                    : Row(
                                  children: [
                                    Container(
                                      width: 40.w, // ScreenUtil applied
                                      height: 40.h, // ScreenUtil applied
                                      decoration: const BoxDecoration(color: Color(0xFFF5F7F8), shape: BoxShape.circle),
                                      child: ClipRRect(child: Image.asset(logo)),
                                    ),
                                    SizedBox(width: 10.w), // ScreenUtil applied
                                    Text(
                                      method,
                                      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: const Color(0xFF020711)), // ScreenUtil applied
                                    ),
                                  ],
                                ),
                                method.isEmpty ? const Icon(Icons.add, color: Color(0xFF6F7E8D)) : const Icon(Icons.refresh, color: Color(0xFF6F7E8D)),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),

                SizedBox(height: 20.h), // ScreenUtil applied

                // Note field — use shared controller so parent can read it
                GetInTouchTextField(
                  headingText: 'Add Note',
                  headingTextSize: 20,
                  fieldText: 'Write here...',
                  iconImagePath: '',
                  controller: checkoutCtl.noteController,
                  isRequired: false,
                  maxLine: 6,
                )
              ],
            ),
          ),
        ),

        SizedBox(height: 20.h), // ScreenUtil applied

        Container(
          width: 500.w, // ScreenUtil applied
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r), // ScreenUtil applied
            boxShadow: [BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 16.r)],
          ),
          child: Padding(
            padding: EdgeInsets.all(12.w), // ScreenUtil applied
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Sub Total', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: const Color(0xFF6F7E8D))), // ScreenUtil applied
                    Text('\$$subTotal', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: const Color(0xFF020711))), // ScreenUtil applied
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Delivery Charges', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: const Color(0xFF6F7E8D))), // ScreenUtil applied
                    Text('\$$deliveryCharge', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: const Color(0xFF020711))), // ScreenUtil applied
                  ],
                ),
                const Divider(color: Color(0xFFEAECED), thickness: 1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: const Color(0xFF6F7E8D))), // ScreenUtil applied
                    Text('\$${(subTotal! + deliveryCharge).toStringAsFixed(2)}', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: const Color(0xFF020711))), // ScreenUtil applied
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

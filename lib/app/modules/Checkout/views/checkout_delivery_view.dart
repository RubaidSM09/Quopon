import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quopon/app/modules/Checkout/views/select_payment_method_view.dart';
import 'package:quopon/common/CheckoutCard.dart';
import 'package:quopon/common/customTextButton.dart';

import '../controllers/checkout_controller.dart';

class CheckoutDeliveryView extends GetView {
  final double subTotal;
  final double deliveryCharge;
  final String mapLocationImg;

  const CheckoutDeliveryView({
    required this.subTotal,
    required this.deliveryCharge,
    required this.mapLocationImg,
    super.key
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 398,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12)
          ),
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                SizedBox(
                  width: 398,
                  height: 140,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      mapLocationImg,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 10,),

                CheckoutCard(prefixIcon: 'assets/images/Checkout/Address.png', title: 'Home Address', subTitle: 'Jan van Galenstraat 92, 1056 CC Amsterdam', suffixIcon: 'assets/images/Checkout/Edit.png',),
                Divider(color: Color(0xFFEAECED), thickness: 1),
                CheckoutCard(prefixIcon: 'assets/images/Checkout/Phone.png', title: 'Phone Number', subTitle: '01234567890', suffixIcon: 'assets/images/Checkout/Edit.png',),
                Divider(color: Color(0xFFEAECED), thickness: 1),
                CheckoutCard(prefixIcon: 'assets/images/Checkout/Time.png', title: 'Delivery Time', subTitle: '10 - 20 mins', suffixIcon: 'assets/images/Checkout/Edit.png',),
                Divider(color: Color(0xFFEAECED), thickness: 1),
                CheckoutCard(prefixIcon: 'assets/images/Checkout/Deals.png', title: 'Use Deal', subTitle: 'No deal selected', suffixIcon: 'assets/images/Checkout/UseDeal.png',),
                Divider(color: Color(0xFFEAECED), thickness: 1),

                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 72,
                      width: 175,
                      decoration:BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: BoxBorder.all(
                          color: Color(0xFFD62828),
                          width: 1.6,
                        )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Standard',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF020711)),
                            ),
                            Text(
                              '10 - 20 mins',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)),
                            ),
                          ],
                        ),
                      )
                    ),
                    Container(
                      height: 72,
                      width: 175,
                      decoration:BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: BoxBorder.all(
                            color: Color(0xFFEAECED),
                            width: 1.6,
                          )
                      ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Schedule',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF020711)),
                              ),
                              Text(
                                'Select',
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)),
                              ),
                            ],
                          ),
                        )
                    )
                  ],
                ),
                SizedBox(height: 20,),
                Divider(color: Color(0xFFEAECED), thickness: 1),
                SizedBox(height: 20,),

                Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Payment',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF020711)),
                        ),
                        SizedBox.shrink(),
                      ],
                    ),
                    SizedBox(height: 10,),
                    GestureDetector(
                      onTap: () {
                        showPaymentMethodDialog(context);
                      },
                      child: Obx(() {
                        final method = Get.find<CheckoutController>().selectedPaymentMethod.value;
                        final logo = Get.find<CheckoutController>().selectedPaymentMethodLogo.value;

                        return Container(
                          height: 48,
                          width: 374,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  width: 1, color: Color(0xFFEAECED))
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                method.isEmpty ? Text(
                                  'Select Payment Method',
                                  style: TextStyle(fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF6F7E8D)),
                                ) : Row(
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          color: Color(0xFFF5F7F8),
                                          shape: BoxShape.circle
                                      ),
                                      child: ClipRRect(
                                        child: Image.asset(logo),
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    Text(
                                      method,
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF020711)),
                                    ),
                                  ],
                                ),
                                method.isEmpty ? Icon(Icons.add, color: Color(0xFF6F7E8D),)
                                : Icon(Icons.refresh, color: Color(0xFF6F7E8D),),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: 20,),

        Container(
          width: 500,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Sub Total',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)),
                    ),
                    Text(
                      '\$$subTotal',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF020711)),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Delivery Charges',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)),
                    ),
                    Text(
                      '\$$deliveryCharge',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF020711)),
                    ),
                  ],
                ),
                Divider(color: Color(0xFFEAECED), thickness: 1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)),
                    ),
                    Text(
                      '\$${(subTotal + deliveryCharge).toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF020711)),
                    ),
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

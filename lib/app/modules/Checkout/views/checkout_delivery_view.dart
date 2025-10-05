import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quopon/app/modules/Checkout/views/select_payment_method_view.dart';
import 'package:quopon/common/CheckoutCard.dart';
import 'package:quopon/common/customTextButton.dart';
import 'package:quopon/common/custom_textField.dart';
import '../controllers/checkout_controller.dart';

class CheckoutDeliveryView extends GetView<CheckoutController> {
  final int? subTotal;          // legacy (not used directly anymore)
  final double deliveryCharge;  // legacy (not used directly anymore)
  final String mapLocationImg;

  CheckoutDeliveryView({
    required this.subTotal,
    required this.deliveryCharge,
    required this.mapLocationImg,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ctl = Get.find<CheckoutController>();

    return Column(
      children: [
        Container(
          width: 398.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 16.r)],
          ),
          child: Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              children: [
                // Map
                SizedBox(
                  width: 398.w,
                  height: 140.h,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: Image.asset(mapLocationImg, fit: BoxFit.cover),
                  ),
                ),
                SizedBox(height: 10.h),

                // Address (editable) — use currentAddress (fallback: profileAddress)
                Obx(() {
                  final addr = ctl.currentAddress.value.isNotEmpty
                      ? ctl.currentAddress.value
                      : ctl.profileAddress.value;
                  return CheckoutCard(
                    prefixIcon: 'assets/images/Checkout/Address.png',
                    title: 'Home Address',
                    subTitle: addr.isEmpty ? '—' : addr,
                    suffixIcon: 'assets/images/Checkout/Edit.png',
                    onTap: () => ctl.editTextDialog(
                      title: 'Edit Address',
                      initial: addr,
                      onSave: (s) => ctl.currentAddress.value = s,
                    ),
                  );
                }),
                const Divider(color: Color(0xFFEAECED), thickness: 1),

                // Phone (editable)
                Obx(() {
                  final phone = ctl.phoneNumber.value;
                  return CheckoutCard(
                    prefixIcon: 'assets/images/Checkout/Phone.png',
                    title: 'Phone Number',
                    subTitle: phone.isEmpty ? 'Add phone number' : phone,
                    suffixIcon: 'assets/images/Checkout/Edit.png',
                    onTap: () => ctl.editTextDialog(
                      title: 'Edit Phone',
                      initial: phone,
                      inputType: TextInputType.phone,
                      onSave: (s) => ctl.phoneNumber.value = s,
                    ),
                  );
                }),
                const Divider(color: Color(0xFFEAECED), thickness: 1),

                // Delivery Time (ETA or scheduled)
                Obx(() {
                  final isSch = ctl.isScheduled.value;
                  final when = ctl.scheduledAt.value;
                  final eta = ctl.etaMinutes.value;
                  final subtitle = isSch && when != null
                      ? 'Scheduled: ${when.toLocal()}'
                      : (eta > 0 ? '~ $eta mins' : 'Calculating...');
                  return CheckoutCard(
                    prefixIcon: 'assets/images/Checkout/Time.png',
                    title: 'Delivery Time',
                    subTitle: subtitle,
                    suffixIcon: 'assets/images/Checkout/Edit.png',
                    onTap: () {
                      ctl.isScheduled.toggle();
                      if (ctl.isScheduled.value) ctl.pickSchedule();
                    },
                  );
                }),
                const Divider(color: Color(0xFFEAECED), thickness: 1),

                // Use Deal
                Obx(() {
                  final deal = ctl.selectedDeal.value;
                  return CheckoutCard(
                    prefixIcon: 'assets/images/Checkout/Deals.png',
                    title: 'Use Deal',
                    subTitle: deal == null ? 'No deal selected' : deal.title,
                    suffixIcon: 'assets/images/Checkout/UseDeal.png',
                    onTap: ctl.showDealPickerDialog,
                  );
                }),
                const Divider(color: Color(0xFFEAECED), thickness: 1),

                SizedBox(height: 20.h),

                // Standard / Schedule tiles (visual selector)
                Obx(() {
                  final isStandard = !ctl.isScheduled.value;
                  final eta = ctl.etaMinutes.value;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => ctl.isScheduled.value = false,
                        child: Container(
                          height: 72.h, width: 175.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: isStandard ? const Color(0xFFD62828) : const Color(0xFFEAECED),
                              width: 1.6.w,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 16.w),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Standard', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
                                Text(eta > 0 ? '~ $eta mins' : 'Calculating...', style: TextStyle(fontSize: 14.sp, color: const Color(0xFF6F7E8D))),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          ctl.isScheduled.value = true;
                          await ctl.pickSchedule();
                        },
                        child: Container(
                          height: 72.h, width: 175.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: isStandard ? const Color(0xFFEAECED) : const Color(0xFFD62828),
                              width: 1.6.w,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 16.w),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Schedule', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
                                Text('Select', style: TextStyle(fontSize: 14.sp, color: const Color(0xFF6F7E8D))),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
                SizedBox(height: 20.h),
                const Divider(color: Color(0xFFEAECED), thickness: 1),
                SizedBox(height: 20.h),

                // Payment
                Column(
                  children: [
                    Row(children: [
                      Text('Payment', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
                    ]),
                    SizedBox(height: 10.h),
                    GestureDetector(
                      onTap: () => showPaymentMethodDialog(context),
                      child: Obx(() {
                        final method = ctl.selectedPaymentMethod.value;
                        final logo = ctl.selectedPaymentMethodLogo.value;
                        return Container(
                          height: 48.h,
                          width: 374.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(width: 1.w, color: const Color(0xFFEAECED)),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(8.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                method.isEmpty
                                    ? Text('Select Payment Method',
                                    style: TextStyle(fontSize: 14.sp, color: const Color(0xFF6F7E8D)))
                                    : Row(children: [
                                  Container(
                                    width: 40.w, height: 40.h,
                                    decoration: const BoxDecoration(color: Color(0xFFF5F7F8), shape: BoxShape.circle),
                                    child: logo.isEmpty ? const SizedBox() : ClipRRect(child: Image.asset(logo)),
                                  ),
                                  SizedBox(width: 10.w),
                                  Text(method, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
                                ]),
                                Icon(method.isEmpty ? Icons.add : Icons.refresh, color: const Color(0xFF6F7E8D)),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),

                SizedBox(height: 20.h),

                // Note field — shared controller
                GetInTouchTextField(
                  headingText: 'Add Note',
                  headingTextSize: 20,
                  fieldText: 'Write here...',
                  iconImagePath: '',
                  controller: ctl.noteController,
                  isRequired: false,
                  maxLine: 6,
                )
              ],
            ),
          ),
        ),

        SizedBox(height: 20.h),

        // Totals (reactive)
        Obx(() {
          String money(num v) => v.toStringAsFixed(2);
          return Container(
            width: 500.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 16.r)],
            ),
            child: Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                children: [
                  _row('Sub Total', '\$${money(ctl.subTotal.value)}'),
                  _row('Delivery Charges', '\$${money(ctl.deliveryFee.value)}'),
                  if (ctl.discountAmount.value > 0)
                    _row('Discount', '- \$${money(ctl.discountAmount.value)}'),
                  const Divider(color: Color(0xFFEAECED), thickness: 1),
                  _row('Total', '\$${money(ctl.finalTotal.value)}'),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _row(String l, String r) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(l, style: TextStyle(fontSize: 14.sp, color: const Color(0xFF6F7E8D))),
      Text(r, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: const Color(0xFF020711))),
    ],
  );
}

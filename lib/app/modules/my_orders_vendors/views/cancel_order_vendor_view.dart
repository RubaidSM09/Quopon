import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:quopon/common/custom_textField.dart';

import '../../../../common/customTextButton.dart';
import 'my_order_details_vendor_view.dart';
import '../controllers/my_orders_vendors_controller.dart';

class CancelOrderVendorView extends GetView<MyOrdersVendorsController> {
  final String itemImg;
  final String itemName;
  final Map<String, List<String>> itemAddons;
  final bool isNew;
  final String status;
  final String customerName;
  final String orderItem;
  final int quantity;
  final double totalAmount;
  final String orderTime;
  final String orderStatus;
  final String orderId; // Added orderId parameter
  final _moreDetailsController = TextEditingController();

  CancelOrderVendorView({
    required this.itemImg,
    required this.itemName,
    this.itemAddons = const {},
    this.isNew = false,
    required this.status,
    required this.customerName,
    required this.orderItem,
    required this.quantity,
    required this.totalAmount,
    required this.orderTime,
    required this.orderStatus,
    required this.orderId, // Added orderId parameter
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    RxList<RxBool> checkBoxTick = [false.obs, false.obs, false.obs, false.obs].obs;
    final List<String> reasons = [
      'Customer didn’t show up',
      'Item not available',
      'Delivery issue',
      'Other',
    ];

    return Dialog(
      backgroundColor: Color(0xFFF9FBFC),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox.shrink(),
                  Text(
                    'Cancel Order',
                    style: TextStyle(
                      color: Color(0xFF020711),
                      fontWeight: FontWeight.w500,
                      fontSize: 18.sp,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Icon(Icons.close, size: 24.sp),
                  )
                ],
              ),

              SizedBox(height: 16.h),

              Divider(color: Color(0xFFEAECED)),

              SizedBox(height: 16.h),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Select a reason before cancelling the order',
                  style: TextStyle(
                    color: Color(0xFF020711),
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                  ),
                ),
              ),

              SizedBox(height: 12.h),

              ...reasons.asMap().entries.map((entry) {
                int index = entry.key;
                String reason = entry.value;
                return Row(
                  children: [
                    Obx(() => Checkbox(
                      activeColor: Color(0xFFD62828),
                      value: checkBoxTick[index].value,
                      onChanged: (bool? value) {
                        checkBoxTick[index].value = value ?? false;
                      },
                    )),
                    Text(
                      reason,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF020711),
                      ),
                    ),
                  ],
                );
              }),

              SizedBox(height: 16.h),

              GetInTouchTextField(
                headingText: 'Add more details',
                fieldText: 'Write here...',
                iconImagePath: '',
                controller: _moreDetailsController,
                isRequired: false,
                maxLine: 6,
                isOptional: true,
              ),

              SizedBox(height: 16.h),

              GradientButton(
                text: 'Cancel Order',
                onPressed: () {
                  // Collect selected reasons
                  List<String> selectedReasons = [];
                  for (int i = 0; i < checkBoxTick.length; i++) {
                    if (checkBoxTick[i].value) {
                      selectedReasons.add(reasons[i]);
                    }
                  }
                  // Include text from _moreDetailsController if "Other" is selected
                  if (checkBoxTick[3].value && _moreDetailsController.text.isNotEmpty) {
                    selectedReasons.add(_moreDetailsController.text);
                  }

                  // Ensure at least one reason is selected
                  if (selectedReasons.isEmpty) {
                    Get.snackbar(
                      'Error',
                      'Please select at least one cancellation reason',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                    return;
                  }

                  // Join reasons into a single string
                  String cancellationReason = selectedReasons.join(', ');

                  // Call cancelOrder method
                  Get.back(); // Close the dialog
                  controller.cancelOrder(orderId, cancellationReason);
                },
                colors: [const Color(0xFFD62828), const Color(0xFFC21414)],
                boxShadow: [const BoxShadow(color: Color(0xFF9A0000), spreadRadius: 1)],
                borderColor: [Color(0xFFF44646), const Color(0xFFC21414)],
                borderRadius: 12.r,
                child: Text(
                  'Cancel Order',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),

              SizedBox(height: 8.h),

              GradientButton(
                text: 'Go Back',
                onPressed: () {
                  Get.back();
                  Get.dialog(MyOrderDetailsVendorView(
                    itemImg: itemImg,
                    itemName: itemName,
                    itemAddons: itemAddons,
                    isNew: isNew,
                    status: status,
                    customerName: customerName,
                    orderItem: orderItem,
                    quantity: quantity,
                    totalAmount: totalAmount,
                    orderTime: orderTime,
                    orderStatus: orderStatus,
                    orderId: orderId,
                  ));
                },
                colors: [const Color(0xFFF4F5F6), const Color(0xFFEEF0F3)],
                boxShadow: [const BoxShadow(color: Color(0xFFDFE4E9), spreadRadius: 1)],
                borderColor: [Colors.white, const Color(0xFFEEF0F3)],
                borderRadius: 12.r,
                child: Text(
                  'Go Back',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF020711),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
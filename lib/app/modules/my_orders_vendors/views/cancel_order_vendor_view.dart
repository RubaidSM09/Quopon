import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:quopon/common/custom_textField.dart';

import '../../../../common/customTextButton.dart';
import 'my_order_details_vendor_view.dart';

class CancelOrderVendorView extends GetView {
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
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    RxList<RxBool> checkBoxTick = [false.obs, false.obs, false.obs, false.obs].obs;

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
                    child: Icon(Icons.close, size: 24.sp,),
                  )
                ],
              ),

              SizedBox(height: 16.h,),

              Divider(color: Color(0xFFEAECED),),

              SizedBox(height: 16.h,),

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
              SizedBox(height: 12.h,),
              Row(
                children: [
                  // Use Obx to listen to changes in isChecked
                  Obx(() {
                    return Checkbox(
                      activeColor: Color(0xFFD62828),
                      value: checkBoxTick[0].value,
                      onChanged: (bool? value) {
                        checkBoxTick[0].value = !checkBoxTick[0].value;
                      },
                    );
                  }),
                  Text(
                    'Customer didn’t show up',
                    style: TextStyle(
                        fontSize: 14.sp, // Use ScreenUtil for font size
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF020711)
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  // Use Obx to listen to changes in isChecked
                  Obx(() {
                    return Checkbox(
                      activeColor: Color(0xFFD62828),
                      value: checkBoxTick[1].value,
                      onChanged: (bool? value) {
                        checkBoxTick[1].value = !checkBoxTick[1].value;
                      },
                    );
                  }),
                  Text(
                    'Item not available',
                    style: TextStyle(
                        fontSize: 14.sp, // Use ScreenUtil for font size
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF020711)
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  // Use Obx to listen to changes in isChecked
                  Obx(() {
                    return Checkbox(
                      activeColor: Color(0xFFD62828),
                      value: checkBoxTick[2].value,
                      onChanged: (bool? value) {
                        checkBoxTick[2].value = !checkBoxTick[2].value;
                      },
                    );
                  }),
                  Text(
                    'Delivery issue',
                    style: TextStyle(
                        fontSize: 14.sp, // Use ScreenUtil for font size
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF020711)
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  // Use Obx to listen to changes in isChecked
                  Obx(() {
                    return Checkbox(
                      activeColor: Color(0xFFD62828),
                      value: checkBoxTick[3].value,
                      onChanged: (bool? value) {
                        checkBoxTick[3].value = !checkBoxTick[3].value;
                      },
                    );
                  }),
                  Text(
                    'Other',
                    style: TextStyle(
                        fontSize: 14.sp, // Use ScreenUtil for font size
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF020711)
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16.h,),

              GetInTouchTextField(
                headingText: 'Add more details',
                fieldText: 'Write here...',
                iconImagePath: '',
                controller: _moreDetailsController,
                isRequired: false,
                maxLine: 6,
                isOptional: true,
              ),

              SizedBox(height: 16.h,),

              GradientButton(
                text: 'Cancel Order',
                onPressed: () {
                  Get.back();
                },
                colors: [const Color(0xFFD62828), const Color(0xFFC21414)],
                boxShadow: [const BoxShadow(color: Color(0xFF9A0000), spreadRadius: 1)],
                borderColor: [Color(0xFFF44646), const Color(0xFFC21414)],
                borderRadius: 12.r,
                child: Text(
                  'Cancel Order',
                  style: TextStyle(
                    fontSize: 16.sp,  // Use ScreenUtil for font size
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),

              SizedBox(height: 8.h,),

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
                  ));
                },
                colors: [const Color(0xFFF4F5F6), const Color(0xFFEEF0F3)],
                boxShadow: [const BoxShadow(color: Color(0xFFDFE4E9), spreadRadius: 1)],
                borderColor: [Colors.white, const Color(0xFFEEF0F3)],
                borderRadius: 12.r,
                child: Text(
                  'Go Back',
                  style: TextStyle(
                    fontSize: 16.sp,  // Use ScreenUtil for font size
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

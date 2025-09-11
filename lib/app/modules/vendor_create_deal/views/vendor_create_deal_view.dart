import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';  // Import ScreenUtil
import 'package:quopon/app/modules/deal_preview/views/deal_preview_view.dart';
import 'package:quopon/app/modules/vendor_create_deal/views/deal_publish_view.dart';
import 'package:quopon/common/PictureUploadField.dart';
import 'package:quopon/common/customTextButton.dart';
import 'package:quopon/common/custom_textField.dart';
import 'package:quopon/common/deliveryCostForm.dart';

import '../../signUpProcess/views/vendor_business_hour_row_view.dart';
import '../controllers/vendor_create_deal_controller.dart';

class VendorCreateDealView extends GetView<VendorCreateDealController> {
  // final _titleController = TextEditingController();
  // final _descriptionController = TextEditingController();
  // final VendorCreateDealController checkboxController = Get.put(VendorCreateDealController());

  final RxString startDate = ''.obs;

  VendorCreateDealView({super.key});

  Future<void> _selectStartDate(BuildContext context) async {
    DateTime initialDate = DateTime.now();
    DateTime firstDate = DateTime(1900);
    DateTime lastDate = DateTime(2100);

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (pickedDate != null) {
      startDate.value = DateFormat('yyyy-MM-dd').format(pickedDate); // Format the date as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    Get.put(VendorCreateDealController());

    return Scaffold(
      backgroundColor: Color(0xFFF9FBFC),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16.r, 32.h, 16.r, 16.h), // Use ScreenUtil for padding
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(Icons.arrow_back, size: 24.sp), // Use ScreenUtil for icon size
                ),
                Text(
                  'Create Deal',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18.sp, // Use ScreenUtil for font size
                      color: Color(0xFF020711)
                  ),
                ),
                SizedBox.shrink()
              ],
            ),

            SizedBox(height: 20.h), // Use ScreenUtil for spacing

            Obx(() {
              final names = controller.menuNames;
              final selectedName = controller.selectedMenuName.value;

              return CustomCategoryField(
                fieldName: 'Linked Menu Item',
                isRequired: true,
                selectedCategory: names.isNotEmpty ? selectedName : 'Select',
                categories: names.isNotEmpty ? names : const ['Select'],

                // from our earlier widget change:
                onCategorySelected: (name) {
                  controller.selectedMenuName.value = name;
                  controller.setMenuId(controller.nameToId[name] ?? 0);
                },
              );
            }),

            SizedBox(height: 8.h,),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  'assets/images/CreateDeals/Info.svg'
                ),
                SizedBox(width: 8.w,),
                Text(
                  'Auto-added to cart when customer activates the deal.',
                  style: TextStyle(
                    color: Color(0xFFD62828),
                    fontSize: 12.sp
                  ),
                )
              ],
            ),

            SizedBox(height: 20.h), // Use ScreenUtil for spacing

            Obx(() {
              final names = controller.discounts;
              final selectedName = controller.selectedDiscount.value;

              return CustomCategoryField(
                fieldName: 'Discount',
                isRequired: true,
                selectedCategory: names.isNotEmpty ? selectedName : 'Select',
                categories: names.isNotEmpty ? names : const ['Select'],

                // from our earlier widget change:
                onCategorySelected: (name) {
                  controller.selectedDiscount.value = name;
                },
              );
            }),

            SizedBox(height: 20.h), // Use ScreenUtil for spacing

            Obx(() => PictureUploadField(
              height: 220.h,
              width: 398.w,
              file: controller.imageFile.value,          // shows preview if picked
              onImageSelected: (file) => controller.setImageFile(file),
            )),

            SizedBox(height: 20.h), // Use ScreenUtil for spacing

            GetInTouchTextField(
              headingText: 'Title',
              fieldText: 'Enter deal title',
              iconImagePath: '',
              controller: controller.titleController,
              isRequired: true,
            ),

            SizedBox(height: 20.h), // Use ScreenUtil for spacing

            GetInTouchTextField(
              headingText: 'Description',
              fieldText: 'Write here...',
              iconImagePath: '',
              controller: controller.descriptionController,
              isRequired: true,
              maxLine: 6,
            ),

            SizedBox(height: 20.h), // Use ScreenUtil for spacing

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomDateFied(heading: 'Start Date', isRequired: true,),
                CustomDateFied(heading: 'End Date', isRequired: true,),
              ],
            ),

            SizedBox(height: 20.h), // Use ScreenUtil for spacing

            Obx(() {
              final names = controller.redemptionTypes;
              final selectedName = controller.selectedRedemptionType.value;

              return CustomCategoryField(
                fieldName: 'Choose a menu item',
                isRequired: true,
                selectedCategory: names.isNotEmpty ? selectedName : 'Select',
                categories: names.isNotEmpty ? names : const ['Select'],

                // from our earlier widget change:
                onCategorySelected: (name) {
                  controller.selectedRedemptionType.value = name;
                },
              );
            }),

            SizedBox(height: 20.h), // Use ScreenUtil for spacing

            GetInTouchTextField(
              headingText: 'Max Cuopons For This Deals',
              fieldText: '50 Cuopons',
              iconImagePath: '',
              controller: controller.maxCuoponController,
              isRequired: true,
            ),

            SizedBox(height: 20.h), // Use ScreenUtil for spacing

            GetInTouchTextField(
              headingText: 'Max Cuopons Per Customer',
              fieldText: '01 Cuopons',
              iconImagePath: '',
              controller: controller.maxCuoponPerCustomerController,
              isRequired: true,
            ),

            SizedBox(height: 20.h), // Use ScreenUtil for spacing

            DeliveryCostForm(),

            SizedBox(height: 20.h), // Use ScreenUtil for spacing

            Row(
              children: [
                Text(
                  'Available Days and Time Slots',
                  style: TextStyle(
                    fontSize: 16.sp,  // Use ScreenUtil for font size
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                SizedBox.shrink()
              ],
            ),
            SizedBox(height: 8.h),  // Use ScreenUtil for height spacing
            // VendorBusinessHourRowView(
            //   isActive: true,
            //   day: 'Mon',
            //   startTime: '08:00',
            //   endTime: '17:00',
            // ),
            // SizedBox(height: 15.h),  // Use ScreenUtil for spacing
            // VendorBusinessHourRowView(
            //   isActive: true,
            //   day: 'Mon',
            //   startTime: '08:00',
            //   endTime: '17:00',
            // ),
            // SizedBox(height: 15.h),  // Use ScreenUtil for spacing
            // VendorBusinessHourRowView(
            //   isActive: true,
            //   day: 'Mon',
            //   startTime: '08:00',
            //   endTime: '17:00',
            // ),
            // SizedBox(height: 15.h),  // Use ScreenUtil for spacing
            // VendorBusinessHourRowView(
            //   isActive: true,
            //   day: 'Mon',
            //   startTime: '08:00',
            //   endTime: '17:00',
            // ),
            // SizedBox(height: 15.h),  // Use ScreenUtil for spacing
            // VendorBusinessHourRowView(
            //   isActive: true,
            //   day: 'Mon',
            //   startTime: '08:00',
            //   endTime: '17:00',
            // ),
            // SizedBox(height: 15.h),  // Use ScreenUtil for spacing
            // VendorBusinessHourRowView(
            //   isActive: true,
            //   day: 'Mon',
            //   startTime: '08:00',
            //   endTime: '17:00',
            // ),
            // SizedBox(height: 15.h),  // Use ScreenUtil for spacing
            // VendorBusinessHourRowView(
            //   isActive: true,
            //   day: 'Mon',
            //   startTime: '08:00',
            //   endTime: '17:00',
            // ),

            SizedBox(height: 20.h), // Use ScreenUtil for spacing

            Row(
              children: [
                // Use Obx to listen to changes in isChecked
                Obx(() {
                  return Checkbox(
                    activeColor: Color(0xFFD62828),
                    value: controller.isChecked.value,
                    onChanged: (bool? value) {
                      controller.toggleCheckbox(value ?? false);
                    },
                  );
                }),
                Text(
                  'Send push notification when deal goes live',
                  style: TextStyle(
                      fontSize: 14.sp, // Use ScreenUtil for font size
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF020711)
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      bottomNavigationBar: Container(
        padding: EdgeInsets.only(left: 16.r, right: 16.r, top: 16.h, bottom: 32.h), // Use ScreenUtil for padding
        height: 106.h, // Use ScreenUtil for height
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 16)]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GradientButton(
              width: 200.w,
              text: 'Preview',
              onPressed: () {
                Get.dialog(DealPreviewView());
              },
              colors: [Color(0xFFF4F5F6), Color(0xFFEEF0F3)],
              borderColor: [Colors.white, Color(0xFFEEF0F3)],
              boxShadow: [BoxShadow(color: Color(0xFFDFE4E9), spreadRadius: 1)],
              child: Text(
                'Preview',
                style: TextStyle(color: Color(0xFF020711), fontWeight: FontWeight.w500, fontSize: 16.sp),
              ),
            ),
            GradientButton(
              width: 200.w,
              text: 'Create Deal',
              onPressed: () async {
                await controller.createDeal();
                // you can open the publish dialog on success if you like:
                // Get.dialog(DealPublishView());
              },
              colors: const [Color(0xFFD62828), Color(0xFFC21414)],
            ),
          ],
        ),
      ),
    );
  }
}

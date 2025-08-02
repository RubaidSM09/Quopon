import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';  // Import ScreenUtil
import 'package:quopon/app/modules/vendor_create_deal/views/deal_publish_view.dart';
import 'package:quopon/common/PictureUploadField.dart';
import 'package:quopon/common/customTextButton.dart';
import 'package:quopon/common/custom_textField.dart';
import 'package:quopon/common/deliveryCostForm.dart';

import '../../signUpProcess/views/vendor_business_hour_row_view.dart';
import '../controllers/vendor_create_deal_controller.dart';

class VendorCreateDealView extends GetView<VendorCreateDealController> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final VendorCreateDealController checkboxController = Get.put(VendorCreateDealController());

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

            PictureUploadField(height: 220.h, width: 398.w), // Use ScreenUtil for height and width

            SizedBox(height: 20.h), // Use ScreenUtil for spacing

            GetInTouchTextField(
              headingText: 'Title',
              fieldText: 'Enter deal title',
              iconImagePath: '',
              controller: _titleController,
              isRequired: true,
            ),

            SizedBox(height: 20.h), // Use ScreenUtil for spacing

            GetInTouchTextField(
              headingText: 'Description',
              fieldText: 'Write here...',
              iconImagePath: '',
              controller: _descriptionController,
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

            CustomCategoryField(fieldName: 'Redemption Type', isRequired: true,),

            SizedBox(height: 20.h), // Use ScreenUtil for spacing

            GetInTouchTextField(
              headingText: 'Max Cuopons For This Deals',
              fieldText: '50 Cuopons',
              iconImagePath: '',
              controller: _titleController,
              isRequired: true,
            ),

            SizedBox(height: 20.h), // Use ScreenUtil for spacing

            GetInTouchTextField(
              headingText: 'Max Cuopons Per Customer',
              fieldText: '01 Cuopons',
              iconImagePath: '',
              controller: _titleController,
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
            VendorBusinessHourRowView(
              isActive: true,
              day: 'Mon',
              startTime: '12:00 AM',
              endTime: '12:00 AM',
            ),
            SizedBox(height: 15.h),  // Use ScreenUtil for spacing
            VendorBusinessHourRowView(
              isActive: true,
              day: 'Tue',
              startTime: '12:00 AM',
              endTime: '12:00 AM',
            ),
            SizedBox(height: 15.h),  // Use ScreenUtil for spacing
            VendorBusinessHourRowView(
              isActive: true,
              day: 'Wed',
              startTime: '12:00 AM',
              endTime: '12:00 AM',
            ),
            SizedBox(height: 15.h),  // Use ScreenUtil for spacing
            VendorBusinessHourRowView(
              isActive: true,
              day: 'Thu',
              startTime: '12:00 AM',
              endTime: '12:00 AM',
            ),
            SizedBox(height: 15.h),  // Use ScreenUtil for spacing
            VendorBusinessHourRowView(
              isActive: true,
              day: 'Fri',
              startTime: '12:00 AM',
              endTime: '12:00 AM',
            ),
            SizedBox(height: 15.h),  // Use ScreenUtil for spacing
            VendorBusinessHourRowView(
              isActive: false,
              day: 'Sat',
              startTime: '12:00 AM',
              endTime: '12:00 AM',
            ),
            SizedBox(height: 15.h),  // Use ScreenUtil for spacing
            VendorBusinessHourRowView(
              isActive: false,
              day: 'Sun',
              startTime: '12:00 AM',
              endTime: '12:00 AM',
            ),

            SizedBox(height: 20.h), // Use ScreenUtil for spacing

            Row(
              children: [
                // Use Obx to listen to changes in isChecked
                Obx(() {
                  return Checkbox(
                    activeColor: Color(0xFFD62828),
                    value: checkboxController.isChecked.value,
                    onChanged: (bool? value) {
                      checkboxController.toggleCheckbox(value ?? false);
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
                Get.dialog(DealPublishView());
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
              onPressed: () {
                Get.dialog(DealPublishView());
              },
              colors: [Color(0xFFD62828), Color(0xFFC21414)],
            ),
          ],
        ),
      ),
    );
  }
}

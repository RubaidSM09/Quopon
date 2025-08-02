import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';  // Import ScreenUtil

import '../../../../common/PictureUploadField.dart';
import '../../../../common/customTextButton.dart';
import '../../../../common/custom_textField.dart';
import '../controllers/vendor_edit_deal_controller.dart';

class VendorEditDealView extends GetView<VendorEditDealController> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  final RxString startDate = ''.obs;

  VendorEditDealView({super.key});

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
        padding: EdgeInsets.fromLTRB(16.w, 32.h, 16.w, 16.h),  // Use ScreenUtil for padding
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(Icons.arrow_back),
                ),
                Text(
                  'Create Deal',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18.sp,  // Use ScreenUtil for font size
                      color: Color(0xFF020711)
                  ),
                ),
                SizedBox.shrink()
              ],
            ),

            SizedBox(height: 20.h),  // Use ScreenUtil for height

            PictureUploadField(height: 220.h, width: 398.w, isUploaded: true, image: 'assets/images/DealPerformance/Shakes.jpg'),

            SizedBox(height: 20.h),  // Use ScreenUtil for height

            GetInTouchTextField(
              headingText: 'Title',
              fieldText: '50% OFF Any Grande Beverage',
              iconImagePath: '',
              controller: _titleController,
              isRequired: true,
            ),

            SizedBox(height: 20.h),  // Use ScreenUtil for height

            GetInTouchTextField(
              headingText: 'Description',
              fieldText: 'Lorem Ipsum is simply dummy text...',
              iconImagePath: '',
              controller: _descriptionController,
              isRequired: true,
              maxLine: 6,
            ),

            SizedBox(height: 20.h),  // Use ScreenUtil for height

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomDateFied(heading: 'Start Date', isRequired: true, date: '5 June, 2025'),
                CustomDateFied(heading: 'End Date', isRequired: true, date: '25 June, 2025'),
              ],
            ),

            SizedBox(height: 20.h),  // Use ScreenUtil for height

            CustomCategoryField(fieldName: 'Redemption Type', isRequired: true),
          ],
        ),
      ),

      bottomNavigationBar: Container(
        padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h, bottom: 32.h),  // Use ScreenUtil for padding
        height: 106.h,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 16)]
        ),
        child: GradientButton(
          text: 'Save',
          onPressed: () {},
          colors: [Color(0xFFD62828), Color(0xFFC21414)],
        ),
      ),
    );
  }
}

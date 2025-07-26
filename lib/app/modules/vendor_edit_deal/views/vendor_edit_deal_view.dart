import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
        padding: EdgeInsets.fromLTRB(16, 32, 16, 16),
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
                      fontSize: 18,
                      color: Color(0xFF020711)
                  ),
                ),
                SizedBox.shrink()
              ],
            ),

            SizedBox(height: 20,),

            PictureUploadField(height: 220, width: 398, isUploaded: true, image: 'assets/images/DealPerformance/Shakes.jpg'),

            SizedBox(height: 20,),

            GetInTouchTextField(
              headingText: 'Title',
              fieldText: '50% OFF Any Grande Beverage',
              iconImagePath: '',
              controller: _titleController,
              isRequired: true,
            ),

            SizedBox(height: 20,),

            GetInTouchTextField(
              headingText: 'Description',
              fieldText: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
              iconImagePath: '',
              controller: _descriptionController,
              isRequired: true,
              maxLine: 6,
            ),

            SizedBox(height: 20,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomDateFied(heading: 'Start Date', isRequired: true, date: '5 June, 2025',),
                CustomDateFied(heading: 'End Date', isRequired: true, date: '25 June, 2025',),
              ],
            ),

            SizedBox(height: 20,),

            CustomCategoryField(fieldName: 'Redemption Type', isRequired: true,),
          ],
        ),
      ),

      bottomNavigationBar: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 32),
        height: 106,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 16)]
        ),
        child: GradientButton(
          text: 'Save',
          onPressed: () {

          },
          colors: [Color(0xFFD62828), Color(0xFFC21414)],
        ),
      ),
    );
  }
}

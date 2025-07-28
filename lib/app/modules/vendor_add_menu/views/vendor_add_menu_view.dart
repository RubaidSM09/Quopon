import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:quopon/app/modules/vendor_menu/views/vendor_menu_view.dart';

import '../../../../common/PictureUploadField.dart';
import '../../../../common/customTextButton.dart';
import '../../../../common/custom_textField.dart';
import '../controllers/vendor_add_menu_controller.dart';

class VendorAddMenuView extends GetView<VendorAddMenuController> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  final RxString startDate = ''.obs;

  VendorAddMenuView({super.key});

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
                  'Add Menu Item',
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

            PictureUploadField(height: 220, width: 398,),

            SizedBox(height: 20,),

            GetInTouchTextField(
              headingText: 'Title',
              fieldText: 'Enter deal title',
              iconImagePath: '',
              controller: _titleController,
              isRequired: true,
            ),

            SizedBox(height: 20,),

            GetInTouchTextField(
              headingText: 'Description',
              fieldText: 'Write here...',
              iconImagePath: '',
              controller: _descriptionController,
              isRequired: true,
              maxLine: 6,
            ),

            SizedBox(height: 20,),

            CustomCategoryField(
              fieldName: 'Category',
              isRequired: true,
              selectedCategory: 'Breakfast',
              categories: ['Breakfast', 'Lunch', 'Dinner'],
            ),

            SizedBox(height: 20,),

            GetInTouchTextField(
              headingText: 'Description',
              fieldText: '0.00',
              iconImagePath: 'assets/images/Menu/USD.png',
              controller: _descriptionController,
              isRequired: true,
            ),

            SizedBox(height: 20,),

            CustomCategoryField(
              fieldName: 'Choose Modifier Groups',
              isRequired: true,
            ),
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
            Get.to(VendorMenuView());
          },
          colors: [Color(0xFFD62828), Color(0xFFC21414)],
        ),
      ),
    );
  }
}

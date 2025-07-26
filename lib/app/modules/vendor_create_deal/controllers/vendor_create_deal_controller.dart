import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class VendorCreateDealController extends GetxController {
  var isChecked = false.obs;

  // Method to toggle the checkbox state
  void toggleCheckbox(bool value) {
    isChecked.value = value;
  }
}

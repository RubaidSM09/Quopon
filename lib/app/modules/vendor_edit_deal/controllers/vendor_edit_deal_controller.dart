import 'package:get/get.dart';

class VendorEditDealController extends GetxController {
  var isChecked = false.obs;

  // Method to toggle the checkbox state
  void toggleCheckbox(bool value) {
    isChecked.value = value;
  }
}

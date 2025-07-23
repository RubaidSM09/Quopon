import 'package:get/get.dart';

class TrackOrderController extends GetxController {
  var currentStep = 1.obs;

  void setStep(int step) {
    currentStep.value = step;
  }
}

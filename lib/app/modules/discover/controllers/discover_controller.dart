import 'package:get/get.dart';

class DiscoverController extends GetxController {
  RxBool isMap = true.obs;
  RxBool isDelivery = true.obs;

  RxList<RxBool> selectedCuisine = [false.obs, true.obs, false.obs, false.obs, false.obs, false.obs, true.obs, false.obs, false.obs].obs;

  RxList<RxBool> selectedDiet = [false.obs, true.obs, false.obs].obs;

  RxList<RxBool> selectedPrice = [false.obs, true.obs, false.obs].obs;

  RxList<RxBool> selectedRating = [false.obs, false.obs, true.obs, true.obs].obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}

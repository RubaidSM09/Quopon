// lib/app/modules/support/controllers/support_faq_controller.dart
import 'dart:convert';
import 'package:get/get.dart';
import 'package:quopon/app/data/api_client.dart';
import 'package:quopon/app/data/model/faq_model.dart';

class SupportFAQController extends GetxController {
  final faqs = <FAQModel>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchFaqs();
  }

  Future<void> fetchFaqs() async {
    isLoading.value = true;
    try {
      final res = await ApiClient.get('/support/faqs/');
      print(res.statusCode);
      if (res.statusCode == 200) {
        final List data = json.decode(res.body);
        faqs.assignAll(data.map((e) => FAQModel.fromJson(e)).toList());
      } else {
        Get.snackbar('Error', 'Failed to load FAQs (${res.statusCode})');
      }
    } catch (e) {
      Get.snackbar('Network', 'Could not load FAQs: $e');
    } finally {
      isLoading.value = false;
    }
  }
}

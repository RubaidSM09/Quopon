import 'dart:convert';

import 'package:get/get.dart';

import '../../../data/base_client.dart';

class SendPushNotificationsController extends GetxController {

  final count = 0.obs;

  Future<void> pushNotifications(int dealId, String title, String description) async {
    try {
      final body = <String, dynamic>{
        'title':title,
        'body':description,
      };

      final headers = await BaseClient.authHeaders();

      print(body);
      print(headers);

      final res = await BaseClient.postRequest(
        api: 'http://10.10.13.99:8090/vendors/$dealId/send-notification/',
        headers: headers,
        body: json.encode(body),
      );

      if (res.statusCode == 200 || res.statusCode == 201) {
        await BaseClient.handleResponse(res);
        Get.snackbar('Success', 'Notifications sent successfully');

        Get.back();
        Get.back();
      }
      else {
        final resBody = jsonDecode(res.body);
        Get.snackbar('Notifications sent failed', resBody['message'] ?? 'Please give correct information');
      }
    } catch (e) {
      print('Error => ${e.toString()}');
      Get.snackbar('Error', e.toString());
    }
  }


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

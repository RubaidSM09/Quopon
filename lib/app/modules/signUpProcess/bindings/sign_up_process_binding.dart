import 'package:get/get.dart';


import '../controllers/sign_up_process_controller.dart';

class SignUpProcessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpProcessController>(
      () => SignUpProcessController(),
    );
  }
}

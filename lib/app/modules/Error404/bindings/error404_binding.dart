import 'package:get/get.dart';

import '../../Error404/controllers/error404_controller.dart';

class Error404Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Error404Controller>(
      () => Error404Controller(),
    );
  }
}

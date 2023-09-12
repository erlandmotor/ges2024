import 'package:get/get.dart';

import '../controllers/continue_register_controller.dart';

class ContinueRegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      ContinueRegisterController(),
    );
  }
}

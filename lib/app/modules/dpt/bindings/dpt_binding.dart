import 'package:get/get.dart';

import '../controllers/dpt_controller.dart';

class DptBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DptController>(
      () => DptController(),
    );
  }
}

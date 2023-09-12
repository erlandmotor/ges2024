import 'package:get/get.dart';

import '../controllers/dpt_admin_controller.dart';

class DptAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DptAdminController>(
      () => DptAdminController(),
    );
  }
}

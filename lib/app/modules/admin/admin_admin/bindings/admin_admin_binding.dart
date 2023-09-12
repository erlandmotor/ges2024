import 'package:get/get.dart';

import '../controllers/admin_admin_controller.dart';

class AdminAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      AdminAdminController(),
    );
  }
}

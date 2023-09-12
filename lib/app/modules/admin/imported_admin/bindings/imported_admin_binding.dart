import 'package:get/get.dart';

import '../controllers/imported_admin_controller.dart';

class ImportedAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      ImportedAdminController(),
    );
  }
}

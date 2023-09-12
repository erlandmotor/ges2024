import 'package:get/get.dart';

import '../controllers/wilayah_admin_controller.dart';

class WilayahAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      WilayahAdminController(),
    );
  }
}

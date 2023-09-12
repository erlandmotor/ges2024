import 'package:get/get.dart';

import '../controllers/recruit_user_controller.dart';

class RecruitUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => RecruitUserController(),
    );
  }
}

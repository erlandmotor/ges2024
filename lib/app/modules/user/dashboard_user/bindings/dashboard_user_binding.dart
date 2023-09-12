import 'package:ges2024/app/modules/user/home_user/controllers/home_user_controller.dart';
import 'package:ges2024/app/modules/user/profile_user/controllers/profile_user_controller.dart';
import 'package:ges2024/app/modules/user/recruit_user/controllers/recruit_user_controller.dart';
import 'package:get/get.dart';

import '../controllers/dashboard_user_controller.dart';

class DashboardUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DashboardUserController());
    Get.put(HomeUserController());
    Get.put(RecruitUserController());
    Get.put(ProfileUserController());
  }
}

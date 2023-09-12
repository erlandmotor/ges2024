import 'package:ges2024/app/modules/admin/article_admin/controllers/article_admin_controller.dart';
import 'package:ges2024/app/modules/admin/home_admin/controllers/home_admin_controller.dart';
import 'package:ges2024/app/modules/admin/profile_admin/controllers/profile_admin_controller.dart';
import 'package:ges2024/app/modules/admin/users_admin/controllers/users_admin_controller.dart';
import 'package:get/get.dart';

import '../controllers/dashboard_admin_controller.dart';

class DashboardAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DashboardAdminController());
    Get.put(UsersAdminController());
    Get.put(ArticleAdminController());
    Get.put(HomeAdminController());
    Get.put(ProfileAdminController());
  }
}

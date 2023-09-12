import 'package:ges2024/app/controllers/auth_controller.dart';
import 'package:ges2024/app/controllers/data_controller.dart';
import 'package:ges2024/app/modules/admin/article_admin/controllers/article_admin_controller.dart';
import 'package:ges2024/app/modules/admin/home_admin/controllers/home_admin_controller.dart';
import 'package:ges2024/app/modules/admin/profile_admin/controllers/profile_admin_controller.dart';
import 'package:get/get.dart';

class DashboardAdminController extends GetxController {
  final authC = Get.find<AuthController>();
  final dataC = Get.find<DataController>();
  var tabIndex = 0;

  RxBool isLoading = false.obs;

  void changeTabIndex(int index) {
    Get.put(HomeAdminController());
    Get.put(ArticleAdminController());
    Get.put(ProfileAdminController());
    tabIndex = index;
    update();
  }
}

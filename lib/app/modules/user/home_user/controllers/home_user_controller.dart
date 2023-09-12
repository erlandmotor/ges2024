import 'package:carousel_slider/carousel_controller.dart';
import 'package:ges2024/app/controllers/auth_controller.dart';
import 'package:ges2024/app/controllers/data_controller.dart';
import 'package:ges2024/app/data/models/downline_model.dart';
import 'package:ges2024/app/modules/user/dashboard_user/controllers/dashboard_user_controller.dart';
import 'package:get/get.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';

class HomeUserController extends GetxController {
  final authC = Get.find<AuthController>();
  final dataC = Get.find<DataController>();
  final dashboardC = Get.find<DashboardUserController>();
  final CarouselController bannerController = CarouselController();
  final HDTRefreshController refreshController = HDTRefreshController();
  RxInt currentBanner = 0.obs;

  changeBanner(int index) {
    currentBanner.value = index;
    update();
  }

  void sort<T>(Comparable<T> Function(Downline d) getField, bool ascending) {
    dataC.team.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);

      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });
    update();
  }
}

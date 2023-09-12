import 'dart:convert';

import 'package:ges2024/app/constant/app_constant.dart';
import 'package:ges2024/app/controllers/auth_controller.dart';
import 'package:ges2024/app/controllers/data_controller.dart';
import 'package:ges2024/app/data/services/api_services.dart';
import 'package:get/get.dart';

class HomeAdminController extends GetxController {
  final authC = Get.find<AuthController>();
  final dataC = Get.find<DataController>();
  int totalAnggota = 0;
  int totalAdmin = 0;
  int totalTim = 0;
  int totalRelawan = 0;

  Future<void> countUsers() async {
    await ApiService.get(
      endpoint: AppString.countUsers,
      token: authC.userToken.value,
    ).then((respose) {
      if (respose.statusCode == 200) {
        var data = jsonDecode(respose.body);
        totalAnggota = data['total_users'];
        totalAdmin = data['total_admin'];
        totalTim = data['total_tim'];
        totalRelawan = data['total_relawan'];
        print(data);
        update();
      }
    });
  }
}

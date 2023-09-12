import 'dart:developer';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ges2024/app/constant/app_strings.dart';
import 'package:ges2024/app/controllers/auth_controller.dart';
import 'package:ges2024/app/controllers/data_controller.dart';
import 'package:ges2024/app/data/models/artikel_model.dart';
import 'package:ges2024/app/data/models/downline_model.dart';
import 'package:ges2024/app/data/services/api_services.dart';
import 'package:ges2024/app/modules/user/home_user/controllers/home_user_controller.dart';
import 'package:ges2024/app/modules/user/profile_user/controllers/profile_user_controller.dart';
import 'package:ges2024/app/modules/user/recruit_user/controllers/recruit_user_controller.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class DashboardUserController extends GetxController {
  final authC = Get.find<AuthController>();
  final dataC = Get.find<DataController>();
  var tabIndex = 0;

  RxBool isLoading = false.obs;

  void changeTabIndex(int index) {
    Get.put(HomeUserController());
    Get.put(RecruitUserController());
    Get.put(ProfileUserController());
    tabIndex = index;
    update();
  }

  @override
  void onInit() async {
    getArticles();
    getDownlines();
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    if (androidInfo.version.sdkInt <= 33) {
      var status = await Permission.storage.request();
      var status2 = await Permission.accessMediaLocation.request();
      if (status.isGranted && status2.isGranted) {
        print('Storage Granted');
      } else if (status.isPermanentlyDenied && status2.isPermanentlyDenied) {
        openAppSettings();
      }
    } else {
      var status = await Permission.manageExternalStorage.request();
      if (status.isGranted) {
        print('Storage Granted');
      } else if (status.isPermanentlyDenied) {
        openAppSettings();
      }
    }
    super.onInit();
  }

  Future<void> getArticles() async {
    isLoading.value = true;
    try {
      await ApiService.getData(
              endpoint: AppString.articles, token: authC.userToken.value)
          .then((response) {
        dataC.articles.clear();
        if (response.statusCode == 200) {
          // var data = json.decode(response.data);
          List<dynamic> article = response.data['articles'];
          // print(downlines);
          // print(downlines);
          if (article.isNotEmpty) {
            for (var singleArticle in article) {
              dataC.articles.add(Artikel.fromJson(singleArticle));
            }
          }
          isLoading.value = false;
        } else {
          getArticles();
        }
      });
    } catch (e) {
      isLoading.value = false;
      EasyLoading.showError(e.toString());
    }
  }

  Future<void> getDownlines() async {
    isLoading.value = true;
    // EasyLoading.show(maskType: EasyLoadingMaskType.black);
    EasyLoading.dismiss();
    try {
      await ApiService.getData(
              endpoint: AppString.downlines, token: authC.userToken.value)
          .then((response) {
        dataC.team.clear();
        List<Downline> subDownlines = [];
        // log(response.data.toString(), name: 'DOWNLINE');
        if (response.statusCode == 200) {
          // var data = json.decode(response.data);
          List<dynamic> downlines = response.data['downlines'];
          // print(downlines);
          // print(downlines);
          if (downlines.isNotEmpty) {
            for (var singleUser in downlines) {
              log(singleUser.toString(), name: 'SINGLE USER');
              dataC.team.add(Downline.fromJson(singleUser));
              print("Total Downline : ${singleUser['total_downlines']}");
              if (singleUser['total_downlines'] > 0) {
                for (var downline in singleUser['downlines']) {
                  subDownlines.add(Downline.fromJson(downline));
                }
              }
            }
          }
          for (var downline in subDownlines) {
            dataC.team.add(downline);
          }
          isLoading.value = false;
        } else {
          getDownlines();
        }
        // EasyLoading.dismiss();
      });
    }
    //  on FormatException {
    //   isLoading.value = false;
    //   EasyLoading.dismiss();
    //   EasyLoading.showError(
    //       "Ada kesalahan pada server!\nGagal mengambil data tim, silahkan refresh");
    // }
    catch (e) {
      isLoading.value = false;
      EasyLoading.showError(e.toString());
    }
  }
}

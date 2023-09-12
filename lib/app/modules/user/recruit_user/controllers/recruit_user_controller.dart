import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ges2024/app/controllers/auth_controller.dart';
import 'package:ges2024/app/controllers/data_controller.dart';
import 'package:ges2024/app/data/services/notification_services.dart';
import 'package:ges2024/app/modules/user/dashboard_user/controllers/dashboard_user_controller.dart';
import 'package:get/get.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';

class RecruitUserController extends GetxController {
  final dataC = Get.find<DataController>();
  final authC = Get.find<AuthController>();
  final dashboardC = Get.find<DashboardUserController>();
  final HDTRefreshController refreshController = HDTRefreshController();

  Future<void> createExcel() async {
    var excel = Excel.createExcel();
    Sheet sheetObject = excel['Daftar Tim ${authC.userData.value.namaLengkap}'];
    excel.setDefaultSheet("Daftar Tim ${authC.userData.value.namaLengkap}");
    sheetObject.appendRow([
      'No',
      'Nama',
      'No HP',
      'Email',
      'NIK',
      'Kelurahan',
      'Kecamatan',
      'Jml Rekrut'
    ]);
    for (var i = 0; i < dataC.team.length; i++) {
      var item = dataC.team[i];
      sheetObject.appendRow([
        i + 1,
        item.user!.namaLengkap,
        item.user!.noHp,
        item.user!.email,
        item.user!.nik,
        item.user!.kelurahan,
        item.user!.kecamatan,
        item.totalDownlines
      ]);
    }
    var fileBytes = excel.save();

    File(
        'storage/emulated/0/Download/daftar_tim_${authC.userData.value.kodeReferal}.xlsx')
      ..createSync(recursive: true)
      ..writeAsBytesSync(fileBytes!);
    NotificationService().showNotification(
        'storage/emulated/0/Download/daftar_tim_${authC.userData.value.kodeReferal}.xlsx');
    EasyLoading.showToast(
        'File Tersimpan!\nstorage/emulated/0/Download/daftar_tim_${authC.userData.value.kodeReferal}.xlsx',
        toastPosition: EasyLoadingToastPosition.bottom);
  }
}

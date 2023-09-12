import 'dart:convert';
import 'dart:developer';
import 'package:ges2024/app/data/models/error_model.dart';
import 'package:ges2024/app/routes/app_pages.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ges2024/app/constant/app_constant.dart';
import 'package:ges2024/app/controllers/auth_controller.dart';
import 'package:ges2024/app/data/models/user_model.dart';
import 'package:ges2024/app/data/services/api_services.dart';
import 'package:get/get.dart';

class ImportedAdminController extends GetxController {
  final authC = Get.find<AuthController>();
  List<ErrorData> errorData = [];
  Future<void> importData(List<UserModel> users) async {
    EasyLoading.show(
      maskType: EasyLoadingMaskType.black,
      status: 'Mengimpor Data ...',
    );
    List<Map<String, dynamic>> dataUser = [];
    for (var element in users) {
      dataUser.add({
        "nama_lengkap": element.namaLengkap,
        "nama_panggilan": element.namaPanggilan,
        "foto": 'public/foto_profil/no-image.png',
        "email": element.email,
        "no_hp": element.noHp,
        "nik": element.nik,
        "foto_ktp": 'public/foto_ktp/no-image.png',
        "provinsi": "Jambi",
        "kabupaten": element.kabupaten,
        "kecamatan": element.kecamatan,
        "kelurahan": element.kelurahan,
        "rt": element.rt,
        "rw": element.rw,
        "lrg": element.lrg,
        "referal_dari": element.referalDari,
        "status": element.status,
      });
    }
    Map<String, dynamic> request = {"data": dataUser};
    var response = await ApiService.post(
      endpoint: AppString.importUsers,
      request: request,
      token: authC.userToken.value,
    );
    var res = json.decode(response.body);
    if (response.statusCode == 200) {
      EasyLoading.dismiss();
      Get.offAllNamed(Routes.DASHBOARD_ADMIN);
      EasyLoading.showSuccess('Data Berhasil Diimport!');
    } else if (response.statusCode == 400) {
      errorData.clear();
      for (var error in res['failed_data']) {
        errorData.add(ErrorData.fromJson(error));
      }
      log(json.encode(errorData));
      EasyLoading.dismiss();
      EasyLoading.showError(
          "${res['message']}\nSilahkan periksa dan perbaiki data",
          duration: const Duration(seconds: 3));
      update();
    } else {
      EasyLoading.dismiss();
      EasyLoading.showError(res['message']);
    }
  }
}

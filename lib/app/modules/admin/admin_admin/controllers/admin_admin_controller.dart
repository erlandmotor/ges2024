import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ges2024/app/constant/app_constant.dart';
import 'package:ges2024/app/controllers/auth_controller.dart';
import 'package:ges2024/app/data/models/user_model.dart';
import 'package:ges2024/app/data/services/api_services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AdminAdminController extends GetxController {
  final authC = Get.find<AuthController>();
  var admins = RxList<UserModel>([]);
  var listSearch = RxList<UserModel>([]);
  String statusMessage = '';
  RxBool isLoading = false.obs;
  var keyword = ''.obs;
  final TextEditingController searchC = TextEditingController();
  void changeKeyword() {
    keyword.value = searchC.text;
  }

  @override
  void onInit() async {
    debounce(
      time: const Duration(seconds: 1),
      keyword,
      (callback) {
        listSearch.clear();
        searchAdmins(searchC.text);
      },
    );
    await getAdmin();
    super.onInit();
  }

  searchAdmins(String value) {
    listSearch.value = admins
        .where((admin) =>
            admin.namaLengkap!.toLowerCase().contains(value.toLowerCase()) ||
            admin.email!.toLowerCase().startsWith(value.toLowerCase()))
        .toList();
  }

  Future<void> getAdmin() async {
    await ApiService.get(
      endpoint: AppString.admins,
      token: authC.userToken.value,
    ).then((response) {
      admins.clear();
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(data['admins'].length);
        }
        for (var element in data['admins']) {
          admins.add(UserModel.fromJson(element));
        }
      } else {
        if (kDebugMode) {
          print(data['message']);
        }
        if (data['message'].toString().contains("Attempts")) {
          statusMessage =
              'Terlalu banyak percobaan!\nSilahkan coba dalam beberapa saat lagi!';
        } else {
          statusMessage = data['message'];
        }
      }
      isLoading.value = false;
    });
  }

  Future<void> addAdmin() async {
    try {
      EasyLoading.show(maskType: EasyLoadingMaskType.black);
      var response = await ApiService.post(
          endpoint: AppString.addAdmin,
          token: authC.userToken.value,
          request: {
            'nama_lengkap': authC.nameController.text,
            'nama_panggilan': "",
            'password': authC.passwordController.text,
            'email': authC.emailController.text,
            'no_hp': authC.phoneController.text,
            'nik': authC.emailController.text,
            'provinsi': "Jambi",
            'kabupaten': "Jambi",
            'kecamatan': "Danau Teluk",
            'kelurahan': "Pasir Panjang",
            'rt': "001",
            'rw': "001",
            'lrg': "-",
            'status': "Admin",
            'kode_referal': authC.emailController.text,
            'foto': 'public/foto_profil/default.png',
            'foto_ktp': 'public/foto_ktp/default.png',
          });
      print(response.statusCode);
      var data = json.decode(response.body);
      if (response.statusCode == 201) {
        await getAdmin().then((_) {
          EasyLoading.dismiss();
          Get.back();
          EasyLoading.showSuccess('Admin Berhasil Ditambah');
          authC.clear();
        });
      } else {
        throw data['message'];
      }
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(e.toString());
    }
  }

  Future<void> editAdmin(
      {required UserModel user,
      required String namaLengkap,
      email,
      noHp}) async {
    try {
      EasyLoading.show(
        status: 'Loading ...',
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.black,
      );
      var headers = {'Accept': 'application/json'};
      var request = http.MultipartRequest(
          'POST', Uri.parse("${AppString.baseUrl}${AppString.updateUser}"));
      request.fields.addAll({
        'id': user.id.toString(),
        'nama_lengkap': namaLengkap,
        'nama_panggilan': user.namaPanggilan!,
        'email': email,
        'no_hp': noHp,
        'nik': user.nik!,
        'provinsi': user.provinsi!,
        'kabupaten': user.kabupaten!,
        'kecamatan': user.kecamatan!,
        'kelurahan': user.kelurahan!,
        'rt': user.rt!,
        'rw': user.rw!,
        'lrg': user.lrg!,
        'kode_referal': user.kodeReferal!,
        'status': user.status!,
      });

      request.headers.addAll(headers);
      request.headers
          .addAll({'Authorization': 'Bearer ${authC.userToken.value}'});

      http.StreamedResponse response =
          await request.send().timeout(const Duration(milliseconds: 200000));
      print(response.statusCode);
      if (response.statusCode == 200) {
        await getAdmin().then((_) {
          EasyLoading.dismiss();
          Get.back();
          EasyLoading.showSuccess('Admin Berhasil Diperbarui');
          authC.clear();
        });
      } else {
        EasyLoading.dismiss();
        var res = await response.stream.bytesToString();
        print(res);
        throw "Update Gagal!\nPeriksa kembali inputan anda atau antara email dan nomor hp sudah digunakan pengguna lain!";
      }
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(
        e.toString(),
        duration: const Duration(seconds: 5),
      );
    }
  }

  Future<void> deleteAdmin(int id) async {
    try {
      EasyLoading.show(maskType: EasyLoadingMaskType.black);
      await ApiService.delete(
              endpoint: "${AppString.users}/$id", token: authC.userToken.value)
          .then((response) async {
        var data = json.decode(response.body);

        if (response.statusCode == 200) {
          await getAdmin().then((_) {
            EasyLoading.dismiss();
            Get.back();
            EasyLoading.showSuccess('Admin Berhasil Dihapus');
            authC.clear();
          });
        } else {
          throw data;
        }
        print(response.statusCode);
      });
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(e.toString());
    }
  }
}

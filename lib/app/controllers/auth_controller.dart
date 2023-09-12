import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ges2024/app/constant/app_constant.dart';
import 'package:ges2024/app/data/models/user_model.dart';
import 'package:ges2024/app/data/services/api_services.dart';
import 'package:ges2024/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController namaPanggilanController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nikController = TextEditingController();
  TextEditingController identityController = TextEditingController();
  TextEditingController referalController = TextEditingController();
  TextEditingController provinsiController = TextEditingController();
  TextEditingController kabupatenController = TextEditingController();
  TextEditingController kecamatanController = TextEditingController();
  TextEditingController kelurahanController = TextEditingController();
  TextEditingController rtController = TextEditingController();
  TextEditingController rwController = TextEditingController();
  TextEditingController lrgController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController fotoController = TextEditingController();
  TextEditingController ktpController = TextEditingController();

  Rx<UserModel> userData = UserModel().obs;
  RxString userToken = ''.obs;

  final box = GetStorage();

  void clear() {
    emailController.clear();
    phoneController.clear();
    passwordController.clear();
    identityController.clear();
    rePasswordController.clear();
    nameController.clear();
    namaPanggilanController.clear();
    nikController.clear();
    referalController.clear();
    provinsiController.clear();
    kabupatenController.clear();
    kecamatanController.clear();
    kelurahanController.clear();
    rtController.clear();
    rwController.clear();
    lrgController.clear();
    statusController.clear();
    fotoController.clear();
    ktpController.clear();
    oldPasswordController.clear();
  }

  Future<void> updatePassword() async {
    try {
      EasyLoading.show(
        status: 'Sedang Update Password ...',
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.black,
      );
      var response = await ApiService.post(
        endpoint: AppString.updatePassword,
        token: userToken.value,
        request: {
          'current_password': oldPasswordController.text,
          'new_password': passwordController.text,
          'new_password_confirmation': rePasswordController.text,
        },
      );
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        clear();
        EasyLoading.dismiss();
        Get.back();
        EasyLoading.showSuccess('Update Password Berhasil!');
      } else {
        EasyLoading.dismiss();
        throw data['errors']['current_password'][0];
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      EasyLoading.dismiss();
      EasyLoading.showError(e.toString());
    }
  }

  Future<void> register() async {
    try {
      EasyLoading.show(
        status: 'Proses Registrasi ...',
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.black,
      );
      var headers = {'Accept': 'application/json'};
      var request = http.MultipartRequest(
        'POST',
        Uri.parse("${AppString.baseUrl}${AppString.register}"),
      );
      request.fields.addAll({
        'nama_lengkap': nameController.text,
        'nama_panggilan': namaPanggilanController.text,
        'password': passwordController.text,
        'email': emailController.text,
        'no_hp': phoneController.text,
        'nik': nikController.text,
        'provinsi': provinsiController.text,
        'kabupaten': kabupatenController.text,
        'kecamatan': kecamatanController.text,
        'kelurahan': kelurahanController.text,
        'rt': rtController.text,
        'rw': rwController.text,
        'lrg': lrgController.text,
        'status': 'Relawan',
        'referal_dari': referalController.text,
      });
      request.files
          .add(await http.MultipartFile.fromPath('foto', fotoController.text));
      request.files.add(
          await http.MultipartFile.fromPath('foto_ktp', ktpController.text));
      request.headers.addAll(headers);

      http.StreamedResponse response =
          await request.send().timeout(const Duration(milliseconds: 200000));
      // print(await response.stream.bytesToString());
      var result = await response.stream.bytesToString();
      var data = json.decode(result);
      Map<String, dynamic> errors = {};
      if (data['errors'] != null) {
        // print(data['errors']);
        // print(data['errors'].runtimeType);
        errors.addAll(data['errors']);
        // if (data['errors'].runtimeType == List<Map<String, dynamic>>) {
        //   for (var error in data['errors']) {
        //     errors.add(error);
        //   }
        // }
      }
      if (kDebugMode) {
        print(data['message']);
        print(data);
      }
      if (response.statusCode == 201) {
        clear();

        EasyLoading.dismiss();
        Get.offAllNamed(Routes.LOGIN);
        EasyLoading.showSuccess('Registrasi Berhasil!\nSilahkan Login');
      } else {
        EasyLoading.dismiss();
        // print(result);
        List<dynamic> message = [];
        if (errors.isNotEmpty) {
          for (var error in errors.entries) {
            message.add(
                error.value.toString().replaceAll('[', '').replaceAll(']', ''));
          }
          throw message
              .toString()
              .replaceAll('[', '')
              .replaceAll(']', '')
              .replaceAll('.', '!');
        } else {
          throw data['message'];
        }
        // EasyLoading.showError(await response.stream.bytesToString());
      }
    } catch (e) {
      // print(e);
      EasyLoading.dismiss();
      EasyLoading.showError(e.toString(), duration: const Duration(seconds: 3));
    }
  }

  Future<void> requestReset() async {
    try {
      EasyLoading.show(
        status: 'Sedang Memproses ...',
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.black,
      );
      var response = await ApiService.post(
        endpoint: AppString.requestReset,
        request: {
          'identity': identityController.text,
        },
      );
      var data = json.decode(response.body);
      if (kDebugMode) {
        print(data);
        print(response.statusCode);
      }
      if (response.statusCode == 200) {
        emailController.text = data['email'];
        EasyLoading.dismiss();
        Get.offAllNamed(Routes.OTP);
        // EasyLoading.showSuccess('Permintaan Reset Password Berhasil!');
      } else if (response.statusCode == 500) {
        throw 'Server email bermasalah!';
      } else {
        EasyLoading.dismiss();
        throw data['error'];
      }
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(e.toString());
    }
  }

  Future<void> verifyOtp() async {
    try {
      EasyLoading.show(
        status: 'Sedang Memproses ...',
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.black,
      );
      var response = await ApiService.post(
        endpoint: AppString.verifyOTP,
        request: {
          'identity': identityController.text,
          'otp': passwordController.text,
        },
      );
      var data = json.decode(response.body);
      if (kDebugMode) {
        print(data);
        print(response.statusCode);
      }
      if (response.statusCode == 200) {
        userToken.value = data['token'];
        EasyLoading.dismiss();
        // clear();
        Get.offAllNamed(Routes.NEW_PASSWORD);
      } else {
        passwordController.clear();
        EasyLoading.dismiss();
        throw data['error'];
      }
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(e.toString());
    }
  }

  Future<void> resetPassword(String password) async {
    try {
      EasyLoading.show(
        status: 'Sedang Memproses ...',
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.black,
      );
      var response = await ApiService.post(
        endpoint: AppString.resetPassword,
        request: {
          'token': userToken.value,
          'password': password,
        },
      );
      var data = json.decode(response.body);
      if (kDebugMode) {
        print(userToken.value);
        print(data);
        print(response.statusCode);
      }
      if (response.statusCode == 200) {
        print('IF');
        EasyLoading.dismiss();
        clear();
        userToken.value = '';
        Get.offAllNamed(Routes.LOGIN);
        EasyLoading.showSuccess('Reset Password Berhasil!\nSilahkan Login');
      } else {
        print('ELSE');
        EasyLoading.dismiss();
        throw data['error'];
      }
    } catch (e) {
      print('CATCH');
      EasyLoading.dismiss();
      EasyLoading.showError(e.toString());
    }
  }

  Future<void> login() async {
    try {
      EasyLoading.show(
        status: 'Sedang Login ...',
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.black,
      );
      var response = await ApiService.post(
        endpoint: AppString.login,
        request: {
          'identity': identityController.text,
          'password': passwordController.text,
        },
      );
      var data = json.decode(response.body);
      // log(data.toString());
      if (response.statusCode == 200) {
        userData.value = UserModel.fromJson(data['user']);
        userToken.value = data['token'];
        box.write('userToken', userToken.value);
        box.write('userData', data['user']);
        EasyLoading.dismiss();
        if (passwordController.text == "password123" ||
            userData.value.foto!.contains("no-image") ||
            userData.value.fotoKtp!.contains("no-image")) {
          Get.offAllNamed(Routes.CONTINUE_REGISTER);
        } else {
          if (userData.value.status == 'Admin') {
            Get.offAllNamed(Routes.DASHBOARD_ADMIN);
          } else {
            Get.offAllNamed(Routes.DASHBOARD_USER);
          }
        }
        clear();
        EasyLoading.showSuccess('Login Berhasil!');
      } else {
        EasyLoading.dismiss();
        print(data);
        throw data['message'];
      }
    } catch (e) {
      print(e);
      EasyLoading.dismiss();
      EasyLoading.showError(e.toString());
    }
  }

  Future<void> updateProfile() async {
    try {
      EasyLoading.show(
        status: 'Sedang Update Profile ...',
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.black,
      );
      var headers = {'Accept': 'application/json'};
      var request = http.MultipartRequest(
          'POST', Uri.parse("${AppString.baseUrl}${AppString.updateProfil}"));
      request.fields.addAll({
        'nama_lengkap': nameController.text,
        'nama_panggilan': namaPanggilanController.text,
        'email': emailController.text,
        'no_hp': phoneController.text,
      });
      if (fotoController.text.isNotEmpty) {
        request.files.add(
            await http.MultipartFile.fromPath('foto', fotoController.text));
      }
      if (ktpController.text.isNotEmpty) {
        request.files.add(
            await http.MultipartFile.fromPath('foto_ktp', ktpController.text));
      }
      request.headers.addAll(headers);
      request.headers.addAll({'Authorization': 'Bearer ${userToken.value}'});

      http.StreamedResponse response =
          await request.send().timeout(const Duration(milliseconds: 200000));

      if (response.statusCode == 200) {
        await ApiService.get(endpoint: AppString.me, token: userToken.value)
            .then((userResponse) {
          if (userResponse.statusCode == 200) {
            var data = json.decode(userResponse.body);
            userData.value = UserModel.fromJson(data['user']);
            box.write('userData', data['user']);
            clear();
            EasyLoading.dismiss();
            if (userData.value.status == 'Admin') {
              Get.offAllNamed(Routes.DASHBOARD_ADMIN);
            } else {
              Get.offAllNamed(Routes.DASHBOARD_USER);
            }
            EasyLoading.showSuccess('Update Profil Berhasil!');
          }
        });
      } else {
        EasyLoading.dismiss();
        var res = await response.stream.bytesToString();
        print(res);
        throw "Update Profil Gagal!\nPeriksa kembali inputan anda atau antara email dan nomor hp sudah digunakan pengguna lain!";
      }
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(
        e.toString(),
        duration: const Duration(seconds: 5),
      );
    }
  }

  Future<void> logout() async {
    try {
      EasyLoading.show(
        status: 'Sedang Logout ...',
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.black,
      );
      await ApiService.delete(
        endpoint: AppString.logout,
        token: userToken.value,
      ).then((response) {
        if (response.statusCode == 200) {
          clear();
          userData.value = UserModel();
          userToken.value = '';
          box.remove('userToken');
          box.remove('userData');
          Get.offAllNamed(Routes.LOGIN);
          EasyLoading.showSuccess('Logout Berhasil!');
        } else {
          var data = json.decode(response.body);
          print(data['message']);
          throw data['message'];
        }
      });
    } catch (e) {
      // print(e);
      EasyLoading.dismiss();
      EasyLoading.showError(e.toString());
    }
  }
}

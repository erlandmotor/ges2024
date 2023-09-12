import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'dart:developer';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:ges2024/app/modules/otp/bindings/otp_bindings.dart';
import 'package:ges2024/app/constant/app_strings.dart';
import 'package:ges2024/app/controllers/auth_controller.dart';
import 'package:ges2024/app/data/models/user_model.dart';
import 'package:ges2024/app/data/services/api_services.dart';
import 'package:ges2024/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashController extends GetxController {
  final authC = Get.find<AuthController>();
  RxString errorMessage = ''.obs;
  RxBool isPermissionGranted = false.obs;

  @override
  void onInit() {
    checkPermissionAndShowDialog();
    super.onInit();
  }

  Future<void> checkPermissionAndShowDialog() async {
    print("cek");
    PermissionStatus? storageStatus;
    PermissionStatus? locationStatus;

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

    if (androidInfo.version.sdkInt <= 33) {
      storageStatus = await Permission.storage.status;
      locationStatus = await Permission.accessMediaLocation.status;
    } else {
      storageStatus = await Permission.manageExternalStorage.status;
    }

    if (!storageStatus.isGranted ||
        (androidInfo.version.sdkInt <= 33 && !locationStatus!.isGranted)) {
      showPermissionExplanationDialog();
    } else {
      cekLogin();
    }
  }

  Future<void> showPermissionExplanationDialog() async {
    return Get.dialog(
      AlertDialog(
        title: const Text('Izin Akses Penyimpanan'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
                'Aplikasi ini membutuhkan akses ke penyimpanan anda untuk keperluan download dan upload data, silahkan beri izin setelah dialog berikut.',
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Tidak'),
            onPressed: () {
              exit(0); // Tutup aplikasi
            },
          ),
          TextButton(
            child: const Text('Ya'),
            onPressed: () {
              Get.back(); // Tutup dialog
              requestStoragePermission(); // Lanjutkan ke request permission
            },
          ),
        ],
      ),
    );
  }

  Future<void> requestStoragePermission() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    if (androidInfo.version.sdkInt <= 33) {
      print("androidInfo.version.sdkInt <= 33");
      var status = await Permission.storage.request();
      var status2 = await Permission.accessMediaLocation.request();
      if (status.isGranted && status2.isGranted) {
        print('Storage Granted');
        cekLogin();
      } else if (status.isPermanentlyDenied && status2.isPermanentlyDenied) {
        print("status.isPermanentlyDenied && status2.isPermanentlyDenied");
        openAppSettings();
        exit(0);
      } else {
        print("ELSE status.isPermanentlyDenied && status2.isPermanentlyDenied");
        openAppSettings();
        exit(0);
      }
    } else {
      print('else');
      var status = await Permission.manageExternalStorage.request();
      if (status.isGranted) {
        print('Storage Granted');
        cekLogin();
      } else if (status.isPermanentlyDenied) {
        print("status.isPermanentlyDenied");
        openAppSettings();
        exit(0);
      } else {
        print("ELSE status.isPermanentlyDenied");
        openAppSettings();
        exit(0);
      }
    }
  }

  Future<void> cekLogin() async {
    await initializeApp().then((response) async {
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        print(data);
        if (data['result'] == true) {
          if (authC.box.read('userToken') != null) {
            authC.userToken.value = authC.box.read('userToken');
            try {
              await ApiService.get(
                      endpoint: AppString.me, token: authC.userToken.value)
                  .then((response) {
                print(response.statusCode);
                if (response.statusCode == 200) {
                  var data = json.decode(response.body);
                  authC.userData.value = UserModel.fromJson(data['user']);
                  log(data['user'].toString());
                  authC.box.write('userData', data['user']);
                  if (authC.userData.value.foto!.contains("no-image") ||
                      authC.userData.value.fotoKtp!.contains("no-image")) {
                    Get.offAllNamed(Routes.CONTINUE_REGISTER);
                  } else {
                    if (authC.userData.value.status == 'Admin') {
                      Get.offAllNamed(Routes.DASHBOARD_ADMIN);
                    } else {
                      Get.offAllNamed(Routes.DASHBOARD_USER);
                    }
                  }
                } else if (response.statusCode == 401) {
                  authC.box.remove('userToken');
                  authC.box.remove('userData');
                  Get.offAllNamed(Routes.LOGIN);
                } else {
                  Get.offAllNamed(Routes.OFFLINE);
                }
              }).onError((error, stackTrace) {
                print(error);
                errorMessage.value =
                    "Ada masalah ke server.\nAplikasi tidak dapat dijalankan.\nSilahkan Restart.";
                authC.box.remove('userToken');
                authC.box.remove('userData');
                Get.offAllNamed(Routes.OFFLINE);
              });
              print(authC.userToken.value);
            } catch (e) {
              errorMessage.value =
                  "Ada masalah ke server.\nAplikasi tidak dapat dijalankan.\nSilahkan Restart.";
              authC.box.remove('userToken');
              authC.box.remove('userData');
              Get.offAllNamed(Routes.LOGIN);
            }
          } else {
            Get.offAllNamed(Routes.LOGIN);
          }
        } else {
          Get.offAllNamed(Routes.OFFLINE);
        }
      }
    }).onError((error, stackTrace) async {
      if (authC.box.read('userToken') != null) {
        authC.userToken.value = authC.box.read('userToken');
        try {
          await ApiService.get(
                  endpoint: AppString.me, token: authC.userToken.value)
              .then((response) {
            print(response.statusCode);
            if (response.statusCode == 200) {
              var data = json.decode(response.body);
              authC.userData.value = UserModel.fromJson(data['user']);
              log(data['user'].toString());
              authC.box.write('userData', data['user']);
              if (authC.userData.value.foto!.contains("no-image") ||
                  authC.userData.value.fotoKtp!.contains("no-image")) {
                Get.offAllNamed(Routes.CONTINUE_REGISTER);
              } else {
                if (authC.userData.value.status == 'Admin') {
                  Get.offAllNamed(Routes.DASHBOARD_ADMIN);
                } else {
                  Get.offAllNamed(Routes.DASHBOARD_USER);
                }
              }
            } else if (response.statusCode == 401) {
              authC.box.remove('userToken');
              authC.box.remove('userData');
              Get.offAllNamed(Routes.LOGIN);
            } else {
              Get.offAllNamed(Routes.OFFLINE);
            }
          }).onError((error, stackTrace) {
            print(error);
            errorMessage.value =
                "Ada masalah ke server.\nAplikasi tidak dapat dijalankan.\nSilahkan Restart.";
            authC.box.remove('userToken');
            authC.box.remove('userData');
            Get.offAllNamed(Routes.OFFLINE);
          });
          print(authC.userToken.value);
        } catch (e) {
          errorMessage.value =
              "Ada masalah ke server.\nAplikasi tidak dapat dijalankan.\nSilahkan Restart.";
          authC.box.remove('userToken');
          authC.box.remove('userData');
          Get.offAllNamed(Routes.LOGIN);
        }
      } else {
        Get.offAllNamed(Routes.LOGIN);
      }
    });
  }
}

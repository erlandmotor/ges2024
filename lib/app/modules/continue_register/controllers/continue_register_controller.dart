import 'dart:convert';
import 'package:ges2024/app/data/models/user_model.dart';
import 'package:ges2024/app/routes/app_pages.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ges2024/app/constant/app_constant.dart';
import 'package:ges2024/app/controllers/auth_controller.dart';
import 'package:ges2024/app/data/services/api_services.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ContinueRegisterController extends GetxController {
  final authC = Get.find<AuthController>();

  RxBool isHidden = true.obs;
  RxBool isReHidden = true.obs;

  String imagePath = '';
  String ktpPath = '';
  final picker = ImagePicker();

  void pickImage() async {
    imagePath = '';
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imagePath = image.path;
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: imagePath,
        maxWidth: 500,
        maxHeight: 500,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Sesuaikan Foto',
            toolbarColor: AppColor.primaryColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true,
            hideBottomControls: false,
            dimmedLayerColor: Colors.black.withOpacity(0.8),
            showCropGrid: false,
          ),
        ],
        compressQuality: 60,
      );
      if (croppedFile != null) {
        imagePath = croppedFile.path;
        authC.fotoController.text = imagePath;
      }
    }
    update();
  }

  void pickKTP() async {
    ktpPath = '';
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      ktpPath = image.path;
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: ktpPath,
        maxWidth: 1000,
        maxHeight: 500,
        aspectRatioPresets: [
          CropAspectRatioPreset.ratio16x9,
        ],
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Sesuaikan KTP',
            toolbarColor: AppColor.primaryColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.ratio16x9,
            lockAspectRatio: true,
            hideBottomControls: false,
            dimmedLayerColor: Colors.black.withOpacity(0.8),
            showCropGrid: false,
          ),
        ],
        compressQuality: 60,
      );
      if (croppedFile != null) {
        ktpPath = croppedFile.path;
        authC.ktpController.text = ktpPath;
      }
    }
    update();
  }

  Future<void> updateData() async {
    try {
      EasyLoading.show(maskType: EasyLoadingMaskType.black);
      await ApiService.post(
        endpoint: AppString.updatePassword,
        token: authC.userToken.value,
        request: {
          'current_password': "password123",
          'new_password': authC.passwordController.text,
          'new_password_confirmation': authC.rePasswordController.text,
        },
      ).then((response) async {
        // var data = json.decode(response.body);
        if (response.statusCode == 200) {
          var headers = {'Accept': 'application/json'};
          var request = http.MultipartRequest(
              'POST', Uri.parse("${AppString.baseUrl}${AppString.updateUser}"));
          request.fields.addAll({
            'id': authC.userData.value.id.toString(),
            'nama_lengkap': authC.userData.value.namaLengkap!,
            'nama_panggilan': authC.userData.value.namaPanggilan ?? "",
            'email': authC.userData.value.email!,
            'no_hp': authC.userData.value.noHp!,
            'nik': authC.userData.value.nik!,
            'provinsi': authC.userData.value.provinsi!,
            'kabupaten': authC.userData.value.kabupaten!,
            'kecamatan': authC.userData.value.kecamatan!,
            'kelurahan': authC.userData.value.kelurahan!,
            'rt': authC.userData.value.rt!,
            'rw': authC.userData.value.rw!,
            'lrg': authC.userData.value.lrg!,
            'kode_referal': authC.userData.value.kodeReferal!,
            'status': authC.userData.value.status!,
          });

          request.headers.addAll(headers);
          request.files.add(await http.MultipartFile.fromPath(
              'foto', authC.fotoController.text));
          request.files.add(await http.MultipartFile.fromPath(
              'foto_ktp', authC.ktpController.text));
          request.headers
              .addAll({'Authorization': 'Bearer ${authC.userToken.value}'});

          http.StreamedResponse response = await request
              .send()
              .timeout(const Duration(milliseconds: 200000));
          print(response.statusCode);
          var res = await response.stream.bytesToString();
          if (response.statusCode == 200) {
            var data = json.decode(res);
            print(data['userData']);
            authC.userData.value = UserModel.fromJson(data['userData']);
            // authC.userToken.value = data['token'];
            // authC.box.write('userToken', authC.userToken.value);
            authC.box.write('userData', data['userData']);
            Get.offAllNamed(Routes.DASHBOARD_USER);
            authC.clear();

            EasyLoading.dismiss();
            EasyLoading.showSuccess('Login Berhasil');
          } else {
            EasyLoading.dismiss();
            print(res);
            throw "Update Gagal!\nPeriksa kembali inputan anda!";
          }
        } else {
          EasyLoading.dismiss();
          throw response.body;
        }
      });
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(e.toString());
    }
  }
}

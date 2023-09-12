import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ges2024/app/constant/app_constant.dart';
import 'package:ges2024/app/controllers/auth_controller.dart';
import 'package:ges2024/app/data/models/kabupaten_model.dart';
import 'package:ges2024/app/data/models/kecamatan_model.dart';
import 'package:ges2024/app/data/models/kelurahan_model.dart';
import 'package:ges2024/app/data/models/provinsi_model.dart';
import 'package:ges2024/app/data/services/api_services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class RegisterController extends GetxController {
  final authC = Get.find<AuthController>();
  bool isLastPage = false;
  int currentPage = 0;
  bool isFirstPage = true;
  PageController pageController = PageController(initialPage: 0);
  String imagePath = '';
  String ktpPath = '';
  final picker = ImagePicker();

  void changePage(bool isBack) {
    pageController.jumpToPage(isBack ? currentPage - 1 : currentPage + 1);
    currentPage = isBack ? currentPage - 1 : currentPage + 1;
    isLastPage = currentPage == 2;
    isFirstPage = currentPage == 0;
    update();
  }

  RxBool isHidden = true.obs;
  RxBool isReHidden = true.obs;
  Provinsi? selectedProvinsi;
  Kabupaten? selectedKabupaten;
  Kecamatan? selectedKecamatan;
  Kelurahan? selectedKelurahan;

  List<Provinsi> dataProvinsi = [];
  List<Kabupaten> dataKabupaten = [];
  List<Kecamatan> dataKecamatan = [];
  List<Kelurahan> dataKelurahan = [];
  @override
  void onInit() {
    currentPage = 0;
    authC.statusController.text = 'Relawan';
    getKabupaten();
    super.onInit();
  }

  // void getProvince() async {
  //   await ApiService.get(endpoint: AppString.provinsi, parameter: 'limit=38')
  //       .then((response) {
  //     Map<String, dynamic> data =
  //         Map<String, dynamic>.from(json.decode(response.body));
  //     for (var element in data['data']) {
  //       dataProvinsi.add(Provinsi.fromJson(element));
  //     }
  //   });
  //   update();
  // }

  Future<void> getKabupaten() async {
    dataKabupaten.clear();
    await ApiService.get(
            endpoint: AppString.kabupaten, parameter: 'provinsi_id=8')
        .then((response) {
      var data = json.decode(response.body);
      for (var element in data) {
        dataKabupaten.add(Kabupaten.fromJson(element));
      }
    });
    selectedKabupaten = dataKabupaten[0];
    authC.kabupatenController.text = selectedKabupaten!.name;

    update();
  }

  Future<void> getKecamatan(int idKabupaten) async {
    dataKecamatan.clear();
    await ApiService.get(
            endpoint: AppString.kecamatan,
            parameter: 'kabupaten_id=$idKabupaten')
        .then((response) {
      var data = json.decode(response.body);
      for (var element in data) {
        dataKecamatan.add(Kecamatan.fromJson(element));
      }
    });
    selectedKecamatan = dataKecamatan[0];
    authC.kecamatanController.text = selectedKecamatan!.name;
    update();
  }

  Future<void> getKelurahan(int idKecamatan) async {
    dataKelurahan.clear();
    await ApiService.get(
            endpoint: AppString.kelurahan,
            parameter: 'kecamatan_id=$idKecamatan')
        .then((response) {
      var data = json.decode(response.body);
      for (var element in data) {
        dataKelurahan.add(Kelurahan.fromJson(element));
      }
    });
    selectedKelurahan = dataKelurahan[0];
    authC.kelurahanController.text = selectedKelurahan!.name;
    update();
  }

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
}

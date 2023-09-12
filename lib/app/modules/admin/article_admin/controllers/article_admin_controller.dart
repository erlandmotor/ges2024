import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ges2024/app/constant/app_constant.dart';
import 'package:ges2024/app/controllers/auth_controller.dart';
import 'package:ges2024/app/data/models/artikel_model.dart';
import 'package:ges2024/app/data/services/api_services.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class ArticleAdminController extends GetxController {
  RxBool isLoading = false.obs;
  final authC = Get.find<AuthController>();
  var articles = RxList<Artikel>([]);
  RxString statusMessage = ''.obs;
  String imagePath = '';
  final picker = ImagePicker();
  TextEditingController judulController = TextEditingController();

  @override
  void onInit() {
    getArticles();
    super.onInit();
  }

  void clear() {
    judulController.clear();
    // kontenController.clear();
    imagePath = '';
  }

  Future<void> addArticle(String konten) async {
    try {
      EasyLoading.show(
        status: 'Loading ...',
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.black,
      );
      var headers = {'Accept': 'application/json'};
      var request = http.MultipartRequest(
          'POST', Uri.parse("${AppString.baseUrl}${AppString.articles}"));
      request.fields.addAll({
        'judul': judulController.text,
        'konten': konten,
      });

      request.headers.addAll(headers);
      request.files.add(await http.MultipartFile.fromPath('gambar', imagePath));
      request.headers
          .addAll({'Authorization': 'Bearer ${authC.userToken.value}'});

      http.StreamedResponse response =
          await request.send().timeout(const Duration(milliseconds: 200000));
      print(response.statusCode);
      if (response.statusCode == 201) {
        await getArticles().then((_) {
          EasyLoading.dismiss();
          Get.back();
          clear();
          EasyLoading.showSuccess('Artikel berhasil ditambah');
        });
      } else {
        EasyLoading.dismiss();
        var res = await response.stream.bytesToString();
        print(res);
        throw "Update Gagal!\nPeriksa kembali inputan anda!";
      }
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(
        e.toString(),
        duration: const Duration(seconds: 5),
      );
    }
  }

  Future<void> editArticle(String id, String konten) async {
    print(id);
    print(konten);
    print(judulController.text);
    print(imagePath);
    print("${AppString.baseUrl}${AppString.articles}/$id");
    try {
      EasyLoading.show(
        status: 'Loading ...',
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.black,
      );
      var headers = {'Accept': 'application/json'};
      var request = http.MultipartRequest('POST',
          Uri.parse("${AppString.baseUrl}${AppString.articles}/update"));
      request.fields.addAll({
        'id': id,
        'judul': judulController.text,
        'konten': konten,
      });

      request.headers.addAll(headers);
      if (imagePath.isNotEmpty) {
        request.files
            .add(await http.MultipartFile.fromPath('gambar', imagePath));
      }
      request.headers
          .addAll({'Authorization': 'Bearer ${authC.userToken.value}'});

      http.StreamedResponse response =
          await request.send().timeout(const Duration(milliseconds: 200000));
      print(response.statusCode);
      var res = await response.stream.bytesToString();
      if (response.statusCode == 200) {
        await getArticles().then((_) {
          EasyLoading.dismiss();
          Get.back;
          clear();
          EasyLoading.showSuccess('Artikel berhasil diubah');
        });
      } else {
        EasyLoading.dismiss();
        throw "Update Gagal!\nPeriksa kembali inputan anda!";
      }
      print(res);
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(
        e.toString(),
        duration: const Duration(seconds: 5),
      );
    }
  }

  Future<void> deleteArticle(int id) async {
    try {
      EasyLoading.show(maskType: EasyLoadingMaskType.black);
      await ApiService.delete(
              endpoint: "${AppString.articles}/$id",
              token: authC.userToken.value)
          .then((response) async {
        var data = json.decode(response.body);

        if (response.statusCode == 200) {
          await getArticles().then((_) {
            EasyLoading.dismiss();
            Get.back();
            Get.back();
            EasyLoading.showSuccess('Artikel Berhasil Dihapus');
            clear();
          });
        } else {
          EasyLoading.dismiss();
          throw data;
        }
        print(response.statusCode);
      });
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(e.toString());
    }
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
          CropAspectRatioPreset.ratio16x9,
        ],
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Sesuaikan Foto',
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
        imagePath = croppedFile.path;
        authC.fotoController.text = imagePath;
      }
    }
    update();
  }

  Future<void> getArticles() async {
    isLoading.value = true;
    try {
      await ApiService.getData(
              endpoint: AppString.articles, token: authC.userToken.value)
          .then((response) {
        articles.clear();
        log(AppString.articles, name: 'ARTICLE URL');
        log(response.data.toString(), name: 'ARTICLES');
        if (response.statusCode == 200) {
          // var data = json.decode(response.data);
          List<dynamic> article = response.data['articles'];
          // print(downlines);
          // print(downlines);
          if (article.isNotEmpty) {
            statusMessage.value = '';
            for (var singleArticle in article) {
              log(singleArticle.toString(), name: 'SINGLE ARTICLE');
              articles.add(Artikel.fromJson(singleArticle));
            }
          } else {
            statusMessage.value = 'Tidak ada artikel';
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
}

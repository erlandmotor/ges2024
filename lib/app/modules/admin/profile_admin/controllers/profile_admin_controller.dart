import 'package:flutter/material.dart';
import 'package:ges2024/app/constant/app_constant.dart';
import 'package:ges2024/app/controllers/auth_controller.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ProfileAdminController extends GetxController {
  final authC = Get.find<AuthController>();
  String imagePath = '';
  final picker = ImagePicker();
  RxBool isOldHidden = true.obs;
  RxBool isNewHidden = true.obs;
  RxBool isReHidden = true.obs;

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
}

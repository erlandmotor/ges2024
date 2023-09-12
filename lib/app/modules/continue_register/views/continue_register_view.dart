import 'package:flutter/material.dart';
import 'package:ges2024/app/constant/app_constant.dart';

import 'package:get/get.dart';

import '../controllers/continue_register_controller.dart';

class ContinueRegisterView extends GetView<ContinueRegisterController> {
  const ContinueRegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> loginKey = GlobalKey<FormState>();
    return WillPopScope(
      onWillPop: () {
        controller.authC.clear();
        return Future.value(true);
      },
      child: GetBuilder<ContinueRegisterController>(builder: (controller) {
        return Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: loginKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: Get.width,
                        alignment: Alignment.center,
                        child: Image.asset(AppImage.logo,
                            height: Get.width * 0.4, width: Get.width * 0.4),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      const Center(
                        child: Text("Selamat Datang",
                            style: AppFont.size24width500),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      const Center(
                        child: Text(
                          "Silahkan lengkapi profil anda",
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      const Text(
                        'Password Baru',
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Obx(
                        () => TextFormField(
                          obscureText: controller.isHidden.value,
                          controller: controller.authC.passwordController,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password tidak boleh kosong!';
                            }
                            if (value.length < 8) {
                              return 'Password minimal 8 karakter!';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: '******',
                            suffixIcon: IconButton(
                                splashRadius: 1,
                                onPressed: () {
                                  controller.isHidden.toggle();
                                },
                                icon: Icon(controller.isHidden.isTrue
                                    ? Icons.remove_red_eye
                                    : Icons.visibility_off_rounded)),
                            prefixIcon: const Icon(Icons.key),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      const Text(
                        'Ulangi Password',
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Obx(
                        () => TextFormField(
                          obscureText: controller.isReHidden.value,
                          controller: controller.authC.rePasswordController,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password tidak boleh kosong!';
                            }
                            if (value !=
                                controller.authC.passwordController.text) {
                              return 'Password tidak sama!';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: '******',
                            suffixIcon: IconButton(
                                splashRadius: 1,
                                onPressed: () {
                                  controller.isReHidden.toggle();
                                },
                                icon: Icon(controller.isReHidden.isTrue
                                    ? Icons.remove_red_eye
                                    : Icons.visibility_off_rounded)),
                            prefixIcon: const Icon(Icons.key),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Card(
                            elevation: 10,
                            color: AppColor.primaryColor,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(16.0),
                              ),
                            ),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(16),
                              onTap: () {
                                controller.pickImage();
                              },
                              child: SizedBox(
                                width: Get.width * 0.4,
                                height: Get.width * 0.4,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    controller.imagePath.isEmpty
                                        ? const Icon(
                                            Icons.photo_camera,
                                            size: 48,
                                            color: Colors.white,
                                          )
                                        : const Icon(
                                            Icons.check_circle,
                                            size: 48,
                                            color: Colors.white,
                                          ),
                                    const SizedBox(
                                      height: 8.0,
                                    ),
                                    Text(
                                      "Foto Pribadi",
                                      style: AppFont.size16width400
                                          .copyWith(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Card(
                            elevation: 10,
                            color: AppColor.primaryColor,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(16.0),
                              ),
                            ),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(16),
                              onTap: () {
                                controller.pickKTP();
                              },
                              child: SizedBox(
                                width: Get.width * 0.4,
                                height: Get.width * 0.4,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    controller.ktpPath.isEmpty
                                        ? SizedBox(
                                            width: 46,
                                            height: 46,
                                            child: Image.asset(AppImage.ktp))
                                        : const Icon(
                                            Icons.check_circle,
                                            size: 48,
                                            color: Colors.white,
                                          ),
                                    const SizedBox(
                                      height: 8.0,
                                    ),
                                    Text(
                                      "Foto KTP",
                                      style: AppFont.size16width400
                                          .copyWith(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (loginKey.currentState!.validate()) {
                            controller.updateData();
                          }
                        },
                        child: const Text(
                          'Lanjutkan',
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () async {
                            controller.authC.clear();
                            controller.authC.logout();
                          },
                          child: const Text(
                            "Logout",
                            style: TextStyle(
                              color: AppColor.primaryColor,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

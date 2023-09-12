import 'package:flutter/material.dart';
import 'package:ges2024/app/constant/app_constant.dart';
import 'package:ges2024/app/controllers/auth_controller.dart';
import 'package:ges2024/app/routes/app_pages.dart';

import 'package:get/get.dart';

import '../controllers/new_password_controller.dart';

class NewPasswordView extends GetView<NewPasswordController> {
  const NewPasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final authC = Get.find<AuthController>();
    GlobalKey<FormState> loginKey = GlobalKey<FormState>();
    return WillPopScope(
      onWillPop: () {
        authC.clear();
        Get.offAllNamed(Routes.LOGIN);
        return Future.value(false);
      },
      child: Scaffold(
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
                    Container(
                        width: Get.width,
                        alignment: Alignment.center,
                        child: const Text("Reset Password",
                            style: AppFont.size24width500)),
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
                        controller: controller.passwordController,
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
                      'Konfirmasi Password',
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Obx(
                      () => TextFormField(
                        obscureText: controller.isReHidden.value,
                        controller: controller.rePasswordController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Konfirmasi Password tidak boleh kosong!';
                          }
                          if (value != controller.passwordController.text) {
                            return 'Konfirmasi Password tidak sama!';
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
                    ElevatedButton(
                      onPressed: () {
                        if (loginKey.currentState!.validate()) {
                          authC.resetPassword(
                            controller.passwordController.text,
                          );
                        }
                      },
                      child: const Text(
                        'Simpan Password',
                      ),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:ges2024/app/constant/app_constant.dart';
import 'package:ges2024/app/controllers/auth_controller.dart';
import 'package:ges2024/app/routes/app_pages.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final authC = Get.find<AuthController>();
    GlobalKey<FormState> loginKey = GlobalKey<FormState>();
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
                  Container(
                      width: Get.width,
                      alignment: Alignment.center,
                      child:
                          const Text("Login", style: AppFont.size24width500)),
                  const SizedBox(
                    height: 16.0,
                  ),
                  const Text(
                    'Email / No HP',
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  TextFormField(
                    controller: authC.identityController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Email / No HP tidak boleh kosong!';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Masukan email atau nomor hp anda',
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  const Text(
                    'Password',
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Obx(
                    () => TextFormField(
                      obscureText: controller.isHidden.value,
                      controller: authC.passwordController,
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
                    height: 16.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Lupa Password?'),
                      GestureDetector(
                        onTap: () {
                          authC.clear();
                          Get.toNamed(Routes.RESET_PASSWORD);
                        },
                        child: const Text(
                          'Reset',
                          style: TextStyle(
                            color: AppColor.primaryColor,
                            decoration: TextDecoration.underline,
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
                        authC.login();
                      }
                    },
                    child: const Text(
                      'Login',
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Belum punya akun?",
                          style: TextStyle(color: AppColor.bodyTextColor)),
                      const SizedBox(
                        width: 8.0,
                      ),
                      GestureDetector(
                        onTap: () async {
                          authC.clear();
                          Get.toNamed(Routes.REGISTER);
                        },
                        child: const Text(
                          "Daftar",
                          style: TextStyle(
                            color: AppColor.primaryColor,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

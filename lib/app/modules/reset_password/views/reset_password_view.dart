import 'package:flutter/material.dart';
import 'package:ges2024/app/constant/app_constant.dart';
import 'package:ges2024/app/controllers/auth_controller.dart';

import 'package:get/get.dart';

import '../controllers/reset_password_controller.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
  const ResetPasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final authC = Get.find<AuthController>();
    GlobalKey<FormState> loginKey = GlobalKey<FormState>();
    return WillPopScope(
      onWillPop: () {
        authC.clear();
        return Future.value(true);
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
                      height: 16.0,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (loginKey.currentState!.validate()) {
                          authC.requestReset();
                        }
                      },
                      child: const Text(
                        'Reset',
                      ),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Ingat Password?",
                            style: TextStyle(color: AppColor.bodyTextColor)),
                        const SizedBox(
                          width: 8.0,
                        ),
                        GestureDetector(
                          onTap: () async {
                            authC.clear();
                            Get.back();
                          },
                          child: const Text(
                            "Login",
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
      ),
    );
  }
}

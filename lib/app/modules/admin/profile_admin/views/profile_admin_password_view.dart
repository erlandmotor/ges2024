import 'package:flutter/material.dart';
import 'package:ges2024/app/modules/admin/profile_admin/controllers/profile_admin_controller.dart';
import 'package:get/get.dart';

class ProfileAdminPasswordView extends GetView<ProfileAdminController> {
  const ProfileAdminPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return WillPopScope(
      onWillPop: () {
        controller.authC.clear();
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Password'),
          leading: IconButton(
            onPressed: () {
              controller.authC.clear();
              Get.back();
            },
            icon: const Icon(Icons.close),
          ),
          actions: [
            IconButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  Get.dialog(
                    AlertDialog(
                      title: const Text('Konfirmasi'),
                      content: const Text('Yakin edit password?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text('Tidak'),
                        ),
                        TextButton(
                          onPressed: () {
                            controller.authC.updatePassword();
                            Get.back();
                          },
                          child: const Text('Ya'),
                        ),
                      ],
                    ),
                  );
                }
              },
              icon: const Icon(Icons.check),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Password Saat Ini',
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Obx(() => TextFormField(
                        obscureText: controller.isOldHidden.value,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password saat ini tidak boleh kosong';
                          }
                          if (value.length < 8) {
                            return 'Password minimal 8 karakter';
                          }
                          return null;
                        },
                        controller: controller.authC.oldPasswordController,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              controller.isOldHidden.value =
                                  !controller.isOldHidden.value;
                            },
                            icon: Obx(
                              () => Icon(
                                controller.isOldHidden.value
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                            ),
                          ),
                        ),
                      )),
                  const SizedBox(
                    height: 8.0,
                  ),
                  const Text(
                    'Password Baru',
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Obx(() => TextFormField(
                        obscureText: controller.isNewHidden.value,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              controller.isNewHidden.value =
                                  !controller.isNewHidden.value;
                            },
                            icon: Obx(
                              () => Icon(
                                controller.isNewHidden.value
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password baru tidak boleh kosong';
                          }
                          if (value.length < 8) {
                            return 'Password minimal 8 karakter';
                          }
                          return null;
                        },
                        controller: controller.authC.passwordController,
                      )),
                  const SizedBox(
                    height: 8.0,
                  ),
                  const Text(
                    'Konfirmasi Password',
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Obx(() => TextFormField(
                        obscureText: controller.isReHidden.value,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              controller.isReHidden.value =
                                  !controller.isReHidden.value;
                            },
                            icon: Obx(
                              () => Icon(
                                controller.isReHidden.value
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Konfirmasi password tidak boleh kosong';
                          }
                          if (value.length < 8) {
                            return 'Password minimal 8 karakter';
                          }
                          if (value !=
                              controller.authC.passwordController.text) {
                            return 'Konfirmasi password tidak sama';
                          }
                          return null;
                        },
                        controller: controller.authC.rePasswordController,
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

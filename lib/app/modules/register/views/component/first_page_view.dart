import 'package:flutter/material.dart';
import 'package:ges2024/app/modules/register/controllers/register_controller.dart';
import 'package:get/get.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(builder: (controller) {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Referal (Opsional)',
            ),
            const SizedBox(
              height: 8.0,
            ),
            TextFormField(
              controller: controller.authC.referalController,
              decoration: const InputDecoration(
                hintText: 'Masukan kode referal',
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            const Text(
              'NIK',
            ),
            const SizedBox(
              height: 8.0,
            ),
            TextFormField(
              controller: controller.authC.nikController,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'NIK tidak boleh kosong!';
                }
                if (!value.isNumericOnly) {
                  return 'NIK tidak valid';
                }
                return null;
              },
              decoration: const InputDecoration(
                hintText: 'Masukan NIK',
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            const Text(
              'Nama Lengkap',
            ),
            const SizedBox(
              height: 8.0,
            ),
            TextFormField(
              controller: controller.authC.nameController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Nama Lengkap tidak boleh kosong!';
                }
                return null;
              },
              decoration: const InputDecoration(
                hintText: 'Masukan nama lengkap sesuai KTP',
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            const Text(
              'Nama Panggilan (Opsional)',
            ),
            const SizedBox(
              height: 8.0,
            ),
            TextFormField(
                controller: controller.authC.namaPanggilanController,
                decoration: const InputDecoration(
                  hintText: 'Masukan nama panggilan (jika ada)',
                )),
            const SizedBox(
              height: 8.0,
            ),
            const Text(
              'Email',
            ),
            const SizedBox(
              height: 8.0,
            ),
            TextFormField(
              controller: controller.authC.emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Email tidak boleh kosong!';
                }
                if (!value.isEmail) {
                  return 'Email tidak valid';
                }
                return null;
              },
              decoration: const InputDecoration(
                hintText: 'email@gmail.com',
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            const Text(
              'No HP',
            ),
            const SizedBox(
              height: 8.0,
            ),
            TextFormField(
              controller: controller.authC.phoneController,
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'No HP tidak boleh kosong!';
                }
                if (!value.isPhoneNumber) {
                  return 'No HP tidak valid';
                }
                return null;
              },
              decoration: const InputDecoration(
                hintText: '08123456789',
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
                ),
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            const Text(
              'Ketik Ulang Password',
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
                  if (value != controller.authC.passwordController.text) {
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
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

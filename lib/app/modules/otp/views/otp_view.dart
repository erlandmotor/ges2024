import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ges2024/app/constant/app_constant.dart';
import 'package:ges2024/app/routes/app_pages.dart';

import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../controllers/otp_controller.dart';

class OtpView extends GetView<OtpController> {
  const OtpView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        controller.authC.clear();
        Get.offAllNamed(Routes.LOGIN);
        return Future.value(false);
      },
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                      child: const Text("Verifikasi OTP",
                          style: AppFont.size24width500)),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Text(
                    "Kode OTP telah dikirim ke ${controller.authC.emailController.text}, silahkan cek folder SPAM juga jika email tidak masuk.",
                    textAlign: TextAlign.center,
                  ),
                  Form(
                    // key: formLoginKey,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          PinCodeTextField(
                            appContext: context,
                            length: 6,
                            obscureText: false,
                            animationType: AnimationType.fade,
                            pinTheme: PinTheme(
                              activeColor: AppColor.primaryColor,
                              inactiveColor: AppColor.alertColor,
                              disabledColor: Colors.amber,
                              selectedColor: AppColor.primaryColor,
                              inactiveFillColor: AppColor.shade,
                              selectedFillColor: AppColor.shade,
                              errorBorderColor: AppColor.alertColor,
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(5),
                              fieldHeight: 50,
                              fieldWidth: 40,
                              activeFillColor: Colors.white,
                            ),
                            animationDuration:
                                const Duration(milliseconds: 300),
                            enableActiveFill: true,
                            autoDisposeControllers: false,
                            controller: controller.authC.passwordController,
                            onCompleted: (value) {
                              controller.authC.verifyOtp();
                              print("Completed");
                            },
                            onChanged: (value) {
                              // print(value);
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                controller.authC.verifyOtp();
                              },
                              child: const Text('Verifikasi')),
                          const SizedBox(
                            height: 16.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Tidak menerima OTP?'),
                              const SizedBox(
                                width: 8.0,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  if (controller.remainingSeconds.value != 0) {
                                    EasyLoading.showToast(
                                        'Anda hanya diperbolehkan meminta OTP setiap 1 menit',
                                        toastPosition:
                                            EasyLoadingToastPosition.bottom);
                                  } else {
                                    await controller.authC
                                        .requestReset()
                                        .then((_) {
                                      EasyLoading.showToast(
                                          'OTP Berhasil Dikirim Ulang, Silahkan Cek Email Anda',
                                          toastPosition:
                                              EasyLoadingToastPosition.bottom);

                                      controller.remainingSeconds.value = 60;
                                    });
                                  }
                                },
                                child: Text(
                                  'Kirim Ulang',
                                  style: AppFont.size14width400.copyWith(
                                    color: AppColor.primaryColor,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 8.0,
                              ),
                              Obx(() => Text(
                                  controller.remainingSeconds.value == 0
                                      ? ''
                                      : "(${controller.remainingSeconds})"))
                            ],
                          )
                        ],
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
  }
}

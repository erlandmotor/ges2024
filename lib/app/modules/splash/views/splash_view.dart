import 'package:flutter/material.dart';
import 'package:ges2024/app/constant/app_constant.dart';

import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Obx(() {
            if (controller.errorMessage.isNotEmpty) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Expanded(child: SizedBox()),
                  Icon(
                    Icons.warning,
                    size: getWidth(context) * 0.3,
                    color: AppColor.alertColor,
                  ),
                  Text(
                    controller.errorMessage.value,
                    textAlign: TextAlign.center,
                  ),
                  const Expanded(child: SizedBox()),
                  const Center(child: CircularProgressIndicator()),
                  const SizedBox(height: 16.0),
                ],
              );
            } else {
              return Column(
                children: [
                  const Expanded(child: SizedBox()),
                  Image.memory(
                    AppImage.byteData,
                    height: getWidth(context) * 0.5,
                    width: getWidth(context) * 0.5,
                  ),
                  const Expanded(child: SizedBox()),
                  const Center(child: CircularProgressIndicator()),
                  const SizedBox(height: 16.0),
                ],
              );
            }
          }),
        ),
      ),
    );
  }
}

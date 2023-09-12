import 'dart:async';

import 'package:ges2024/app/controllers/auth_controller.dart';
import 'package:get/get.dart';

class OtpController extends GetxController {
  final authC = Get.find<AuthController>();
  RxInt remainingSeconds = 60.obs;
  @override
  void onInit() {
    startTimer();
    super.onInit();
  }

  void startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds.value != 0) {
        remainingSeconds--;
      }
    });
  }
}

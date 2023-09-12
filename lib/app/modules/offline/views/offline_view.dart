import 'package:flutter/material.dart';
import 'package:ges2024/app/constant/app_constant.dart';
import 'package:ges2024/app/routes/app_pages.dart';

import 'package:get/get.dart';

import '../controllers/offline_controller.dart';

class OfflineView extends GetView<OfflineController> {
  const OfflineView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: getWidth(context) * 0.6,
                child: Image.asset(
                  AppImage.maintenance,
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              const Text(
                "Oops!",
                style: AppFont.size24width700,
                textAlign: TextAlign.center,
              ),
              const Text(
                "Server sedang offline atau dalam perbaikan.\nSilahkan coba dalam beberapa saat lagi,",
                style: AppFont.size16width400,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 16.0,
              ),
              SizedBox(
                width: getWidth(context) * 0.4,
                child: OutlinedButton.icon(
                    onPressed: () {
                      Get.offAllNamed(Routes.SPLASH);
                    },
                    icon: const Icon(Icons.restart_alt),
                    label: const Text('Restart')),
              )
            ],
          ),
        ),
      ),
    );
  }
}

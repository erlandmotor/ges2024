import 'package:flutter/material.dart';
import 'package:ges2024/app/constant/app_constant.dart';
import 'package:ges2024/app/modules/register/views/component/first_page_view.dart';
import 'package:ges2024/app/modules/register/views/component/second_page_view.dart';
import 'package:ges2024/app/modules/register/views/component/third_page_view.dart';
import 'package:get/get.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> registerKey = GlobalKey<FormState>();
    return GetBuilder<RegisterController>(builder: (controller) {
      return WillPopScope(
        onWillPop: () {
          if (controller.isFirstPage) {
            controller.authC.clear();
            Get.back();
          } else {
            controller.changePage(true);
          }
          return Future.value(false);
        },
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Container(
                    width: Get.width,
                    alignment: Alignment.center,
                    child: Image.asset(AppImage.logo,
                        height: Get.width * 0.4, width: Get.width * 0.4),
                  ),
                  Container(
                      width: Get.width,
                      alignment: Alignment.center,
                      child:
                          const Text("Daftar", style: AppFont.size24width500)),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Expanded(
                    child: Form(
                      key: registerKey,
                      child: PageView(
                        pageSnapping: false,
                        physics: const NeverScrollableScrollPhysics(),
                        controller: controller.pageController,
                        children: const [
                          FirstPage(),
                          SecondPage(),
                          ThirdPage(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: controller.isFirstPage
                ? ElevatedButton(
                    onPressed: () {
                      if (registerKey.currentState!.validate()) {
                        controller.changePage(false);
                      }
                    },
                    child: const Text('Selanjutnya'))
                : Row(
                    children: [
                      Expanded(
                          child: OutlinedButton(
                              onPressed: () {
                                controller.changePage(true);
                              },
                              child: const Text('Kembali'))),
                      const SizedBox(
                        width: 16.0,
                      ),
                      controller.isLastPage
                          ? Expanded(
                              child: ElevatedButton(
                                  onPressed: () {
                                    if (registerKey.currentState!.validate()) {}
                                    controller.authC.register();
                                  },
                                  child: const Text('Daftar')),
                            )
                          : Expanded(
                              child: ElevatedButton(
                                  onPressed: () {
                                    if (registerKey.currentState!.validate()) {
                                      controller.changePage(false);
                                    }
                                  },
                                  child: const Text('Selanjutnya')),
                            ),
                    ],
                  ),
          ),
        ),
      );
    });
  }
}

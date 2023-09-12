import 'package:flutter/material.dart';
import 'package:ges2024/app/constant/app_constant.dart';
import 'package:ges2024/app/modules/register/controllers/register_controller.dart';
import 'package:get/get.dart';

class ThirdPage extends StatelessWidget {
  const ThirdPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(builder: (controller) {
      return Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Card(
              elevation: 10,
              color: AppColor.primaryColor,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(16.0),
                ),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  controller.pickImage();
                },
                child: SizedBox(
                  width: Get.width * 0.4,
                  height: Get.width * 0.4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      controller.imagePath.isEmpty
                          ? const Icon(
                              Icons.photo_camera,
                              size: 48,
                              color: Colors.white,
                            )
                          : const Icon(
                              Icons.check_circle,
                              size: 48,
                              color: Colors.white,
                            ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        "Foto Pribadi",
                        style: AppFont.size16width400
                            .copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              elevation: 10,
              color: AppColor.primaryColor,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(16.0),
                ),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  controller.pickKTP();
                },
                child: SizedBox(
                  width: Get.width * 0.4,
                  height: Get.width * 0.4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      controller.ktpPath.isEmpty
                          ? SizedBox(
                              width: 46,
                              height: 46,
                              child: Image.asset(AppImage.ktp))
                          : const Icon(
                              Icons.check_circle,
                              size: 48,
                              color: Colors.white,
                            ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        "Foto KTP",
                        style: AppFont.size16width400
                            .copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

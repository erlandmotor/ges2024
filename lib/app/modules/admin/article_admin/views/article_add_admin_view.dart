import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ges2024/app/constant/app_constant.dart';
import 'package:ges2024/app/modules/admin/article_admin/controllers/article_admin_controller.dart';
import 'package:get/get.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

class ArticleAdminAddView extends GetView<ArticleAdminController> {
  const ArticleAdminAddView({super.key});

  @override
  Widget build(BuildContext context) {
    final QuillEditorController kontenController = QuillEditorController();
    return WillPopScope(
      onWillPop: () {
        controller.clear();
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Tambah Artikel'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GetBuilder<ArticleAdminController>(builder: (controller) {
                  if (controller.imagePath.isNotEmpty) {
                    return GestureDetector(
                      onTap: () => Get.bottomSheet(
                        Stack(
                          children: [
                            SizedBox(
                              // color: Colors.black,
                              width: Get.width,
                              height: Get.height,
                              child: PinchZoom(
                                maxScale: 10,
                                child: Image.file(File(controller.imagePath)),
                              ),
                            ),
                            Positioned(
                              right: 8,
                              top: kToolbarHeight / 2,
                              child: SizedBox(
                                width: 48,
                                height: 48,
                                child: ElevatedButton(
                                  onPressed: () => Get.back(),
                                  style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(48.0),
                                        ),
                                      )),
                                  child: const Icon(Icons.close),
                                ),
                              ),
                            ),
                          ],
                        ),
                        ignoreSafeArea: true,
                        isScrollControlled: true,
                        isDismissible: false,
                        enableDrag: false,
                      ),
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(12.0),
                              ),
                              color: AppColor.lineShapeColor,
                              image: DecorationImage(
                                  image:
                                      FileImage(File(controller.imagePath)))),
                        ),
                      ),
                    );
                  } else {
                    return GestureDetector(
                      onTap: () {
                        controller.pickImage();
                      },
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Container(
                          // width: Get.width,
                          // height: Get.width * 0.3,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12.0),
                            ),
                            color: AppColor.lineShapeColor,
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.image,
                                color: AppColor.primaryDark,
                                size: 72,
                              ),
                              Text("Tambah Gambar"),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                }),
                const SizedBox(
                  height: 16.0,
                ),
                const Text('Judul'),
                const SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                  controller: controller.judulController,
                  decoration: const InputDecoration(
                    hintText: 'Masukan judul artikel',
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                const Text('Konten'),
                const SizedBox(
                  height: 8.0,
                ),
                ToolBar(
                  toolBarColor: AppColor.lineShapeColor,
                  activeIconColor: AppColor.primaryDark,
                  padding: const EdgeInsets.all(8),
                  iconSize: 20,
                  controller: kontenController,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColor.bodyTextColor,
                      ),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      )),
                  child: QuillHtmlEditor(
                    hintText: 'Masukan konten disini',
                    text: 'Masukan konten disini',
                    controller: kontenController,
                    isEnabled: true,
                    minHeight: 300,
                    hintTextAlign: TextAlign.start,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    hintTextPadding: EdgeInsets.zero,
                    textStyle: AppFont.size14width400,
                    loadingBuilder: (context) {
                      return const Center(
                          child: CircularProgressIndicator(
                        strokeWidth: 0.4,
                      ));
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          child: ElevatedButton(
              onPressed: () async {
                String konten = await kontenController.getText();
                controller.addArticle(konten);
              },
              child: const Text("Tambah")),
        ),
      ),
    );
  }
}

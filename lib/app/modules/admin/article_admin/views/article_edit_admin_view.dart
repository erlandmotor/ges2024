import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ges2024/app/constant/app_constant.dart';
import 'package:ges2024/app/data/models/artikel_model.dart';
import 'package:ges2024/app/modules/admin/article_admin/controllers/article_admin_controller.dart';
import 'package:get/get.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

class ArticleAdminEditView extends GetView<ArticleAdminController> {
  const ArticleAdminEditView({super.key});

  @override
  Widget build(BuildContext context) {
    final QuillEditorController kontenController = QuillEditorController();

    final Artikel article = Get.arguments;
    controller.judulController.text = article.judul;
    kontenController.setText(article.konten);
    // kontenController.setText(article.konten);
    return WillPopScope(
      onWillPop: () {
        controller.clear();
        // Get.off(() => const ArticleDetailAdminView(), arguments: article);
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Artikel'),
          leading: IconButton(
            onPressed: () {
              controller.clear();
              Get.back();
              // Get.off(() => const ArticleDetailAdminView(), arguments: article);
            },
            icon: const Icon(
              Icons.close,
              size: 24.0,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () async {
                String konten = await kontenController.getText();
                controller.editArticle(article.id.toString(), konten);
              },
              icon: const Icon(
                Icons.check,
                size: 24.0,
              ),
            ),
          ],
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
                      onTap: () => controller.pickImage(),
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
                    return CachedNetworkImage(
                      imageUrl: article.gambar,
                      imageBuilder: (context, imageProvider) => GestureDetector(
                        onTap: () {
                          controller.pickImage();
                        },
                        child: AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(12.0),
                              ),
                              color: AppColor.lineShapeColor,
                              image: DecorationImage(image: imageProvider),
                            ),
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
                    text: article.konten,
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
      ),
    );
  }
}

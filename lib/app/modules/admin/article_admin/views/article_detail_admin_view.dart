import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:ges2024/app/data/models/artikel_model.dart';
import 'package:ges2024/app/modules/admin/article_admin/controllers/article_admin_controller.dart';
import 'package:ges2024/app/modules/admin/article_admin/views/article_edit_admin_view.dart';

import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ArticleDetailAdminView extends GetView<ArticleAdminController> {
  const ArticleDetailAdminView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Artikel artikel = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(artikel.judul),
        centerTitle: true,
        actions: [
          IconButton(
            constraints: const BoxConstraints(),
            splashRadius: 24,
            onPressed: () async {
              controller.judulController.text = artikel.judul;
              Get.off(() => const ArticleAdminEditView(), arguments: artikel);
            },
            icon: const Icon(
              Icons.edit,
              size: 24.0,
            ),
          ),
          IconButton(
            constraints: const BoxConstraints(),
            splashRadius: 24,
            onPressed: () {
              Get.dialog(
                AlertDialog(
                  title: const Text("Hapus"),
                  content: const Text("Apakah anda yakin ingin menghapus?"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text("Batal"),
                    ),
                    TextButton(
                      onPressed: () {
                        controller.deleteArticle(artikel.id);
                      },
                      child: const Text("Ya"),
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(
              Icons.delete,
              size: 24.0,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CachedNetworkImage(
                imageUrl: artikel.gambar,
                imageBuilder: (context, imageProvider) => Container(
                  height: Get.height * 0.25,
                  width: Get.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey,
                    highlightColor: Colors.white,
                    child: Container(
                      height: Get.height * 0.25,
                      width: Get.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey,
                      ),
                    )),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              const SizedBox(
                height: 16.0,
              ),
              HtmlWidget(artikel.konten),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ges2024/app/constant/app_constant.dart';
import 'package:ges2024/app/modules/admin/article_admin/views/article_add_admin_view.dart';
import 'package:ges2024/app/modules/admin/article_admin/views/article_detail_admin_view.dart';

import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../controllers/article_admin_controller.dart';

class ArticleAdminView extends GetView<ArticleAdminController> {
  const ArticleAdminView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Artikel'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => const ArticleAdminAddView());
            },
            icon: const Icon(
              Icons.add,
              size: 24.0,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(() {
          if (controller.isLoading.isTrue) {
            return Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: ListView.separated(
                itemCount: 10,
                itemBuilder: (context, index) => Container(
                  width: Get.width,
                  height: 64,
                  decoration: BoxDecoration(
                    color: AppColor.bodyTextColor,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 16.0,
                ),
              ),
            );
          }
          if (controller.statusMessage.isNotEmpty) {
            return Center(
              child: Text(
                controller.statusMessage.value,
                textAlign: TextAlign.center,
              ),
            );
          } else {
            return ListView.builder(
              itemBuilder: (context, index) {
                print(controller.articles[index].gambar);
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 5,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      Get.to(() => const ArticleDetailAdminView(),
                          arguments: controller.articles[index]);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          CachedNetworkImage(
                            imageUrl: controller.articles[index].gambar,
                            imageBuilder: (context, imageProvider) => Container(
                              height: Get.height * 0.2,
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
                                  height: Get.height * 0.2,
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey,
                                  ),
                                )),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            controller.articles[index].judul,
                            style: AppFont.size16width600,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: controller.articles.length,
            );
          }
        }),
      ),
    );
  }
}

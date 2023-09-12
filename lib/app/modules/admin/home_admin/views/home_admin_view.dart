import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ges2024/app/constant/app_constant.dart';
import 'package:ges2024/app/routes/app_pages.dart';

import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../controllers/home_admin_controller.dart';

class HomeAdminView extends GetView<HomeAdminController> {
  const HomeAdminView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print(controller.authC.userData.value.foto);
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Admin Panel'),
      //   centerTitle: true,
      // ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        CachedNetworkImage(
                          imageUrl: controller.authC.userData.value.foto ??
                              "https://via.placeholder.com/150",
                          imageBuilder: (context, imageProvider) =>
                              CircleAvatar(
                            radius: 24,
                            backgroundImage: imageProvider,
                          ),
                          placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            child: const CircleAvatar(
                              radius: 24,
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              const CircleAvatar(
                            radius: 24,
                            child: Icon(Icons.error),
                          ),
                        ),
                        const SizedBox(
                          width: 8.0,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hallo, ${controller.authC.userData.value.namaPanggilan != null ? controller.authC.userData.value.namaPanggilan != "" ? controller.authC.userData.value.namaPanggilan : controller.authC.userData.value.namaLengkap : controller.authC.userData.value.namaLengkap}",
                                style: AppFont.size16width500,
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12.0),
                      ),
                      color: AppColor.primaryColor,
                    ),
                    child: Text(controller.authC.userData.value.status!,
                        style: AppFont.size14width500
                            .copyWith(color: Colors.white)),
                  ),
                ],
              ),
              // const SizedBox(
              //   height: 16.0,
              // ),
              Column(
                children: [
                  GetBuilder<HomeAdminController>(
                      initState: (state) => controller.countUsers(),
                      builder: (context) {
                        return RefreshIndicator(
                          onRefresh: () => controller.countUsers(),
                          color: AppColor.primaryColor,
                          child: Center(
                            child: GridView(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                                // childAspectRatio: 1.5,
                              ),
                              children: [
                                CustomCard(
                                  onTap: () {
                                    Get.toNamed(Routes.USERS_ADMIN);
                                  },
                                  title: 'Anggota',
                                  value: controller.totalAnggota,
                                ),
                                CustomCard(
                                  onTap: () {
                                    Get.toNamed(Routes.ADMIN_ADMIN);
                                  },
                                  title: 'Admin',
                                  value: controller.totalAdmin,
                                ),
                                CustomCard(
                                  onTap: () {
                                    Get.toNamed(Routes.USERS_ADMIN);
                                  },
                                  title: 'Tim',
                                  value: controller.totalTim,
                                ),
                                CustomCard(
                                  onTap: () {
                                    Get.toNamed(Routes.USERS_ADMIN);
                                  },
                                  title: 'Relawan',
                                  value: controller.totalRelawan,
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      tileColor: AppColor.primaryColor.withOpacity(0.8),
                      onTap: () {
                        Get.toNamed(Routes.WILAYAH_ADMIN);
                      },
                      leading: Image.asset(
                        AppImage.wilayah,
                        height: 24,
                        width: 24,
                      ),
                      title: Text(
                        'Data Per Wilayah',
                        style: AppFont.size18width700.copyWith(
                          color: AppColor.shade,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                        color: AppColor.shade,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      tileColor: AppColor.primaryColor.withOpacity(0.8),
                      onTap: () {
                        Get.toNamed(Routes.DPT);
                      },
                      leading: Image.asset(
                        AppImage.kpu,
                        height: 24,
                        width: 24,
                      ),
                      title: Text(
                        'Cek DPT Online',
                        style: AppFont.size18width700.copyWith(
                          color: AppColor.shade,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                        color: AppColor.shade,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(),
              // const SizedBox(
              //   height: 16.0,
              // ),
              // Card(
              //   elevation: 5,
              //   child: ListTile(
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(12),
              //     ),
              //     tileColor: AppColor.primaryColor.withOpacity(0.8),
              //     onTap: () {
              //       Get.offAllNamed(Routes.IMPORT_ADMIN);
              //     },
              //     leading: Image.asset(
              //       AppImage.import,
              //       height: 24,
              //       width: 24,
              //     ),
              //     title: Text(
              //       'Import Data',
              //       style: AppFont.size18width700.copyWith(
              //         color: AppColor.shade,
              //         fontWeight: FontWeight.bold,
              //       ),
              //     ),
              //     trailing: const Icon(
              //       Icons.arrow_forward_ios,
              //       size: 18,
              //       color: AppColor.shade,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.title,
    required this.value,
    required this.onTap,
  });

  final String title;
  final int value;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: AppColor.primaryColor.withOpacity(0.8),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppImage.getImage(title),
                height: 48,
                width: 48,
              ),
              AutoSizeText(
                value.toString(),
                style: AppFont.size24width700.copyWith(color: AppColor.shade),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 8.0,
              ),
              AutoSizeText(
                title,
                style: AppFont.size18width700.copyWith(color: AppColor.shade),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ges2024/app/constant/app_constant.dart';
import 'package:ges2024/app/modules/admin/profile_admin/views/profile_admin_edit_view.dart';
import 'package:ges2024/app/modules/admin/profile_admin/views/profile_admin_password_view.dart';

import 'package:get/get.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:shimmer/shimmer.dart';

import '../controllers/profile_admin_controller.dart';

class ProfileAdminView extends GetView<ProfileAdminController> {
  const ProfileAdminView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CachedNetworkImage(
                imageUrl: controller.authC.userData.value.foto ??
                    "https://via.placeholder.com/150",
                imageBuilder: (context, imageProvider) => GestureDetector(
                  onTap: () => Get.bottomSheet(
                    Stack(
                      children: [
                        SizedBox(
                          // color: Colors.black,
                          width: Get.width,
                          height: Get.height,
                          child: PinchZoom(
                            maxScale: 10,
                            child: Image(image: imageProvider),
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
                  child: Center(
                    child: CircleAvatar(
                      radius: 72,
                      backgroundImage: imageProvider,
                    ),
                  ),
                ),
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: const Center(
                    child: CircleAvatar(
                      radius: 72,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => const Center(
                  child: CircleAvatar(
                    radius: 72,
                    child: Icon(Icons.error),
                  ),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Text(controller.authC.userData.value.namaLengkap!,
                  style: AppFont.size18width700),
              const SizedBox(
                height: 8.0,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                  color: AppColor.primaryColor,
                ),
                child: Text(controller.authC.userData.value.status!,
                    style:
                        AppFont.size16width500.copyWith(color: Colors.white)),
              ),
              const SizedBox(
                height: 16.0,
              ),
              // const Divider(),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                surfaceTintColor: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    Get.to(() => const ProfileAdminEditView());
                  },
                  child: const ListTile(
                    leading: Icon(
                      Icons.person,
                      size: 32,
                      color: AppColor.primaryColor,
                    ),
                    title: Text(
                      "Edit Profil",
                      style: AppFont.size16width500,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: AppColor.primaryColor,
                    ),
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                surfaceTintColor: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    Get.to(() => const ProfileAdminPasswordView());
                  },
                  child: const ListTile(
                    leading: Icon(
                      Icons.key,
                      size: 32,
                      color: AppColor.primaryColor,
                    ),
                    title: Text(
                      "Keamanan",
                      style: AppFont.size16width500,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: AppColor.primaryColor,
                    ),
                  ),
                ),
              ),
              // Card(
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(12.0),
              //   ),
              //   surfaceTintColor: Colors.transparent,
              //   child: InkWell(
              //     borderRadius: BorderRadius.circular(12),
              //     onTap: () {
              //       Get.dialog(const AboutDialog());
              //     },
              //     child: const ListTile(
              //       leading: Icon(
              //         Icons.info,
              //         size: 32,
              //         color: AppColor.primaryColor,
              //       ),
              //       title: Text(
              //         "Tentang Aplikasi",
              //         style: AppFont.size16width500,
              //       ),
              //       trailing: Icon(
              //         Icons.arrow_forward_ios,
              //         color: AppColor.primaryColor,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
            bottom: kBottomNavigationBarHeight + 24, left: 16, right: 16),
        child: ElevatedButton.icon(
            onPressed: () {
              Get.dialog(AlertDialog(
                title: const Text("Logout"),
                content: const Text("Apakah anda yakin ingin keluar?"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text("Batal"),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.back();
                      controller.authC.logout();
                    },
                    child: const Text("Ya"),
                  ),
                ],
              ));
            },
            icon: const Icon(Icons.logout),
            label: const Text('Logout')),
      ),
    );
  }
}

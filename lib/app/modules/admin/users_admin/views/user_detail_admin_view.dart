import 'package:cached_network_image/cached_network_image.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ges2024/app/constant/app_constant.dart';
import 'package:ges2024/app/data/models/user_model.dart';
import 'package:ges2024/app/modules/admin/users_admin/controllers/users_admin_controller.dart';
import 'package:ges2024/app/modules/admin/users_admin/views/user_edit_admin_view.dart';
import 'package:get/get.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:shimmer/shimmer.dart';

class UserDetailAdminView extends GetView<UsersAdminController> {
  final UserModel user; // Anda bisa mengganti ini dengan GetX controller Anda

  const UserDetailAdminView({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Anggota'),
        actions: [
          IconButton(
            splashRadius: 24,
            constraints: const BoxConstraints(),
            tooltip: 'Edit',
            onPressed: () {
              controller.getKabupaten().then((value) =>
                  Get.off(() => const UserEditAdminView(), arguments: user));
            },
            icon: const Icon(
              Icons.edit,
              size: 24.0,
            ),
          ),
          IconButton(
            splashRadius: 24,
            constraints: const BoxConstraints(),
            tooltip: 'Hapus',
            onPressed: () {
              if (user.downline!.isNotEmpty) {
                EasyLoading.showError(
                    'Tidak dapat menghapus pengguna karena masih ada anggota tim dibawahnya!');
              } else {
                Get.dialog(AlertDialog(
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
                        controller.deleteUser(user.id!);
                      },
                      child: const Text("Ya"),
                    ),
                  ],
                ));
              }
            },
            icon: const Icon(
              Icons.delete,
              size: 24.0,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      const Text('Foto'),
                      const SizedBox(
                        height: 8.0,
                      ),
                      CachedNetworkImage(
                        imageUrl:
                            user.foto ?? "https://via.placeholder.com/150",
                        imageBuilder: (context, imageProvider) =>
                            GestureDetector(
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
                              backgroundColor: Colors.transparent,
                              radius: 48,
                              backgroundImage: imageProvider,
                            ),
                          ),
                        ),
                        placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: const Center(
                            child: CircleAvatar(
                              radius: 48,
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => const Center(
                          child: CircleAvatar(
                            radius: 48,
                            child: Icon(Icons.error),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text('Foto KTP'),
                      const SizedBox(
                        height: 8.0,
                      ),
                      CachedNetworkImage(
                        imageUrl:
                            user.fotoKtp ?? "https://via.placeholder.com/150",
                        imageBuilder: (context, imageProvider) =>
                            GestureDetector(
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
                            child: Container(
                              width: 171,
                              height: 96,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.contain)),
                            ),
                          ),
                        ),
                        placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            width: 128,
                            height: 96,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => const Center(
                          child: CircleAvatar(
                            radius: 48,
                            child: Icon(Icons.error),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Center(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                    color: AppColor.primaryColor,
                  ),
                  child: Text(user.status!,
                      style:
                          AppFont.size16width500.copyWith(color: Colors.white)),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              userDetailTable(),
              const SizedBox(
                height: 16.0,
              ),
              ExpansionTileCard(
                elevation: 5,
                leading: const Icon(
                  Icons.people,
                  color: AppColor.primaryColor,
                ),
                title: const Text("Data Tim"),
                children: user.downline!
                    .map(
                      (downline) => ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(downline.user!.foto ??
                              'https://via.placeholder.com/150'),
                        ),
                        title: Text(downline.user!.namaLengkap!),
                        subtitle: Text(downline.user!.email!),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget userDetailTable() {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(3),
      },
      children: [
        detailItem('Nama Lengkap', user.namaLengkap),
        detailItem('Nama Panggilan', user.namaPanggilan),
        detailItem('Email', user.email),
        detailItem('No HP', user.noHp),
        detailItem('NIK', user.nik),
        detailItem('Kabupaten', user.kabupaten),
        detailItem('Kecamatan', user.kecamatan),
        detailItem('Kelurahan', user.kelurahan),
        detailItem('RT', user.rt),
        detailItem('RW', user.rw),
        detailItem('Lorong / Jalan', user.lrg),
        detailItem('Jumlah Rekrut', user.jumlahRekrut.toString()),
      ],
    );
  }

  TableRow detailItem(String title, String? value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child:
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(value ?? '-'),
        ),
      ],
    );
  }
}

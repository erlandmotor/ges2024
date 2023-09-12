import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ges2024/app/data/models/kabupaten_model.dart';
import 'package:ges2024/app/data/models/kecamatan_model.dart';
import 'package:ges2024/app/data/models/kelurahan_model.dart';
import 'package:ges2024/app/data/models/user_model.dart';
import 'package:ges2024/app/modules/admin/users_admin/controllers/users_admin_controller.dart';
import 'package:ges2024/app/modules/admin/users_admin/views/user_detail_admin_view.dart';
import 'package:get/get.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:shimmer/shimmer.dart';

class UserEditAdminView extends GetView<UsersAdminController> {
  const UserEditAdminView({super.key});

  @override
  Widget build(BuildContext context) {
    final UserModel user = Get.arguments;
    controller.authC.nameController.text = user.namaLengkap!;
    controller.authC.namaPanggilanController.text = user.namaPanggilan ?? "";
    controller.authC.emailController.text = user.email!;
    controller.authC.statusController.text = user.status!;
    controller.authC.phoneController.text = user.noHp!;
    controller.authC.nikController.text = user.nik!;
    controller.authC.rtController.text = user.rt!;
    controller.authC.rwController.text = user.rw!;
    controller.authC.lrgController.text = user.lrg!;
    controller.authC.provinsiController.text = user.provinsi!;
    controller.authC.kabupatenController.text = user.kabupaten!;
    controller.authC.kecamatanController.text = user.kecamatan!;
    controller.authC.kelurahanController.text = user.kelurahan!;
    controller.selectedKabupaten = controller.dataKabupaten
        .where((kabupaten) => kabupaten.name == user.kabupaten)
        .first;
    controller
        .getKecamatan(controller.selectedKabupaten!.id)
        .then((_) => controller.selectedKecamatan = controller.dataKecamatan
            .where((kecamatan) => kecamatan.name == user.kecamatan)
            .first)
        .then((_) => controller
            .getKelurahan(controller.selectedKecamatan!.id)
            .then((_) => controller.selectedKelurahan = controller.dataKelurahan
                .where((kelurahan) => kelurahan.name == user.kelurahan)
                .first));

    final formKey = GlobalKey<FormState>();
    return WillPopScope(
      onWillPop: () {
        Get.off(() => UserDetailAdminView(user: user));
        return Future.value(false);
      },
      child: GetBuilder<UsersAdminController>(builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Edit User'),
            leading: IconButton(
              onPressed: () {
                controller.authC.clear();
                Get.back();
              },
              icon: const Icon(Icons.close),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    Get.dialog(
                      AlertDialog(
                        title: const Text('Konfirmasi'),
                        content: const Text('Yakin edit user?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: const Text('Tidak'),
                          ),
                          TextButton(
                            onPressed: () {
                              controller.editUser(user);
                              Get.back();
                            },
                            child: const Text('Ya'),
                          ),
                        ],
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.check),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            GetBuilder<UsersAdminController>(
                                builder: (controller) {
                              if (controller
                                  .authC.fotoController.text.isNotEmpty) {
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
                                            child: Image.file(File(controller
                                                .authC.fotoController.text)),
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
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
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
                                      backgroundImage: FileImage(File(controller
                                          .authC.fotoController.text)),
                                    ),
                                  ),
                                );
                              } else {
                                return CachedNetworkImage(
                                  imageUrl: user.foto ??
                                      "https://via.placeholder.com/150",
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
                                              child:
                                                  Image(image: imageProvider),
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
                                                    shape:
                                                        const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
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
                                        radius: 48,
                                        backgroundImage: imageProvider,
                                      ),
                                    ),
                                  ),
                                  placeholder: (context, url) =>
                                      Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    child: const Center(
                                      child: CircleAvatar(
                                        radius: 48,
                                      ),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Center(
                                    child: CircleAvatar(
                                      radius: 48,
                                      child: Icon(Icons.error),
                                    ),
                                  ),
                                );
                              }
                            }),
                            Center(
                                child: TextButton(
                                    onPressed: () {
                                      controller.pickImage();
                                    },
                                    child: const Text('Edit Foto'))),
                          ],
                        ),
                        Column(
                          children: [
                            CachedNetworkImage(
                              imageUrl: user.fotoKtp ??
                                  "https://via.placeholder.com/150",
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
                                                shape:
                                                    const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
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
                              errorWidget: (context, url, error) =>
                                  const Center(
                                child: CircleAvatar(
                                  radius: 48,
                                  child: Icon(Icons.error),
                                ),
                              ),
                            ),
                            const Center(
                                child: TextButton(
                                    onPressed: null, child: Text('Foto KTP'))),
                          ],
                        ),
                      ],
                    ),
                    const Text(
                      'Nama Lengkap',
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Nama Lengkap tidak boleh kosong';
                        }
                        return null;
                      },
                      controller: controller.authC.nameController,
                      keyboardType: TextInputType.name,
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    const Text(
                      'Nama Panggilan (Opsional)',
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    TextFormField(
                      controller: controller.authC.namaPanggilanController,
                      keyboardType: TextInputType.name,
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    const Text(
                      'Email',
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Email tidak boleh kosong';
                        }
                        if (!value.isEmail) {
                          return 'Email tidak valid';
                        }
                        return null;
                      },
                      controller: controller.authC.emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    const Text(
                      'No HP',
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'No HP tidak boleh kosong';
                        }
                        if (!value.isPhoneNumber) {
                          return 'No HP tidak valid';
                        }
                        return null;
                      },
                      controller: controller.authC.phoneController,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    const Text(
                      'NIK',
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    TextFormField(
                      controller: controller.authC.nikController,
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    const Text(
                      'Provinsi',
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(
                        fillColor: Colors.grey[300],
                      ),
                      initialValue: user.provinsi!,
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    const Text(
                      'Kabupaten / Kota',
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    DropdownButtonFormField<Kabupaten>(
                      isExpanded: true,
                      validator: (value) {
                        if (value == null) {
                          return 'Kabupaten / Kota tidak boleh kosong!';
                        }
                        return null;
                      },
                      hint: const Text("Pilih Kabupaten"),
                      value: controller.selectedKabupaten,
                      items: controller.dataKabupaten.map((item) {
                        return DropdownMenuItem<Kabupaten>(
                          value: item,
                          child: Text("${item.type} ${item.name}"),
                        );
                      }).toList(),
                      onChanged: (value) {
                        controller.selectedKabupaten = value;
                        controller.authC.kabupatenController.text = value!.name;
                        controller.getKecamatan(value.id).then((_) {
                          controller
                              .getKelurahan(controller.dataKecamatan[0].id);
                        });
                      },
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    const Text(
                      'Kecamatan',
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    DropdownButtonFormField<Kecamatan>(
                      isExpanded: true,
                      validator: (value) {
                        if (value == null) {
                          return 'Kecamatan tidak boleh kosong!';
                        }
                        return null;
                      },
                      hint: const Text("Pilih Kecamatan"),
                      value: controller.selectedKecamatan,
                      items: controller.dataKecamatan.map((item) {
                        return DropdownMenuItem<Kecamatan>(
                          value: item,
                          child: Text(item.name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        controller.selectedKecamatan = value;
                        controller.authC.kecamatanController.text = value!.name;
                        controller.selectedKelurahan = null;
                        controller.getKelurahan(value.id);
                      },
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    const Text(
                      'Kelurahan / Desa',
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    DropdownButtonFormField<Kelurahan>(
                      isExpanded: true,
                      validator: (value) {
                        if (value == null) {
                          return 'Kelurahan / Desa tidak boleh kosong!';
                        }
                        return null;
                      },
                      hint: const Text("Pilih Kelurahan / Desa"),
                      value: controller.selectedKelurahan,
                      items: controller.dataKelurahan.map((item) {
                        return DropdownMenuItem<Kelurahan>(
                          value: item,
                          child: Text(item.name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        controller.selectedKelurahan = value;
                        controller.authC.kelurahanController.text = value!.name;
                      },
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'RT',
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              TextFormField(
                                controller: controller.authC.rtController,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 16.0,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'RW',
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              TextFormField(
                                controller: controller.authC.rwController,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    const Text(
                      'Lorong / Jalan',
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    TextFormField(
                      controller: controller.authC.lrgController,
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    const Text(
                      'Status',
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    DropdownButtonFormField(
                      validator: (value) {
                        if (value == null) {
                          return 'Status tidak boleh kosong!';
                        }
                        return null;
                      },
                      hint: const Text("Pilih Status"),
                      value: controller.authC.statusController.text,
                      items: const [
                        DropdownMenuItem(
                          value: 'Relawan',
                          child: Text('Relawan'),
                        ),
                        DropdownMenuItem(
                          value: 'Tim',
                          child: Text('Tim'),
                        ),
                      ],
                      onChanged: (value) {
                        controller.authC.statusController.text = value!;
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

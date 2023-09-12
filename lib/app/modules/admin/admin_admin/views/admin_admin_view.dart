import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ges2024/app/constant/app_constant.dart';
import 'package:ges2024/app/data/models/user_model.dart';

import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../controllers/admin_admin_controller.dart';

class AdminAdminView extends GetView<AdminAdminController> {
  const AdminAdminView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.focusedChild?.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Daftar Admin'),
          actions: [
            IconButton(
              onPressed: () {
                final formKey = GlobalKey<FormState>();
                controller.authC.clear();
                Get.bottomSheet(
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: AppColor.shade,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.0),
                        topRight: Radius.circular(12.0),
                      ),
                    ),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Center(
                            child: Text("Tambah Admin",
                                style: AppFont.size16width600),
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          const Text('Nama Lengkap'),
                          const SizedBox(
                            height: 8.0,
                          ),
                          TextFormField(
                            controller: controller.authC.nameController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Nama lengkap tidak boleh kosong!';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              hintText: 'Masukan nama lengkap',
                            ),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          const Text('Email'),
                          const SizedBox(
                            height: 8.0,
                          ),
                          TextFormField(
                            controller: controller.authC.emailController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Email tidak boleh kosong!';
                              }
                              if (!value.isEmail) {
                                return 'Email tidak valid!';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              hintText: 'Masukan email',
                            ),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          const Text('No HP'),
                          const SizedBox(
                            height: 8.0,
                          ),
                          TextFormField(
                            controller: controller.authC.phoneController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'No HP tidak boleh kosong!';
                              }
                              if (!value.isPhoneNumber) {
                                return 'No HP tidak valid!';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              hintText: 'Masukan no hp',
                            ),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          const Text('Password'),
                          const SizedBox(
                            height: 8.0,
                          ),
                          TextFormField(
                            controller: controller.authC.passwordController,
                            obscureText: true,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Password tidak boleh kosong!';
                              }
                              if (value.length < 8) {
                                return 'Password minimal 8 karakter!';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              hintText: 'Masukan password',
                            ),
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                controller.addAdmin();
                              }
                            },
                            icon: const Icon(Icons.add),
                            label: const Text('Tambah'),
                          )
                        ],
                      ),
                    ),
                  ),
                  isScrollControlled: true,
                );
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
          child: Column(
            children: [
              TextFormField(
                onChanged: (value) => controller.changeKeyword(),
                controller: controller.searchC,
                decoration: const InputDecoration(
                  hintText: 'Cari',
                  suffixIcon: Icon(Icons.search),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Obx(() {
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
                } else if (controller.statusMessage.isNotEmpty) {
                  return Center(
                    child: Text(
                      controller.statusMessage,
                      textAlign: TextAlign.center,
                    ),
                  );
                } else {
                  if (controller.listSearch.isNotEmpty) {
                    return Expanded(
                      child: ListView.separated(
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 8.0,
                        ),
                        itemCount: controller.listSearch.length,
                        itemBuilder: (context, index) {
                          UserModel admin = controller.listSearch[index];
                          bool isMe = controller.listSearch[index].email ==
                              controller.authC.userData.value.email!;
                          return Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            elevation: 5,
                            child: ListTile(
                              dense: true,
                              onTap: isMe ? null : () {},
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              // tileColor: AppColor.primaryColor,
                              leading: CachedNetworkImage(
                                  imageUrl: admin.foto ??
                                      "https://via.placeholder.com/150",
                                  imageBuilder: (context, imageProvider) =>
                                      CircleAvatar(
                                        backgroundColor: Colors.white,
                                        // radius: 16,
                                        backgroundImage: imageProvider,
                                      ),
                                  placeholder: (context, url) =>
                                      Shimmer.fromColors(
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.grey.shade100,
                                        child: const CircleAvatar(
                                            // radius: 16,
                                            ),
                                      ),
                                  errorWidget: (context, url, error) {
                                    return const CircleAvatar(
                                      // radius: 16,
                                      child: Icon(Icons.error),
                                    );
                                  }),
                              title: Text(
                                admin.namaLengkap!,
                                style: AppFont.size14width600
                                    .copyWith(color: AppColor.primaryDark),
                              ),
                              subtitle: Text(
                                admin.email!,
                                style: AppFont.size14width400.copyWith(
                                    color:
                                        AppColor.primaryDark.withOpacity(0.7)),
                              ),
                              trailing: isMe
                                  ? Text(
                                      "(Saya)",
                                      style: AppFont.size12width400.copyWith(
                                          color: AppColor.primaryDark),
                                    )
                                  : Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          splashRadius: 24,
                                          constraints: const BoxConstraints(),
                                          onPressed: () {
                                            final formKey =
                                                GlobalKey<FormState>();
                                            controller.authC.clear();
                                            controller.authC.nameController
                                                .text = admin.namaLengkap!;
                                            controller.authC.emailController
                                                .text = admin.email!;
                                            controller.authC.phoneController
                                                .text = admin.noHp!;
                                            Get.bottomSheet(
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(16),
                                                decoration: const BoxDecoration(
                                                  color: AppColor.shade,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(12.0),
                                                    topRight:
                                                        Radius.circular(12.0),
                                                  ),
                                                ),
                                                child: Form(
                                                  key: formKey,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      const Center(
                                                        child: Text(
                                                            "Edit Admin",
                                                            style: AppFont
                                                                .size16width600),
                                                      ),
                                                      const SizedBox(
                                                        height: 16.0,
                                                      ),
                                                      const Text(
                                                          'Nama Lengkap'),
                                                      const SizedBox(
                                                        height: 8.0,
                                                      ),
                                                      TextFormField(
                                                        controller: controller
                                                            .authC
                                                            .nameController,
                                                        validator: (value) {
                                                          if (value!.isEmpty) {
                                                            return 'Nama lengkap tidak boleh kosong!';
                                                          }
                                                          return null;
                                                        },
                                                        decoration:
                                                            const InputDecoration(
                                                          hintText:
                                                              'Masukan nama lengkap',
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 8.0,
                                                      ),
                                                      const Text('Email'),
                                                      const SizedBox(
                                                        height: 8.0,
                                                      ),
                                                      TextFormField(
                                                        controller: controller
                                                            .authC
                                                            .emailController,
                                                        validator: (value) {
                                                          if (value!.isEmpty) {
                                                            return 'Email tidak boleh kosong!';
                                                          }
                                                          if (!value.isEmail) {
                                                            return 'Email tidak valid!';
                                                          }
                                                          return null;
                                                        },
                                                        decoration:
                                                            const InputDecoration(
                                                          hintText:
                                                              'Masukan email',
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 8.0,
                                                      ),
                                                      const Text('No HP'),
                                                      const SizedBox(
                                                        height: 8.0,
                                                      ),
                                                      TextFormField(
                                                        controller: controller
                                                            .authC
                                                            .phoneController,
                                                        validator: (value) {
                                                          if (value!.isEmpty) {
                                                            return 'No HP tidak boleh kosong!';
                                                          }
                                                          if (!value
                                                              .isPhoneNumber) {
                                                            return 'No HP tidak valid!';
                                                          }
                                                          return null;
                                                        },
                                                        decoration:
                                                            const InputDecoration(
                                                          hintText:
                                                              'Masukan no hp',
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 16.0,
                                                      ),
                                                      ElevatedButton.icon(
                                                        onPressed: () {
                                                          if (formKey
                                                              .currentState!
                                                              .validate()) {
                                                            controller
                                                                .editAdmin(
                                                              user: admin,
                                                              namaLengkap:
                                                                  controller
                                                                      .authC
                                                                      .nameController
                                                                      .text,
                                                              email: controller
                                                                  .authC
                                                                  .emailController
                                                                  .text,
                                                              noHp: controller
                                                                  .authC
                                                                  .phoneController
                                                                  .text,
                                                            );
                                                          }
                                                        },
                                                        icon: const Icon(
                                                            Icons.add),
                                                        label:
                                                            const Text('Edit'),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              isScrollControlled: true,
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.edit,
                                            size: 24.0,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 6.0,
                                        ),
                                        IconButton(
                                          splashRadius: 24,
                                          constraints: const BoxConstraints(),
                                          onPressed: () {
                                            Get.dialog(AlertDialog(
                                              title: const Text("Hapus"),
                                              content: const Text(
                                                  "Apakah anda yakin ingin menghapus?"),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                  child: const Text("Batal"),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    controller
                                                        .deleteAdmin(admin.id!);
                                                  },
                                                  child: const Text("Ya"),
                                                ),
                                              ],
                                            ));
                                          },
                                          icon: const Icon(
                                            Icons.delete,
                                            size: 24.0,
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return Expanded(
                      child: ListView.separated(
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 8.0,
                        ),
                        itemCount: controller.admins.length,
                        itemBuilder: (context, index) {
                          UserModel admin = controller.admins[index];
                          bool isMe = controller.admins[index].email ==
                              controller.authC.userData.value.email!;
                          return Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            elevation: 5,
                            child: ListTile(
                              dense: true,
                              onTap: isMe ? null : () {},
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              // tileColor: AppColor.primaryColor,
                              leading: CachedNetworkImage(
                                  imageUrl: admin.foto ??
                                      "https://via.placeholder.com/150",
                                  imageBuilder: (context, imageProvider) =>
                                      CircleAvatar(
                                        backgroundColor: Colors.white,
                                        // radius: 16,
                                        backgroundImage: imageProvider,
                                      ),
                                  placeholder: (context, url) =>
                                      Shimmer.fromColors(
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.grey.shade100,
                                        child: const CircleAvatar(
                                            // radius: 16,
                                            ),
                                      ),
                                  errorWidget: (context, url, error) {
                                    return const CircleAvatar(
                                      // radius: 16,
                                      child: Icon(Icons.error),
                                    );
                                  }),
                              title: Text(
                                admin.namaLengkap!,
                                style: AppFont.size14width600
                                    .copyWith(color: AppColor.primaryDark),
                              ),
                              subtitle: Text(
                                admin.email!,
                                style: AppFont.size14width400.copyWith(
                                    color:
                                        AppColor.primaryDark.withOpacity(0.7)),
                              ),
                              trailing: isMe
                                  ? Text(
                                      "(Saya)",
                                      style: AppFont.size12width400.copyWith(
                                          color: AppColor.primaryDark),
                                    )
                                  : Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          splashRadius: 24,
                                          constraints: const BoxConstraints(),
                                          onPressed: () {
                                            final formKey =
                                                GlobalKey<FormState>();
                                            controller.authC.clear();
                                            controller.authC.nameController
                                                .text = admin.namaLengkap!;
                                            controller.authC.emailController
                                                .text = admin.email!;
                                            controller.authC.phoneController
                                                .text = admin.noHp!;
                                            Get.bottomSheet(
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(16),
                                                decoration: const BoxDecoration(
                                                  color: AppColor.shade,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(12.0),
                                                    topRight:
                                                        Radius.circular(12.0),
                                                  ),
                                                ),
                                                child: Form(
                                                  key: formKey,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      const Center(
                                                        child: Text(
                                                            "Edit Admin",
                                                            style: AppFont
                                                                .size16width600),
                                                      ),
                                                      const SizedBox(
                                                        height: 16.0,
                                                      ),
                                                      const Text(
                                                          'Nama Lengkap'),
                                                      const SizedBox(
                                                        height: 8.0,
                                                      ),
                                                      TextFormField(
                                                        controller: controller
                                                            .authC
                                                            .nameController,
                                                        validator: (value) {
                                                          if (value!.isEmpty) {
                                                            return 'Nama lengkap tidak boleh kosong!';
                                                          }
                                                          return null;
                                                        },
                                                        decoration:
                                                            const InputDecoration(
                                                          hintText:
                                                              'Masukan nama lengkap',
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 8.0,
                                                      ),
                                                      const Text('Email'),
                                                      const SizedBox(
                                                        height: 8.0,
                                                      ),
                                                      TextFormField(
                                                        controller: controller
                                                            .authC
                                                            .emailController,
                                                        validator: (value) {
                                                          if (value!.isEmpty) {
                                                            return 'Email tidak boleh kosong!';
                                                          }
                                                          if (!value.isEmail) {
                                                            return 'Email tidak valid!';
                                                          }
                                                          return null;
                                                        },
                                                        decoration:
                                                            const InputDecoration(
                                                          hintText:
                                                              'Masukan email',
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 8.0,
                                                      ),
                                                      const Text('No HP'),
                                                      const SizedBox(
                                                        height: 8.0,
                                                      ),
                                                      TextFormField(
                                                        controller: controller
                                                            .authC
                                                            .phoneController,
                                                        validator: (value) {
                                                          if (value!.isEmpty) {
                                                            return 'No HP tidak boleh kosong!';
                                                          }
                                                          if (!value
                                                              .isPhoneNumber) {
                                                            return 'No HP tidak valid!';
                                                          }
                                                          return null;
                                                        },
                                                        decoration:
                                                            const InputDecoration(
                                                          hintText:
                                                              'Masukan no hp',
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 16.0,
                                                      ),
                                                      ElevatedButton.icon(
                                                        onPressed: () {
                                                          if (formKey
                                                              .currentState!
                                                              .validate()) {
                                                            controller
                                                                .editAdmin(
                                                              user: admin,
                                                              namaLengkap:
                                                                  controller
                                                                      .authC
                                                                      .nameController
                                                                      .text,
                                                              email: controller
                                                                  .authC
                                                                  .emailController
                                                                  .text,
                                                              noHp: controller
                                                                  .authC
                                                                  .phoneController
                                                                  .text,
                                                            );
                                                          }
                                                        },
                                                        icon: const Icon(
                                                            Icons.add),
                                                        label:
                                                            const Text('Edit'),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              isScrollControlled: true,
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.edit,
                                            size: 24.0,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 6.0,
                                        ),
                                        IconButton(
                                          splashRadius: 24,
                                          constraints: const BoxConstraints(),
                                          onPressed: () {
                                            Get.dialog(AlertDialog(
                                              title: const Text("Hapus"),
                                              content: const Text(
                                                  "Apakah anda yakin ingin menghapus?"),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                  child: const Text("Batal"),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    controller
                                                        .deleteAdmin(admin.id!);
                                                  },
                                                  child: const Text("Ya"),
                                                ),
                                              ],
                                            ));
                                          },
                                          icon: const Icon(
                                            Icons.delete,
                                            size: 24.0,
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}

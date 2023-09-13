import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ges2024/app/constant/app_constant.dart';
import 'package:ges2024/app/data/models/kabupaten_model.dart';
import 'package:ges2024/app/data/models/kecamatan_model.dart';
import 'package:ges2024/app/data/models/kelurahan_model.dart';
import 'package:ges2024/app/data/models/user_model.dart';
import 'package:ges2024/app/modules/admin/users_admin/views/user_detail_admin_view.dart';

import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../controllers/users_admin_controller.dart';

class UsersAdminView extends GetView<UsersAdminController> {
  const UsersAdminView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String? title = Get.arguments;
    return Listener(
      onPointerDown: (_) {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.focusedChild?.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Data $title'),
          actions: [
            IconButton(
                onPressed: () async {
                  controller.selectedKabupaten = null;
                  controller.selectedKecamatan = null;
                  controller.selectedKelurahan = null;
                  await controller.getKabupaten().then((value) =>
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
                          child: GetBuilder<UsersAdminController>(
                              builder: (controller) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Center(
                                  child: Text(
                                    'Filter Data',
                                    style: AppFont.size18width600,
                                  ),
                                ),
                                const SizedBox(
                                  height: 16.0,
                                ),
                                const Text(
                                  'Kabupaten / Kota',
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                DropdownButtonFormField<Kabupaten>(
                                  isExpanded: true,
                                  hint: const Text("Pilih Kabupaten"),
                                  value: controller.selectedKabupaten,
                                  items: controller.dataKabupaten.map((item) {
                                    return DropdownMenuItem<Kabupaten>(
                                      value: item,
                                      child: item.name == 'Semua'
                                          ? Center(
                                              child: Text(
                                                  "----- ${item.name} -----"))
                                          : Text("${item.type} ${item.name}"),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    controller.selectedKabupaten = value;
                                    // controller.authC.kabupatenController.text = value!.name;
                                    if (value!.name == 'Semua') {
                                      controller.all();
                                    } else {
                                      controller
                                          .getKecamatan(value.id)
                                          .then((_) {
                                        controller.getKelurahan(
                                            controller.dataKecamatan[0].id);
                                      });
                                    }
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
                                  hint: const Text("Pilih Kecamatan"),
                                  value: controller.selectedKecamatan,
                                  items: controller.dataKecamatan.map((item) {
                                    return DropdownMenuItem<Kecamatan>(
                                      value: item,
                                      child: item.name == 'Semua'
                                          ? Center(
                                              child: Text(
                                                  "----- ${item.name} -----"))
                                          : Text(item.name),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    controller.selectedKecamatan = value;
                                    // controller.authC.kecamatanController.text = value!.name;
                                    if (value!.name == 'Semua') {
                                      controller.all();
                                    } else {
                                      controller.selectedKelurahan = null;
                                      controller.getKelurahan(value.id);
                                    }
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
                                  hint: const Text("Pilih Kelurahan / Desa"),
                                  value: controller.selectedKelurahan,
                                  items: controller.dataKelurahan.map((item) {
                                    return DropdownMenuItem<Kelurahan>(
                                      value: item,
                                      child: item.name == 'Semua'
                                          ? Center(
                                              child: Text(
                                                  "----- ${item.name} -----"))
                                          : Text(item.name),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    controller.selectedKelurahan = value;
                                    // controller.authC.kelurahanController.text = value!.name;
                                  },
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
                                DropdownButtonFormField<String>(
                                  isExpanded: true,
                                  hint: const Text("Pilih Status Anggota"),
                                  value: controller.selectedStatus,
                                  items: const [
                                    DropdownMenuItem(
                                      value: "Semua",
                                      child: Center(
                                          child: Text("----- Semua -----")),
                                    ),
                                    DropdownMenuItem(
                                      value: "Tim",
                                      child: Text("Tim"),
                                    ),
                                    DropdownMenuItem(
                                      value: "Relawan",
                                      child: Text("Relawan"),
                                    ),
                                  ],
                                  onChanged: (value) {
                                    controller.selectedStatus = value!;
                                    // controller.authC.kelurahanController.text = value!.name;
                                  },
                                ),
                                const SizedBox(
                                  height: 16.0,
                                ),
                                Obx(() => ElevatedButton(
                                      onPressed: () async {
                                        await controller
                                            .search()
                                            .then((value) => Get.back());
                                      },
                                      // icon: const Icon(Icons.search),
                                      child: controller.isLoading.isTrue
                                          ? const CircularProgressIndicator(
                                              color: AppColor.shade,
                                            )
                                          : const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.search,
                                                  size: 20,
                                                ),
                                                SizedBox(
                                                  width: 6.0,
                                                ),
                                                Text("Terapkan"),
                                              ],
                                            ),
                                    )),
                              ],
                            );
                          }),
                        ),
                        isScrollControlled: true,
                      ));
                },
                icon: const Icon(Icons.sort))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
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
                height: 8.0,
              ),
              Expanded(
                child: Obx(
                  () => controller.isLoading.isTrue
                      ? Shimmer.fromColors(
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
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 16.0,
                            ),
                          ),
                        )
                      : controller.statusMessage.isNotEmpty
                          ? Center(
                              child: Text(
                                controller.statusMessage,
                                textAlign: TextAlign.center,
                              ),
                            )
                          : GetBuilder<UsersAdminController>(
                              builder: (controller) {
                              return SingleChildScrollView(
                                child: PaginatedDataTable(
                                  sortColumnIndex: controller.sortColumnIndex,
                                  sortAscending: controller.sortAsc,
                                  header: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextButton.icon(
                                        onPressed: () {
                                          controller.search();
                                        },
                                        icon: const Icon(Icons.refresh),
                                        label: const Text('Refresh'),
                                      ),
                                      TextButton.icon(
                                        onPressed: () {
                                          controller.importUsers();
                                        },
                                        icon: const Icon(Icons.upload),
                                        label: const Text('Import'),
                                      ),
                                      TextButton.icon(
                                        onPressed: () {
                                          if (controller
                                              .listSearch.isNotEmpty) {
                                            controller.createExcel();
                                          } else if (controller
                                              .users.isNotEmpty) {
                                            controller.createExcel();
                                          } else {
                                            EasyLoading.showError(
                                                'Tidak ada data');
                                          }
                                        },
                                        icon: const Icon(Icons.download),
                                        label: const Text('Export'),
                                      ),
                                    ],
                                  ),
                                  columnSpacing: 24,
                                  horizontalMargin: 24,
                                  rowsPerPage: 10,
                                  showCheckboxColumn: false,
                                  columns: [
                                    DataColumn(
                                      onSort: (columnIndex, ascending) {},
                                      label: const Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 6),
                                          child: Text(
                                            "No",
                                            style: AppFont.size16width600,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      onSort: (columnIndex, ascending) {
                                        controller.sortName(
                                            columnIndex, ascending);
                                      },
                                      label: const Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 6),
                                          child: Text(
                                            "Nama",
                                            style: AppFont.size16width600,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      onSort: (columnIndex, ascending) {},
                                      label: const Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 6),
                                          child: Text(
                                            "Nama Panggilan",
                                            style: AppFont.size16width600,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      onSort: (columnIndex, ascending) {},
                                      label: const Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 6),
                                          child: Text(
                                            "No HP",
                                            style: AppFont.size16width600,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      onSort: (columnIndex, ascending) {},
                                      label: const Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 6),
                                          child: Text(
                                            "Email",
                                            style: AppFont.size16width600,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      onSort: (columnIndex, ascending) {},
                                      label: const Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 6),
                                          child: Text(
                                            "NIK",
                                            style: AppFont.size16width600,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      onSort: (columnIndex, ascending) {
                                        controller.sortKabupaten(
                                            columnIndex, ascending);
                                      },
                                      label: const Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 6),
                                          child: Text(
                                            "Kabupaten",
                                            style: AppFont.size16width600,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      onSort: (columnIndex, ascending) {
                                        controller.sortKecamatan(
                                            columnIndex, ascending);
                                      },
                                      label: const Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 6),
                                          child: Text(
                                            "Kecamatan",
                                            style: AppFont.size16width600,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      onSort: (columnIndex, ascending) {
                                        controller.sortKelurahan(
                                            columnIndex, ascending);
                                      },
                                      label: const Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 6),
                                          child: Text(
                                            "Kelurahan",
                                            style: AppFont.size16width600,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      onSort: (columnIndex, ascending) {
                                        controller.sortRt(
                                            columnIndex, ascending);
                                      },
                                      label: const Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 6),
                                          child: Text(
                                            "RT",
                                            style: AppFont.size16width600,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      onSort: (columnIndex, ascending) {
                                        controller.sortRw(
                                            columnIndex, ascending);
                                      },
                                      label: const Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 6),
                                          child: Text(
                                            "RW",
                                            style: AppFont.size16width600,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      onSort: (columnIndex, ascending) {},
                                      label: const Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 6),
                                          child: Text(
                                            "Lorong / Jalan",
                                            style: AppFont.size16width600,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      onSort: (columnIndex, ascending) {},
                                      label: const Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 6),
                                          child: Text(
                                            "Referal",
                                            style: AppFont.size16width600,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      onSort: (columnIndex, ascending) {
                                        controller.sortStatus(
                                            columnIndex, ascending);
                                      },
                                      label: const Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 6),
                                          child: Text(
                                            "Status",
                                            style: AppFont.size16width600,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      onSort: (columnIndex, ascending) {},
                                      label: const Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 6),
                                          child: Text(
                                            "Jml Rekrut",
                                            style: AppFont.size16width600,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                  source: MyData(),
                                ),
                              );
                            }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyData extends DataTableSource {
  final usersController = Get.find<UsersAdminController>();

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => usersController.listSearch.isNotEmpty
      ? usersController.listSearch.length
      : usersController.users.length;
  @override
  int get selectedRowCount => 0;
  @override
  DataRow getRow(int index) {
    UserModel user = usersController.listSearch.isNotEmpty
        ? usersController.listSearch[index]
        : usersController.users[index];
    return DataRow(
      onSelectChanged: (value) {
        Get.to(() => UserDetailAdminView(user: user));
      },
      cells: [
        DataCell(
          Padding(
            padding: const EdgeInsets.only(left: 6, right: 18),
            child: Center(
                child: Text("${index + 1}", textAlign: TextAlign.center)),
          ),
        ),
        DataCell(
          Row(
            children: [
              CachedNetworkImage(
                  imageUrl: user.foto ?? "https://via.placeholder.com/150",
                  imageBuilder: (context, imageProvider) => CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 16,
                        backgroundImage: imageProvider,
                      ),
                  placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: const CircleAvatar(
                          radius: 16,
                        ),
                      ),
                  errorWidget: (context, url, error) {
                    return const CircleAvatar(
                      radius: 16,
                      child: Icon(Icons.error),
                    );
                  }),
              const SizedBox(
                width: 6.0,
              ),
              Text(
                user.namaLengkap!,
              ),
            ],
          ),
        ),
        DataCell(
          Padding(
            padding: const EdgeInsets.only(left: 6, right: 18),
            child: Center(
                child: Text(user.namaPanggilan ?? "-",
                    textAlign: TextAlign.center)),
          ),
        ),
        DataCell(
          Padding(
            padding: const EdgeInsets.only(left: 6, right: 18),
            child: Center(child: Text(user.noHp!, textAlign: TextAlign.center)),
          ),
        ),
        DataCell(
          Padding(
            padding: const EdgeInsets.only(left: 6, right: 18),
            child:
                Center(child: Text(user.email!, textAlign: TextAlign.center)),
          ),
        ),
        DataCell(
          Padding(
            padding: const EdgeInsets.only(left: 6, right: 18),
            child: Center(child: Text(user.nik!, textAlign: TextAlign.center)),
          ),
        ),
        DataCell(
          Padding(
            padding: const EdgeInsets.only(left: 6, right: 18),
            child: Center(
                child: Text(user.kabupaten!, textAlign: TextAlign.center)),
          ),
        ),
        DataCell(
          Padding(
            padding: const EdgeInsets.only(left: 6, right: 18),
            child: Center(
                child: Text(user.kecamatan!, textAlign: TextAlign.center)),
          ),
        ),
        DataCell(
          Padding(
            padding: const EdgeInsets.only(left: 6, right: 18),
            child: Center(
                child: Text(user.kelurahan!, textAlign: TextAlign.center)),
          ),
        ),
        DataCell(
          Padding(
            padding: const EdgeInsets.only(left: 6, right: 18),
            child: Center(child: Text(user.rt!, textAlign: TextAlign.center)),
          ),
        ),
        DataCell(
          Padding(
            padding: const EdgeInsets.only(left: 6, right: 18),
            child: Center(child: Text(user.rw!, textAlign: TextAlign.center)),
          ),
        ),
        DataCell(
          Padding(
            padding: const EdgeInsets.only(left: 6, right: 18),
            child: Center(child: Text(user.lrg!, textAlign: TextAlign.center)),
          ),
        ),
        DataCell(
          Padding(
            padding: const EdgeInsets.only(left: 6, right: 18),
            child: Center(
                child: Text(user.kodeReferal!, textAlign: TextAlign.center)),
          ),
        ),
        DataCell(
          Padding(
            padding: const EdgeInsets.only(left: 6, right: 18),
            child:
                Center(child: Text(user.status!, textAlign: TextAlign.center)),
          ),
        ),
        DataCell(
          Padding(
            padding: const EdgeInsets.only(left: 6, right: 18),
            child: Center(
                child: Text(user.jumlahRekrut.toString(),
                    textAlign: TextAlign.center)),
          ),
        ),
      ],
    );
  }
}

import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:ges2024/app/constant/app_constant.dart';
import 'package:ges2024/app/data/models/user_model.dart';
import 'package:ges2024/app/modules/admin/imported_admin/controllers/imported_admin_controller.dart';
import 'package:get/get.dart';

class ImportedAdminView extends GetView<ImportedAdminController> {
  const ImportedAdminView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<UserModel> users = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ExpansionTileCard(
              elevation: 5,
              leading: const Icon(
                Icons.warning_rounded,
                color: AppColor.alertColor,
              ),
              title: const Text("Catatan"),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Table(
                    defaultColumnWidth: const IntrinsicColumnWidth(),
                    columnWidths: const {
                      0: FixedColumnWidth(16),
                    },
                    children: const [
                      TableRow(
                        children: [
                          Text("1."),
                          Text(
                              "Pastikan semua data yang dimasukan sudah benar"),
                        ],
                      ),
                      TableRow(
                        children: [
                          Text("2."),
                          Text(
                              "Pastikan tidak ada data double untuk Email, No HP, dan juga NIK"),
                        ],
                      ),
                      TableRow(
                        children: [
                          Text("3."),
                          Text("Password default adalah password123"),
                        ],
                      ),
                      TableRow(
                        children: [
                          Text("4."),
                          Text(
                              "Pada saat pertama login menggunakan akun yang diimport, pengguna harus mengganti passwordnya, dan juga mengupload Foto Profil beserta Foto KTP mereka"),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8.0,
            ),
            GetBuilder<ImportedAdminController>(builder: (controller) {
              return Expanded(
                child: SingleChildScrollView(
                  child: PaginatedDataTable(
                    columnSpacing: 24,
                    horizontalMargin: 24,
                    rowsPerPage: 10,
                    showCheckboxColumn: false,
                    columns: const [
                      DataColumn(
                        label: Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6),
                            child: Text(
                              "No",
                              style: AppFont.size16width600,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6),
                            child: Text(
                              "Nama",
                              style: AppFont.size16width600,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6),
                            child: Text(
                              "Nama Panggilan",
                              style: AppFont.size16width600,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6),
                            child: Text(
                              "No HP",
                              style: AppFont.size16width600,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6),
                            child: Text(
                              "Email",
                              style: AppFont.size16width600,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6),
                            child: Text(
                              "NIK",
                              style: AppFont.size16width600,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6),
                            child: Text(
                              "Kabupaten",
                              style: AppFont.size16width600,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6),
                            child: Text(
                              "Kecamatan",
                              style: AppFont.size16width600,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6),
                            child: Text(
                              "Kelurahan",
                              style: AppFont.size16width600,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6),
                            child: Text(
                              "RT",
                              style: AppFont.size16width600,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6),
                            child: Text(
                              "RW",
                              style: AppFont.size16width600,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6),
                            child: Text(
                              "Lorong / Jalan",
                              style: AppFont.size16width600,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6),
                            child: Text(
                              "Referal Dari",
                              style: AppFont.size16width600,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6),
                            child: Text(
                              "Keterangan",
                              style: AppFont.size16width600,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                    source: MyData(userData: users),
                  ),
                ),
              );
            }),
            const SizedBox(
              height: 16.0,
            ),
            ElevatedButton.icon(
                onPressed: () {
                  controller.importData(users);
                  // Map<String, dynamic> data = {
                  //   "data": userModelListToJson(users),
                  // };
                  // log(data.toString());
                },
                icon: const Icon(Icons.upload),
                label: const Text('Proses'))
          ],
        ),
      ),
    );
  }
}

class MyData extends DataTableSource {
  MyData({
    required this.userData,
  });
  List<UserModel> userData;

  final importedC = Get.find<ImportedAdminController>();

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => userData.length;
  @override
  int get selectedRowCount => 0;
  @override
  DataRow getRow(int index) {
    return DataRow(
      onSelectChanged: (value) {
        print(userData[index].namaLengkap!);
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
          Text(userData[index].namaLengkap!),
        ),
        DataCell(
          Text(
            userData[index].namaPanggilan ?? "-",
          ),
        ),
        DataCell(
          Padding(
            padding: const EdgeInsets.only(left: 6, right: 18),
            child: Center(
                child: Text(
              userData[index].noHp!,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: importedC.errorData.isNotEmpty
                    ? importedC.errorData
                            .where(
                                (error) => error.noHp == userData[index].noHp)
                            .isNotEmpty
                        ? AppColor.alertColor
                        : Colors.black
                    : Colors.black,
              ),
            )),
          ),
        ),
        DataCell(
          Padding(
            padding: const EdgeInsets.only(left: 6, right: 18),
            child: Center(
                child: Text(
              userData[index].email!,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: importedC.errorData.isNotEmpty
                    ? importedC.errorData
                            .where(
                                (error) => error.email == userData[index].email)
                            .isNotEmpty
                        ? AppColor.alertColor
                        : Colors.black
                    : Colors.black,
              ),
            )),
          ),
        ),
        DataCell(
          Padding(
            padding: const EdgeInsets.only(left: 6, right: 18),
            child: Center(
                child: Text(
              userData[index].nik!,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: importedC.errorData.isNotEmpty
                    ? importedC.errorData
                            .where((error) => error.nik == userData[index].nik)
                            .isNotEmpty
                        ? AppColor.alertColor
                        : Colors.black
                    : Colors.black,
              ),
            )),
          ),
        ),
        DataCell(
          Padding(
            padding: const EdgeInsets.only(left: 6, right: 18),
            child: Center(
                child: Text(userData[index].kabupaten!,
                    textAlign: TextAlign.center)),
          ),
        ),
        DataCell(
          Padding(
            padding: const EdgeInsets.only(left: 6, right: 18),
            child: Center(
                child: Text(userData[index].kecamatan!,
                    textAlign: TextAlign.center)),
          ),
        ),
        DataCell(
          Padding(
            padding: const EdgeInsets.only(left: 6, right: 18),
            child: Center(
                child: Text(userData[index].kelurahan!,
                    textAlign: TextAlign.center)),
          ),
        ),
        DataCell(
          Padding(
            padding: const EdgeInsets.only(left: 6, right: 18),
            child: Center(
                child: Text(userData[index].rt!, textAlign: TextAlign.center)),
          ),
        ),
        DataCell(
          Padding(
            padding: const EdgeInsets.only(left: 6, right: 18),
            child: Center(
                child: Text(userData[index].rw!, textAlign: TextAlign.center)),
          ),
        ),
        DataCell(
          Padding(
            padding: const EdgeInsets.only(left: 6, right: 18),
            child: Center(
                child: Text(userData[index].lrg!, textAlign: TextAlign.center)),
          ),
        ),
        DataCell(
          Padding(
            padding: const EdgeInsets.only(left: 6, right: 18),
            child: Center(
                child: Text(userData[index].referalDari ?? "-",
                    textAlign: TextAlign.center)),
          ),
        ),
        importedC.errorData.isNotEmpty
            ? importedC.errorData
                    .where((error) =>
                        error.noHp == userData[index].noHp ||
                        error.email == userData[index].email ||
                        error.nik == userData[index].nik)
                    .isNotEmpty
                ? DataCell(
                    Padding(
                      padding: const EdgeInsets.only(left: 6, right: 18),
                      child: Center(
                          child: Text(
                        importedC.errorData
                            .where((error) =>
                                error.noHp == userData[index].noHp ||
                                error.email == userData[index].email ||
                                error.nik == userData[index].nik)
                            .first
                            .keterangan!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: AppColor.alertColor),
                      )),
                    ),
                  )
                : const DataCell(
                    Padding(
                      padding: EdgeInsets.only(left: 6, right: 18),
                      child:
                          Center(child: Text("-", textAlign: TextAlign.center)),
                    ),
                  )
            : const DataCell(
                Padding(
                  padding: EdgeInsets.only(left: 6, right: 18),
                  child: Center(child: Text("-", textAlign: TextAlign.center)),
                ),
              )
      ],
    );
  }
}

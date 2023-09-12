import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ges2024/app/constant/app_constant.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../controllers/recruit_user_controller.dart';

class RecruitUserView extends GetView<RecruitUserController> {
  const RecruitUserView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Tim'),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: 'Refresh',
            onPressed: () {
              controller.dashboardC.getDownlines();
            },
            icon: const Icon(
              Icons.refresh,
              size: 24.0,
            ),
          ),
          IconButton(
            tooltip: 'Export Excel',
            onPressed: () {
              if (controller.dataC.team.isEmpty) {
                EasyLoading.showToast('Data Tim Kosong!',
                    toastPosition: EasyLoadingToastPosition.bottom);
              } else {
                controller.createExcel();
              }
            },
            icon: const Icon(
              Icons.file_download,
              size: 24.0,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Obx(() => controller.dashboardC.isLoading.isTrue
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
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 16.0,
                        ),
                      ),
                    )
                  : controller.dataC.team.isEmpty
                      ? const Center(
                          child: Text("Anda belum memiliki tim"),
                        )
                      : Card(
                          elevation: 5,
                          color: Colors.white,
                          surfaceTintColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12.0),
                            ),
                          ),
                          child: Stack(
                            children: [
                              Container(
                                width: Get.width,
                                height: 56,
                                decoration: const BoxDecoration(
                                    color: AppColor.primaryColor,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      topRight: Radius.circular(12),
                                    )),
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: DataTable(
                                    dataRowColor:
                                        MaterialStateColor.resolveWith(
                                            (states) => Colors.white),
                                    headingRowHeight: 56,
                                    headingRowColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.transparent),
                                    dataTextStyle: AppFont.size16width400,
                                    headingTextStyle: AppFont.size16width600
                                        .copyWith(color: Colors.white),
                                    sortAscending: true,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(12.0),
                                      ),
                                    ),
                                    // border: TableBorder(
                                    //     borderRadius:
                                    //         BorderRadius.circular(16)),
                                    columnSpacing: 24,
                                    horizontalMargin: 24,
                                    columns: List.generate(8, (index) {
                                      List<String> title = [
                                        'No',
                                        'Nama',
                                        'No HP',
                                        'Email',
                                        'NIK',
                                        'Kelurahan',
                                        'Kecamatan',
                                        'Jml Rekrut',
                                      ];
                                      return DataColumn(
                                          onSort: (columnIndex, ascending) {},
                                          label: Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 6),
                                              child: Text(title[index],
                                                  textAlign: TextAlign.center),
                                            ),
                                          ));
                                    }),
                                    rows: controller.dataC.team
                                        .asMap()
                                        .entries
                                        .map(
                                      (e) {
                                        return DataRow(
                                          cells: [
                                            DataCell(
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 6, right: 18),
                                                child: Center(
                                                    child: Text("${e.key + 1}",
                                                        textAlign:
                                                            TextAlign.center)),
                                              ),
                                            ),
                                            DataCell(
                                              Text(
                                                e.value.user!.namaLengkap!,
                                              ),
                                            ),
                                            DataCell(
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 6, right: 18),
                                                child: Center(
                                                    child: Text(
                                                        e.value.user!.noHp!,
                                                        textAlign:
                                                            TextAlign.center)),
                                              ),
                                            ),
                                            DataCell(
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 6, right: 18),
                                                child: Center(
                                                    child: Text(
                                                        e.value.user!.email!,
                                                        textAlign:
                                                            TextAlign.center)),
                                              ),
                                            ),
                                            DataCell(
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 6, right: 18),
                                                child: Center(
                                                    child: Text(
                                                        e.value.user!.nik!,
                                                        textAlign:
                                                            TextAlign.center)),
                                              ),
                                            ),
                                            DataCell(
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 6, right: 18),
                                                child: Center(
                                                    child: Text(
                                                        e.value.user!
                                                            .kelurahan!,
                                                        textAlign:
                                                            TextAlign.center)),
                                              ),
                                            ),
                                            DataCell(
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 6, right: 18),
                                                child: Center(
                                                    child: Text(
                                                        e.value.user!
                                                            .kecamatan!,
                                                        textAlign:
                                                            TextAlign.center)),
                                              ),
                                            ),
                                            DataCell(
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 6, right: 18),
                                                child: Center(
                                                    child: Text(
                                                        e.value.totalDownlines
                                                            .toString(),
                                                        textAlign:
                                                            TextAlign.center)),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ).toList(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
            ),
          ],
        ),
      ),
    );
  }
}

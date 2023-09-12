// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:ges2024/app/constant/app_constant.dart';

// import 'package:get/get.dart';

// import '../controllers/wilayah_admin_controller.dart';

// class WilayahAdminView extends GetView<WilayahAdminController> {
//   const WilayahAdminView({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () {
//         SystemChrome.setPreferredOrientations([
//           DeviceOrientation.portraitUp,
//           DeviceOrientation.portraitDown,
//         ]);
//         return Future.value(true);
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Data Per Wilayah'),
//           centerTitle: true,
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Table(
//             border: TableBorder.all(),
//             children: [
//               const TableRow(children: [
//                 Center(child: Text('Kabupaten / Kota')),
//                 Center(child: Text('Kecamatan')),
//                 Center(child: Text('Kelurahan')),
//               ]),
//               ...controller.dataKabupaten.map((kabupaten) {
//                 return TableRow(
//                   children: [
//                     Text(kabupaten.name),
//                     Table(
//                       border: TableBorder.all(),
//                       children: controller.dataKecamatan
//                           .where((kecamatan) =>
//                               kecamatan.kabupatenId == kabupaten.id)
//                           .map((kecamatan) {
//                         return TableRow(children: [
//                           Text(kecamatan.name),
//                         ]);
//                       }).toList(),
//                     ),
//                     Table(
//                       border: TableBorder.all(),
//                       children: controller.dataKecamatan
//                           .where((kecamatan) =>
//                               kecamatan.kabupatenId == kabupaten.id)
//                           .map((kecamatan) {
//                         return TableRow(
//                           children: controller.dataKelurahan
//                               .where((kelurahan) =>
//                                   kelurahan.kecamatanId == kecamatan.id)
//                               .map((kelurahan) => Text(kelurahan.name))
//                               .toList(),
//                         );
//                       }).toList(),
//                     ),
//                   ],
//                 );
//               }).toList(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:ges2024/app/constant/app_constant.dart';
import 'package:ges2024/app/modules/admin/wilayah_admin/controllers/wilayah_admin_controller.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class WilayahAdminView extends GetView<WilayahAdminController> {
  const WilayahAdminView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Per Wilayah'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
          } else {
            if (controller.kecamatan.isNotEmpty) {
              return RefreshIndicator(
                onRefresh: () => controller.getData(),
                child: HtmlWidget(
                  generateHtmlTable(controller.kecamatan),
                  renderMode: RenderMode.listView,
                ),
              );
            } else {
              return const Center(
                child: Text("Belum ada anggota"),
              );
            }
          }
        }),
      ),
    );
  }

  String generateHtmlTable(List<Count> kecamatan) {
    StringBuffer html = StringBuffer();

    html.write("""
<div style="overflow-x:auto;">
    <table border="1" style="width: 100%; border-collapse: collapse;">
      <thead>
        <tr>
          <th style="width:35%; text-align: center; background-color: #5265af; color: white; height:20px; padding: 8px;">Kecamatan</th>
          <th style="width:15%; text-align: center; background-color: #5265af; color: white; height:20px; padding: 8px;">Jml</th>
          <th style="width:35%; text-align: center; background-color: #5265af; color: white; height:20px; padding: 8px;">Kelurahan</th>
          <th style="width:15%; text-align: center; background-color: #5265af; color: white; height:20px; padding: 8px;">Jml</th>
        </tr>
      </thead>
      <tbody>
  """);

    for (var kcm in kecamatan) {
      int kelurahanCount = kcm.kelurahan.length;
      html.write("""
      <tr>
        <td rowspan="$kelurahanCount" style="width:35%; text-align: center;padding: 8px;">${kcm.nama}</td>
        <td rowspan="$kelurahanCount" style="width:15%; text-align: center;padding: 8px;">${kcm.jumlah}</td>
        <td style="width:35%; text-align: center;padding: 8px;">${kcm.kelurahan.isNotEmpty ? kcm.kelurahan.first.nama : '-'}</td>
        <td style="width:15%; text-align: center;padding: 8px;">${kcm.kelurahan.isNotEmpty ? kcm.kelurahan.first.jumlah : '-'}</td>
      </tr>
    """);
      for (int i = 1; i < kelurahanCount; i++) {
        html.write("""
        <tr>
          <td style="width:35%; text-align: center;padding: 8px;">${kcm.kelurahan[i].nama}</td>
          <td style="width:15%; text-align: center;padding: 8px;">${kcm.kelurahan[i].jumlah}</td>
        </tr>
      """);
      }
    }

    html.write("""
      </tbody>
    </table>
    </div>
  """);

    return html.toString();
  }
}

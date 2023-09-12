import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ges2024/app/constant/app_constant.dart';
import 'package:ges2024/app/modules/user/article_user/views/article_detail_view.dart';
import 'package:ges2024/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../controllers/home_user_controller.dart';

class HomeUserView extends GetView<HomeUserController> {
  const HomeUserView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print("JUMLAH ARTIKEL : ${controller.dataC.articles.length}");
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
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
                        imageBuilder: (context, imageProvider) => CircleAvatar(
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
                              "Hallo, ${controller.authC.userData.value.namaPanggilan!.isNotEmpty ? controller.authC.userData.value.namaPanggilan : controller.authC.userData.value.namaLengkap}",
                              style: AppFont.size16width500,
                              maxLines: 1,
                            ),
                            Row(
                              children: [
                                Text(
                                  controller.authC.userData.value.kodeReferal!,
                                  style: AppFont.size14width500,
                                ),
                                const SizedBox(
                                  width: 8.0,
                                ),
                                InkWell(
                                  onTap: () {
                                    Clipboard.setData(ClipboardData(
                                        text: controller.authC.userData.value
                                            .kodeReferal!));
                                    EasyLoading.showToast(
                                      'Referal berhasil di salin',
                                      toastPosition:
                                          EasyLoadingToastPosition.bottom,
                                    );
                                  },
                                  child: const Icon(
                                    Icons.copy,
                                    size: 16.0,
                                  ),
                                )
                              ],
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
                      style:
                          AppFont.size14width500.copyWith(color: Colors.white)),
                ),
              ],
            ),
            const SizedBox(
              height: 16.0,
            ),
            Obx(() {
              if (controller.dataC.articles.isNotEmpty) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CarouselSlider(
                      carouselController: controller.bannerController,
                      options: CarouselOptions(
                        enableInfiniteScroll: false,
                        height: Get.height * 0.2,
                        enlargeCenterPage: true,
                        scrollDirection: Axis.horizontal,
                        autoPlay: true,
                        disableCenter: false,
                        onPageChanged: (index, reason) {
                          controller.changeBanner(index);
                        },
                        padEnds: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 500),
                        autoPlayCurve: Curves.fastOutSlowIn,
                      ),
                      items: controller.dataC.articles
                          .map(
                            (artikel) => GestureDetector(
                              onTap: () {
                                Get.to(() => const ArticleDetailView(),
                                    arguments: artikel);
                              },
                              child: Container(
                                margin: const EdgeInsets.all(5.0),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10.0)),
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl: artikel.gambar,
                                        imageBuilder:
                                            (context, imageProvider) => Image(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                        fit: BoxFit.cover,
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.image),
                                        placeholder: (context, url) {
                                          return Shimmer.fromColors(
                                            baseColor: Colors.grey.shade300,
                                            highlightColor:
                                                Colors.grey.shade100,
                                            child: Container(
                                              color: Colors.white,
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: controller.dataC.articles
                                .asMap()
                                .entries
                                .map((entry) {
                              if (entry.key <= 8) {
                                return GestureDetector(
                                  onTap: () => controller.bannerController
                                      .animateToPage(entry.key),
                                  child: Obx(() => Container(
                                        width: 8.0,
                                        height: 8.0,
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 8.0, horizontal: 4.0),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color:
                                                (Theme.of(context).brightness ==
                                                            Brightness.dark
                                                        ? Colors.white
                                                        : Colors.black)
                                                    .withOpacity(controller
                                                                .currentBanner
                                                                .value ==
                                                            entry.key
                                                        ? 0.9
                                                        : 0.4)),
                                      )),
                                );
                              } else {
                                return Container();
                              }
                            }).toList(),
                          ),
                        ),
                        TextButton(
                          child: const Text('Lihat Semua Artikel'),
                          onPressed: () {
                            Get.toNamed(Routes.ARTICLE_USER);
                          },
                        ),
                      ],
                    ),
                    const Divider(),
                  ],
                );
              } else {
                return const SizedBox();
              }
            }),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text(
                      'Tim Anda',
                      style: AppFont.size18width600,
                    ),
                    IconButton(
                      tooltip: 'Refresh',
                      onPressed: () async {
                        await controller.dashboardC.getDownlines();
                      },
                      icon: const Icon(
                        Icons.refresh,
                        size: 24.0,
                      ),
                    ),
                  ],
                ),
                TextButton(
                    onPressed: () {
                      Get.toNamed(Routes.RECRUIT_USER);
                    },
                    child: const Text('Lihat Semua'))
              ],
            ),
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
                                        .take(10)
                                        .toList()
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
            Obx(() {
              if (controller.authC.userData.value.status == 'Tim') {
                return Column(
                  children: [
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
                        tileColor: AppColor.primaryColor,
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
                );
              } else {
                return const SizedBox();
              }
            }),
          ],
        ),
      )),
    );
  }
}

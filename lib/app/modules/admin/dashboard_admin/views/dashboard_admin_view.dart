import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:ges2024/app/constant/app_constant.dart';
import 'package:ges2024/app/modules/admin/article_admin/views/article_admin_view.dart';
import 'package:ges2024/app/modules/admin/home_admin/views/home_admin_view.dart';
import 'package:ges2024/app/modules/admin/profile_admin/views/profile_admin_view.dart';

import 'package:get/get.dart';

import '../controllers/dashboard_admin_controller.dart';

class DashboardAdminView extends GetView<DashboardAdminController> {
  const DashboardAdminView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardAdminController>(builder: (controller) {
      return Scaffold(
        extendBody: true,
        body: Center(
          child: IndexedStack(
            index: controller.tabIndex,
            children: const [
              HomeAdminView(),
              ArticleAdminView(),
              ProfileAdminView(),
            ],
          ),
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomNavigationBar(
              borderRadius: const Radius.circular(16),
              selectedColor: AppColor.primaryColor,
              unSelectedColor: AppColor.bodyTextColor,
              strokeColor: AppColor.primaryColor,
              currentIndex: controller.tabIndex,
              bubbleCurve: Curves.decelerate,
              scaleFactor: 0.5,
              scaleCurve: Curves.fastOutSlowIn,
              isFloating: true,
              onTap: (index) {
                controller.changeTabIndex(index);
              },
              items: [
                CustomNavigationBarItem(
                  icon: const Icon(Icons.home),
                  title: const Text(
                    'Beranda',
                    style: AppFont.size14width500,
                  ),
                ),
                CustomNavigationBarItem(
                  icon: const Icon(Icons.my_library_books),
                  title: const Text(
                    'Artikel',
                    style: AppFont.size14width500,
                  ),
                ),
                CustomNavigationBarItem(
                  icon: const Icon(Icons.person),
                  title: const Text(
                    'Profil',
                    style: AppFont.size14width500,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8.0,
            ),
          ],
        ),
      );
    });
  }
}

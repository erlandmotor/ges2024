import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ges2024/app/constant/app_images.dart';
import 'package:ges2024/app/controllers/auth_controller.dart';
import 'package:ges2024/app/controllers/data_controller.dart';
import 'package:ges2024/app/data/services/notification_services.dart';
import 'package:ges2024/app/utils/theme.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting('id_ID');
  Get.put(AuthController(), permanent: true);
  Get.put(DataController(), permanent: true);
  await GetStorage.init();
  await NotificationService().init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      // systemNavigationBarColor: Colors.white,
      // systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  Future<void> loadImage() async {
    ByteData byteData = await rootBundle.load(AppImage.logo);
    AppImage.byteData = byteData.buffer.asUint8List();
  }

  await loadImage().then(
    (_) => runApp(
      GetMaterialApp(
        title: "GES2024",
        debugShowCheckedModeBanner: false,
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        theme: appThemeData,
        builder: EasyLoading.init(),
      ),
    ),
  );
}

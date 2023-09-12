import 'package:get/get.dart';

import '../controllers/article_admin_controller.dart';

class ArticleAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ArticleAdminController>(
      () => ArticleAdminController(),
    );
  }
}

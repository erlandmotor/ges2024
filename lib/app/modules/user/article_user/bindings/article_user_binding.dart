import 'package:get/get.dart';

import '../controllers/article_user_controller.dart';

class ArticleUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      ArticleUserController(),
    );
  }
}

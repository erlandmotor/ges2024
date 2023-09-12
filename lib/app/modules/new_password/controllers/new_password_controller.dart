import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewPasswordController extends GetxController {
  RxBool isHidden = true.obs;
  RxBool isReHidden = true.obs;
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
}

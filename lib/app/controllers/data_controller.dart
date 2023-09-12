import 'package:ges2024/app/data/models/artikel_model.dart';
import 'package:ges2024/app/data/models/downline_model.dart';
import 'package:get/get.dart';

class DataController extends GetxController {
  var team = RxList<Downline>([]);
  var articles = RxList<Artikel>([]);
}

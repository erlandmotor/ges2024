import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ges2024/app/constant/app_strings.dart';
import 'package:ges2024/app/controllers/auth_controller.dart';
import 'package:ges2024/app/data/services/api_services.dart';
import 'package:get/get.dart';

class WilayahAdminController extends GetxController {
  final authC = Get.find<AuthController>();
  var kecamatan = RxList<Count>([]);

  RxBool isLoading = false.obs;
  @override
  void onInit() {
    getData();
    super.onInit();
  }

  Future<void> getData() async {
    isLoading.value = true;
    try {
      var response = await ApiService.get(
          endpoint: AppString.countUsersPerWilayah,
          token: authC.userToken.value);
      var data = json.decode(response.body);
      print(data.runtimeType);
      // print(response.statusCode);
      if (response.statusCode == 200) {
        kecamatan.clear();
        print(data.isNotEmpty);
        if (data.isNotEmpty) {
          print('dijalankan');
          List<dynamic> responseKecamatan = data['kecamatan'];
          print(responseKecamatan);
          for (var element in responseKecamatan) {
            kecamatan.add(Count.fromJson(element));
          }
          print(json.encode(responseKecamatan));
        }
      } else {
        kecamatan.clear();
        print(data);
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
      EasyLoading.showError(e.toString());
    }
  }
}

class Count {
  final String nama;
  final int jumlah;
  final List<Kelurahan> kelurahan;

  Count({
    required this.nama,
    required this.jumlah,
    required this.kelurahan,
  });

  factory Count.fromJson(Map<String, dynamic> json) {
    print(json['Jumlah'].runtimeType);
    int jumlah = 0;
    if (json['Jumlah'].runtimeType == String) {
      jumlah = int.parse(json['Jumlah']);
    } else {
      jumlah = json['Jumlah'];
    }
    return Count(
      nama: json["Nama"],
      jumlah: jumlah,
      kelurahan: List<Kelurahan>.from(
          json["Kelurahan"].map((x) => Kelurahan.fromJson(x))),
    );
  }
}

class Kelurahan {
  final String nama;
  final int jumlah;

  Kelurahan({
    required this.nama,
    required this.jumlah,
  });

  factory Kelurahan.fromJson(Map<String, dynamic> json) {
    int jumlah = 0;
    if (json['Jumlah'].runtimeType == String) {
      jumlah = int.parse(json['Jumlah']);
    } else {
      jumlah = json['Jumlah'];
    }
    return Kelurahan(
      nama: json["Nama"],
      jumlah: jumlah,
    );
  }
}

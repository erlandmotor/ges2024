import 'package:flutter/services.dart';

class AppImage {
  static String getImage(String name) {
    String imageName = name.toLowerCase();
    return 'assets/images/$imageName.png';
  }

  static const String logo = 'assets/images/logo.png';
  static const String ktp = 'assets/images/id-card.png';
  static const String anggota = 'assets/images/anggota.png';
  static const String admin = 'assets/images/admin.png';
  static const String tim = 'assets/images/tim.png';
  static const String kpu = 'assets/images/kpu.png';
  static const String wilayah = 'assets/images/wilayah.png';
  static const String maintenance = 'assets/images/maintenance.png';
  static const String relawan = 'assets/images/relawan.png';
  static late Uint8List byteData;
}

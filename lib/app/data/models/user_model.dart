import 'dart:convert';

import 'package:ges2024/app/constant/app_strings.dart';
import 'package:ges2024/app/data/models/downline_model.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

String userModelListToJson(List<UserModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
// String userModelListToJson(List<UserModel> data) {
//   return json.encode({
//     'data': List<dynamic>.from(data.map((x) => x.toJson())),
//   });
// }

class UserModel {
  int? id;
  String? namaLengkap;
  String? namaPanggilan;
  String? foto;
  String? email;
  String? noHp;
  String? nik;
  String? fotoKtp;
  String? provinsi;
  String? kabupaten;
  String? kecamatan;
  String? kelurahan;
  String? rt;
  String? rw;
  String? lrg;
  String? kodeReferal;
  String? referalDari;
  String? status;
  int? jumlahRekrut;
  List<Downline>? downline;

  UserModel({
    this.id,
    this.namaLengkap,
    this.namaPanggilan,
    this.foto,
    this.email,
    this.noHp,
    this.nik,
    this.fotoKtp,
    this.provinsi,
    this.kabupaten,
    this.kecamatan,
    this.kelurahan,
    this.rt,
    this.rw,
    this.lrg,
    this.kodeReferal,
    this.referalDari,
    this.status,
    this.jumlahRekrut,
    this.downline,
  });

  @override
  String toString() {
    return 'UserModel: {\n'
        'Nama: $namaLengkap,\n'
        'Nama Panggilan: $namaPanggilan,\n'
        'Kabupaten: $kabupaten,\n'
        'Kelurahan: $kelurahan,\n'
        'Kecamatan: $kecamatan,\n'
        'NIK: $nik\n'
        '}';
  }

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      id: json["id"],
      namaLengkap: json["nama_lengkap"],
      namaPanggilan: json["nama_panggilan"],
      foto: json["foto"].toString().contains('public')
          ? json["foto"]
              .toString()
              .replaceAll('public', "${AppString.baseUrl}/storage")
          : json["foto"],
      email: json["email"],
      noHp: json["no_hp"],
      nik: json["nik"],
      fotoKtp: json["foto_ktp"].toString().contains('public')
          ? json["foto_ktp"]
              .toString()
              .replaceAll('public', "${AppString.baseUrl}/storage")
          : json["foto_ktp"],
      provinsi: json["provinsi"],
      kabupaten: json["kabupaten"],
      kecamatan: json["kecamatan"],
      kelurahan: json["kelurahan"],
      rt: json["rt"],
      rw: json["rw"],
      lrg: json["lrg"],
      kodeReferal: json["kode_referal"] ?? 'SEGERA HUBUNGI ADMIN',
      referalDari: json["referal_dari"],
      status: json["status"],
      downline: json["downline"],
      jumlahRekrut: json["jumlahRekrut"]);

  Map<String, dynamic> toJson() => {
        // "id": id,
        "nama_lengkap": namaLengkap,
        "nama_panggilan": namaPanggilan,
        "foto": 'public/foto_profil/no-image.png',
        "email": email,
        "no_hp": noHp,
        "nik": nik,
        "foto_ktp": 'public/foto_ktp/no-image.png',
        "provinsi": "Jambi",
        "kabupaten": kabupaten,
        "kecamatan": kecamatan,
        "kelurahan": kelurahan,
        "rt": rt,
        "rw": rw,
        "lrg": lrg,
        // "kode_referal": kodeReferal,
        "referal_dari": referalDari,
        "status": status,
      };
}

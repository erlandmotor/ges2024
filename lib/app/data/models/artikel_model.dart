// To parse this JSON data, do
//
//     final artikel = artikelFromJson(jsonString);

import 'dart:convert';

import 'package:ges2024/app/constant/app_strings.dart';

List<Artikel> artikelFromJson(String str) =>
    List<Artikel>.from(json.decode(str).map((x) => Artikel.fromJson(x)));

String artikelToJson(List<Artikel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Artikel {
  Artikel({
    required this.id,
    required this.gambar,
    required this.konten,
    required this.judul,
  });

  int id;
  String gambar;
  String konten;
  String judul;

  factory Artikel.fromJson(Map<String, dynamic> json) => Artikel(
        id: json["id"],
        gambar: json["gambar"].toString().contains('public')
            ? json["gambar"]
                .toString()
                .replaceAll('public', "${AppString.baseUrl}/storage")
            : json["gambar"],
        konten: json["konten"],
        judul: json["judul"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "gambar": gambar,
        "konten": konten,
        "judul": judul,
      };
}

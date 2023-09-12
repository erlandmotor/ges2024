// To parse this JSON data, do
//
//     final kelurahan = kelurahanFromJson(jsonString);

import 'dart:convert';

List<Kelurahan> kelurahanFromJson(String str) =>
    List<Kelurahan>.from(json.decode(str).map((x) => Kelurahan.fromJson(x)));

String kelurahanToJson(List<Kelurahan> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Kelurahan {
  int id;
  String name;
  String posCode;
  int kecamatanId;

  Kelurahan({
    required this.id,
    required this.name,
    required this.posCode,
    required this.kecamatanId,
  });

  factory Kelurahan.fromJson(Map<String, dynamic> json) {
    int kecamatanId = 0;
    if (json['kecamatan_id'].runtimeType == String) {
      kecamatanId = int.parse(json['kecamatan_id']);
    } else {
      kecamatanId = json['kecamatan_id'];
    }
    return Kelurahan(
      id: json["id"],
      name: json["name"],
      posCode: json["pos_code"],
      kecamatanId: kecamatanId,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "pos_code": posCode,
        "kecamatan_id": kecamatanId,
      };
}

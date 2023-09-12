// To parse this JSON data, do
//
//     final errorData = errorDataFromJson(jsonString);

import 'dart:convert';

List<ErrorData> errorDataFromJson(String str) =>
    List<ErrorData>.from(json.decode(str).map((x) => ErrorData.fromJson(x)));

String errorDataToJson(List<ErrorData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ErrorData {
  String? email;
  String? noHp;
  String? nik;
  String? keterangan;

  ErrorData({
    this.email,
    this.noHp,
    this.nik,
    this.keterangan,
  });

  factory ErrorData.fromJson(Map<String, dynamic> json) => ErrorData(
        email: json["Email"],
        noHp: json["No HP"],
        nik: json["NIK"],
        keterangan: json["Keterangan"],
      );

  Map<String, dynamic> toJson() => {
        "Email": email,
        "No HP": noHp,
        "NIK": nik,
        "Keterangan": keterangan,
      };
}

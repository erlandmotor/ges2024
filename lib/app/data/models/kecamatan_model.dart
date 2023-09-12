import 'dart:convert';

List<Kecamatan> kecamatanFromJson(String str) =>
    List<Kecamatan>.from(json.decode(str).map((x) => Kecamatan.fromJson(x)));

String kecamatanToJson(List<Kecamatan> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Kecamatan {
  int id;
  String name;
  int kabupatenId;

  Kecamatan({
    required this.id,
    required this.name,
    required this.kabupatenId,
  });

  factory Kecamatan.fromJson(Map<String, dynamic> json) {
    int kabupatenId = 0;
    if (json['kabupaten_id'].runtimeType == String) {
      kabupatenId = int.parse(json['kabupaten_id']);
    } else {
      kabupatenId = json['kabupaten_id'];
    }
    return Kecamatan(
      id: json["id"],
      name: json["name"],
      kabupatenId: kabupatenId,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "kabupaten_id": kabupatenId,
      };
}

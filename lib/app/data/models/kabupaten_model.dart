import 'dart:convert';

List<Kabupaten> kabupatenFromJson(String str) =>
    List<Kabupaten>.from(json.decode(str).map((x) => Kabupaten.fromJson(x)));

String kabupatenToJson(List<Kabupaten> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Kabupaten {
  int id;
  String type;
  String name;
  int provinsiId;

  Kabupaten({
    required this.id,
    required this.type,
    required this.name,
    required this.provinsiId,
  });

  factory Kabupaten.fromJson(Map<String, dynamic> json) {
    int provinsiId = 0;
    if (json['provinsi_id'].runtimeType == String) {
      provinsiId = int.parse(json['provinsi_id']);
    } else {
      provinsiId = json['provinsi_id'];
    }
    return Kabupaten(
      id: json["id"],
      type: json["type"],
      name: json["name"],
      provinsiId: provinsiId,
    );
  }

  @override
  String toString() {
    return 'Kabupaten(id: $id, type: $type, name: $name, provinsiId: $provinsiId)';
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "name": name,
        "provinsi_id": provinsiId,
      };
}

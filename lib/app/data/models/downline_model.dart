import 'dart:convert';

import 'package:ges2024/app/data/models/user_model.dart';

Downline downlineFromJson(String str) => Downline.fromJson(json.decode(str));

String downlineToJson(Downline data) => json.encode(data.toJson());

class Downline {
  UserModel? user;
  int? totalDownlines;
  List<Downline>? downlines;

  Downline({
    this.user,
    this.totalDownlines,
    this.downlines,
  });

  factory Downline.fromJson(Map<String, dynamic> json) => Downline(
        user: json["user"] == null ? null : UserModel.fromJson(json["user"]),
        totalDownlines: json["total_downlines"],
        downlines: json["downlines"] == null
            ? []
            : List<Downline>.from(
                json["downlines"]!.map((x) => Downline.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "total_downlines": totalDownlines,
        "downlines": downlines == null
            ? []
            : List<dynamic>.from(downlines!.map((x) => x.toJson())),
      };
}

import 'dart:convert';

import 'package:movies/models/models.dart';

class CastingResponse {
  CastingResponse({
    required this.id,
    required this.cast,
    required this.crew,
  });

  int id;
  List<Cast> cast;
  List<Cast> crew;

  factory CastingResponse.fromJson(String str) =>
      CastingResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CastingResponse.fromMap(Map<String, dynamic> json) => CastingResponse(
        id: json["id"],
        cast: List<Cast>.from(json["cast"].map((x) => Cast.fromMap(x))),
        crew: List<Cast>.from(json["crew"].map((x) => Cast.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "cast": List<dynamic>.from(cast.map((x) => x.toMap())),
        "crew": List<dynamic>.from(crew.map((x) => x.toMap())),
      };
}

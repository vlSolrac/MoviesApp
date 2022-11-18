import 'dart:convert';

import 'package:movies/models/models.dart';

class OtherMovieResponse {
  OtherMovieResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;

  factory OtherMovieResponse.fromJson(String str) =>
      OtherMovieResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OtherMovieResponse.fromMap(Map<String, dynamic> json) =>
      OtherMovieResponse(
        page: json["page"],
        results:
            List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toMap() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toMap())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}

import 'dart:convert';

import 'package:netflox_movies_app/models/models.dart';

class MovieTopRatedResponse {
    int page;
    List<Movie> results;
    int totalPages;
    int totalResults;

    MovieTopRatedResponse({
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    factory MovieTopRatedResponse.fromJson(String str) => MovieTopRatedResponse.fromMap(json.decode(str));

    factory MovieTopRatedResponse.fromMap(Map<String, dynamic> json) => MovieTopRatedResponse(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );
}
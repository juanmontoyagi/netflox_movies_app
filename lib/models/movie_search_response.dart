import 'dart:convert';

import 'package:netflox_movies_app/models/models.dart';

class MovieSearchResponse {
    int page;
    List<Movie> results;
    int totalPages;
    int totalResults;

    MovieSearchResponse({
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    factory MovieSearchResponse.fromJson(String str) => MovieSearchResponse.fromMap(json.decode(str));

    factory MovieSearchResponse.fromMap(Map<String, dynamic> json) => MovieSearchResponse(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );
}
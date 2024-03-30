import 'dart:convert';
import 'package:netflox_movies_app/models/models.dart';

class MovieUpComingResponse {
    Dates dates;
    int page;
    List<Movie> results;
    int totalPages;
    int totalResults;

    MovieUpComingResponse({
        required this.dates,
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    factory MovieUpComingResponse.fromJson(String str) => MovieUpComingResponse.fromMap(json.decode(str));

    factory MovieUpComingResponse.fromMap(Map<String, dynamic> json) => MovieUpComingResponse(
        dates: Dates.fromMap(json["dates"]),
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );
}
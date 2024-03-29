import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:netflox_movies_app/models/models.dart';
import 'package:netflox_movies_app/models/movie.dart';
import 'package:netflox_movies_app/models/now_playing_response.dart';
import 'package:netflox_movies_app/models/popular_response.dart';

class MoviesProvider extends ChangeNotifier {
  
  String _apiKey = '60f8354fff30a7b288354bcffab65c1a';
  String _baseUrl = 'api.themoviedb.org';
  String _language = 'es-ES';
  
  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  Map<int, List<Cast>> moviesCast = {};

  int _popularPage = 0;
  
  MoviesProvider() {
    print('Movies Providers Inicializer');
    getOnDisplayMovies();
    getPopulateMovies();
  }

  Future<String> _getJsonData(String endPoint, [int page=1]) async{
    var url =
        Uri.https(this._baseUrl, endPoint, {
          'api_key': _apiKey,
          'language': _language,
          'page': '$page'
        });

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async {
    final jsonData = await this._getJsonData('3/movie/now_playing');
    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);
    this.onDisplayMovies = nowPlayingResponse.results;
    // Notifica a todos los oyentes que ocurrió un cambio en la data por ejemplo.
    notifyListeners();
  }

  getPopulateMovies() async {
    _popularPage++;
    final jsonData = await this._getJsonData('3/movie/popular', _popularPage);
    final popularResponse = PopularResponse.fromJson(jsonData);
    this.popularMovies = [ ...popularMovies, ...popularResponse.results ];
    print("Peliculas Populares:");
    print(popularMovies);
    // Notifica a todos los oyentes que ocurrió un cambio en la data por ejemplo.
    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int movieId) async {

    if (moviesCast.containsKey(movieId)) {
      return moviesCast[movieId]!;
    }

    final jsonData = await this._getJsonData('3/movie/$movieId/credits');
    final creditsResponse = CreditCastResponse.fromJson(jsonData);

    moviesCast[movieId] = creditsResponse.cast;
    return creditsResponse.cast;
  }
}

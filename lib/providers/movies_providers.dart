import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:netflox_movies_app/helpers/debouncer.dart';
import 'package:netflox_movies_app/models/models.dart';
import 'package:netflox_movies_app/models/movie.dart';
import 'package:netflox_movies_app/models/now_playing_response.dart';
import 'package:netflox_movies_app/models/popular_response.dart';
import 'package:netflox_movies_app/models/upcoming_movies_response.dart';

class MoviesProvider extends ChangeNotifier {
  
  String _apiKey = '60f8354fff30a7b288354bcffab65c1a';
  String _baseUrl = 'api.themoviedb.org';
  String _language = 'es-ES';
  
  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  List<Movie> upComingMovies = [];
  List<Movie> topRatedMovies = [];


  Map<int, List<Cast>> moviesCast = {};

  int _popularPage = 0;

  final debouncer = Debouncer(duration: Duration(milliseconds: 500));

  final StreamController<List<Movie>> _suggestionStreamController = new StreamController.broadcast();
  Stream<List<Movie>> get suggestionStream => this._suggestionStreamController.stream;

  
  MoviesProvider() {
    print('Movies Providers Inicializer');
    getOnDisplayMovies();
    getPopulateMovies();
    getUpcomingMovies();
    getTopRatedMovies();
  }

  Future<String> _getJsonData(String endPoint, [int page=1]) async{
    final url =
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

  getUpcomingMovies() async {
    _popularPage++;
    final jsonData = await this._getJsonData('3/movie/upcoming', _popularPage);
    final upComingResponse = MovieUpComingResponse.fromJson(jsonData);
    this.upComingMovies = [ ...upComingMovies, ...upComingResponse.results ];
    // Notifica a todos los oyentes que ocurrió un cambio en la data por ejemplo.
    notifyListeners();
  }

  getTopRatedMovies() async {
    _popularPage++;
    final jsonData = await this._getJsonData('3/movie/top_rated', _popularPage);
    final topRatedResponse = MovieTopRatedResponse.fromJson(jsonData);
    this.topRatedMovies = [ ...topRatedMovies, ...topRatedResponse.results ];
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

  Future<List<Movie>> searchMovies(String query) async {
    final url =
        Uri.https(this._baseUrl, '3/search/movie', {
          'api_key': _apiKey,
          'language': _language,
          'query': query
        });
        
    final response = await http.get(url);
    final movieSearchResponse = MovieSearchResponse.fromJson(response.body);

    return movieSearchResponse.results;
  }

  void getSuggestionByQuery(String searchTerm){
    debouncer.value='';
    debouncer.onValue = (value) async {
      final results = await this.searchMovies(value);
      this._suggestionStreamController.add(results);
    };

    final timer = Timer.periodic(Duration(milliseconds: 300), ( _ ) {
      debouncer.value = searchTerm;
    });

    Future.delayed(Duration(milliseconds: 301)).then((value) => timer.cancel());
  }
}

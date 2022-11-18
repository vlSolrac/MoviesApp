import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movies/helpers/debouncer.dart';

import 'package:movies/models/models.dart';
import 'package:http/http.dart' as http;

class MoviesProvider extends ChangeNotifier {
  final String _baseUrl = "api.themoviedb.org";
  final String _apiKey = "de5bb20f5516a40672b3345963dfec4c";
  final String _languaje = "es-Es";

  List<Movie> nowPlayMovies = [];
  List<Movie> popularMovies = [];
  List<Movie> upcomingMovies = [];
  List<Movie> topRatedMovies = [];
  List<Movie> latestMovies = [];
  List<Movie> searchMovies = [];
  List<Cast> castingMovies = [];

  Map<int, List<Cast>> movieCast = {};
  Map<String, List<Movie>> mapSearchMovies = {};

  int _popularPage = 0;
  int _topRatedPage = 0;
  int _upComingPage = 0;

  final debouncer = Debouncer(
    duration: const Duration(milliseconds: 500),
  );

  final StreamController<List<Movie>> _streamController =
      StreamController.broadcast();

  Stream<List<Movie>> get stream => _streamController.stream;

  MoviesProvider() {
    getNowPlayMovies();
    getPopularMovies();
    getTopRatedMovies();
    getUpComingMovies();
  }

  Future<String> getJsonData({required String endpoint, int page = 1}) async {
    try {
      final url = Uri.https(_baseUrl, endpoint, {
        "api_key": _apiKey,
        "language": _languaje,
        "page": "$page",
      });

      final response = await http.get(url);
      return response.body;
    } on Exception catch (e) {
      return e.toString();
    }
  }

  Future<List<Cast>> getCatingMovie(int idMovie) async {
    // TODO: pasarlo al casting Provider y hcerlo de ontra manera.

    if (movieCast.containsKey(idMovie)) return movieCast[idMovie]!;

    final response = await getJsonData(endpoint: "3/movie/$idMovie/credits");
    final castingResponse = CastingResponse.fromJson(response);

    movieCast[idMovie] = castingResponse.cast;

    castingMovies = [...castingResponse.cast];

    return castingResponse.cast;
  }

  Future<List<Movie>> searchMovie(String query) async {
    if (mapSearchMovies.containsKey(query)) return mapSearchMovies[query]!;

    final url = Uri.https(_baseUrl, "3/search/movie", {
      "api_key": _apiKey,
      "language": _languaje,
      "query": query,
    });

    final response = await http.get(url);
    final movieResponse = SearchResponse.fromJson(response.body);

    mapSearchMovies[query] = movieResponse.results;

    searchMovies = [...movieResponse.results];

    return searchMovies;
  }

  void getSuggestionByQuery(String searchTerm) {
    debouncer.value = "";
    debouncer.onValue = (value) async {
      final results = await searchMovie(searchTerm);
      _streamController.add(results);
    };

    final timer = Timer.periodic(const Duration(milliseconds: 300), (_) {
      debouncer.value = searchTerm;
    });

    Future.delayed(const Duration(milliseconds: 301))
        .then((value) => timer.cancel());
  }

  getNowPlayMovies() async {
    final response = await getJsonData(endpoint: "3/movie/now_playing");
    final movieResponse = MoviesResponse.fromJson(response);

    nowPlayMovies = [...movieResponse.results];

// le avisa a todos los widget que estas escuchando que algo cambio
    notifyListeners();
  }

  getPopularMovies() async {
    _popularPage++;

    final response =
        await getJsonData(endpoint: "3/movie/popular", page: _popularPage);

    final movieResponse = OtherMovieResponse.fromJson(response);

    popularMovies = [...popularMovies, ...movieResponse.results];

// le avisa a todos los widget que estas escuchando que algo cambio
    notifyListeners();
  }

  getTopRatedMovies() async {
    _topRatedPage++;

    final response =
        await getJsonData(endpoint: "3/movie/top_rated", page: _topRatedPage);
    final movieResponse = OtherMovieResponse.fromJson(response);

    topRatedMovies = [...topRatedMovies, ...movieResponse.results];

// le avisa a todos los widget que estas escuchando que algo cambio
    notifyListeners();
  }

  getUpComingMovies() async {
    _upComingPage++;

    final response =
        await getJsonData(endpoint: "3/movie/upcoming", page: _upComingPage);
    final movieResponse = OtherMovieResponse.fromJson(response);

    upcomingMovies = [...upcomingMovies, ...movieResponse.results];

// le avisa a todos los widget que estas escuchando que algo cambio
    notifyListeners();
  }
}

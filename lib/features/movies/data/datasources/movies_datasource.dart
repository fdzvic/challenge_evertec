import 'dart:developer';

import 'package:challenge_evertec/core/network/http_client_service.dart';
import '../models/movie_model.dart';

abstract class MoviesDataSource {
  Future<List<MovieModel>> getPopularMovies(int page);
  Future<List<MovieModel>> getNowPlayingMovies(int page);
  Future<List<MovieModel>> getTopRatedMovies(int page);
  Future<List<MovieModel>> getUpcomingMovies(int page);
}

class MoviesDataSourceImpl implements MoviesDataSource {
  final HttpClientService client;

  MoviesDataSourceImpl(this.client);

  List<MovieModel> _jsonToMovies(Map<String, dynamic> json) {
    log(json.toString());
    final results = json['results'] as List;
    return results.map((movie) => MovieModel.fromJson(movie)).toList();
  }

  @override
  Future<List<MovieModel>> getPopularMovies(int page) async {
    final response = await client.get(
      '/movie/popular',
      query: {'page': page.toString()},
    );
    return _jsonToMovies(response);
  }

  @override
  Future<List<MovieModel>> getNowPlayingMovies(int page) async {
    final response = await client.get(
      '/movie/now_playing',
      query: {'page': page.toString()},
    );
    return _jsonToMovies(response);
  }

  @override
  Future<List<MovieModel>> getTopRatedMovies(int page) async {
    final response = await client.get(
      '/movie/top_rated',
      query: {'page': page.toString()},
    );
    return _jsonToMovies(response);
  }

  @override
  Future<List<MovieModel>> getUpcomingMovies(int page) async {
    final response = await client.get(
      '/movie/upcoming',
      query: {'page': page.toString()},
    );
    return _jsonToMovies(response);
  }
}

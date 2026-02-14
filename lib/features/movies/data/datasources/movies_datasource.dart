import 'dart:developer';

import 'package:challenge_evertec/core/network/http_client_service.dart';
import 'package:challenge_evertec/features/movies/data/models/movie_details_model.dart';
import 'package:challenge_evertec/features/movies/data/models/movie_model.dart';

abstract class MoviesDataSource {
  Future<List<MovieModel>> getPopularMovies(int page);
  Future<List<MovieModel>> getNowPlayingMovies(int page);
  Future<List<MovieModel>> getTopRatedMovies(int page);
  Future<List<MovieModel>> getUpcomingMovies(int page);
  Future<MovieDetailModel> getMovieById(String id);
}

class MoviesDataSourceImpl implements MoviesDataSource {
  MoviesDataSourceImpl(this.client);
  final HttpClientService client;

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

  @override
  Future<MovieDetailModel> getMovieById(String id) async {
    final response = await client.get('/movie/$id');
    if (response['id'] == null) {
      throw Exception('Movie not found');
    }
    return MovieDetailModel.fromJson(response);
  }
}

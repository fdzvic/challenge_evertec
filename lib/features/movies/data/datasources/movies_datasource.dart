import 'dart:developer';

import 'package:challenge_evertec/core/network/http_client_service.dart';
import '../models/movie_model.dart';

abstract class MoviesDataSource {
  Future<List<MovieModel>> getPopularMovies();
}

class MoviesDataSourceImpl implements MoviesDataSource {
  final HttpClientService client;

  MoviesDataSourceImpl(this.client);

  @override
  Future<List<MovieModel>> getPopularMovies() async {
    final response = await client.get('/movie/popular');
    log(response.toString());

    final results = response['results'] as List;

    return results
        .map((movie) => MovieModel.fromJson(movie))
        .toList();
  }
}

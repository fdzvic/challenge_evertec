import 'package:challenge_evertec/features/movies/data/datasources/movies_datasource.dart';
import 'package:challenge_evertec/features/movies/domain/entities/movie_details_entity.dart';
import 'package:challenge_evertec/features/movies/domain/entities/movie_entity.dart';
import 'package:challenge_evertec/features/movies/domain/repositories/movies_repository.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  MoviesRepositoryImpl(this.movies);
  final MoviesDataSource movies;

  @override
  Future<List<MovieEntity>> getPopularMovies(int page) {
    return movies.getPopularMovies(page);
  }

  @override
  Future<List<MovieEntity>> getNowPlayingMovies(int page) {
    return movies.getNowPlayingMovies(page);
  }

  @override
  Future<List<MovieEntity>> getTopRatedMovies(int page) {
    return movies.getTopRatedMovies(page);
  }

  @override
  Future<List<MovieEntity>> getUpcomingMovies(int page) {
    return movies.getUpcomingMovies(page);
  }

  @override
  Future<MovieDetailsEntity> getMovieById(String id) {
    return movies.getMovieById(id);
  }
}

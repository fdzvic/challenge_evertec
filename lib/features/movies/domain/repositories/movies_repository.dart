import 'package:challenge_evertec/features/movies/domain/entities/movie_details_entity.dart';
import 'package:challenge_evertec/features/movies/domain/entities/movie_entity.dart';

abstract class MoviesRepository {
  Future<List<MovieEntity>> getPopularMovies(int page);
  Future<List<MovieEntity>> getNowPlayingMovies(int page);
  Future<List<MovieEntity>> getTopRatedMovies(int page);
  Future<List<MovieEntity>> getUpcomingMovies(int page);
  Future<MovieDetailsEntity> getMovieById(String id);
}
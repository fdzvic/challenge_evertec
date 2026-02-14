import '../entities/movie_entity.dart';

abstract class MoviesRepository {
  Future<List<MovieEntity>> getPopularMovies(int page);
}
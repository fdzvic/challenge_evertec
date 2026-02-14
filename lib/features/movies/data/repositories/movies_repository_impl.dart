import 'package:challenge_evertec/features/movies/data/datasources/movies_datasource.dart';
import '../../domain/entities/movie_entity.dart';
import '../../domain/repositories/movies_repository.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  final MoviesDataSource movies;

  MoviesRepositoryImpl(this.movies);

  @override
  Future<List<MovieEntity>> getPopularMovies(int page) {
    return movies.getPopularMovies(page);
  }
}

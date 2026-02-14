import 'package:challenge_evertec/features/movies/data/datasources/movies_datasource.dart';
import '../../domain/entities/movie_entity.dart';
import '../../domain/repositories/movies_repository.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  final MoviesDataSource remote;

  MoviesRepositoryImpl(this.remote);

  @override
  Future<List<MovieEntity>> getPopularMovies() {
    return remote.getPopularMovies();
  }
}

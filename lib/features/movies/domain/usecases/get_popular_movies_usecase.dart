import '../entities/movie_entity.dart';
import '../repositories/movies_repository.dart';

class GetPopularMoviesUseCase {
  final MoviesRepository repository;

  GetPopularMoviesUseCase(this.repository);

  Future<List<MovieEntity>> call() {
    return repository.getPopularMovies();
  }
}

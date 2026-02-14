import '../entities/movie_entity.dart';
import '../repositories/movies_repository.dart';

class GetUpcomingMoviesUseCase {
  final MoviesRepository repository;

  GetUpcomingMoviesUseCase(this.repository);

  Future<List<MovieEntity>> call(int page) {
    return repository.getUpcomingMovies(page);
  }
}

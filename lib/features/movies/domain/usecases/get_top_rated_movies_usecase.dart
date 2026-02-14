import '../entities/movie_entity.dart';
import '../repositories/movies_repository.dart';

class GetTopRatedMoviesUseCase {
  final MoviesRepository repository;

  GetTopRatedMoviesUseCase(this.repository);

  Future<List<MovieEntity>> call(int page) {
    return repository.getTopRatedMovies(page);
  }
}

import '../entities/movie_entity.dart';
import '../repositories/movies_repository.dart';

class GetNowPlayingMoviesUseCase {
  final MoviesRepository repository;

  GetNowPlayingMoviesUseCase(this.repository);

  Future<List<MovieEntity>> call(int page) {
    return repository.getNowPlayingMovies(page);
  }
}

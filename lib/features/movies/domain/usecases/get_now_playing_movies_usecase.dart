import 'package:challenge_evertec/features/movies/domain/entities/movie_entity.dart';
import 'package:challenge_evertec/features/movies/domain/repositories/movies_repository.dart';

class GetNowPlayingMoviesUseCase {
  GetNowPlayingMoviesUseCase(this.repository);
  final MoviesRepository repository;

  Future<List<MovieEntity>> call(int page) {
    return repository.getNowPlayingMovies(page);
  }
}

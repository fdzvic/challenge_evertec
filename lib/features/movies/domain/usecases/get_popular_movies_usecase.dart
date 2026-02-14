import 'package:challenge_evertec/features/movies/domain/entities/movie_entity.dart';
import 'package:challenge_evertec/features/movies/domain/repositories/movies_repository.dart';

class GetPopularMoviesUseCase {

  GetPopularMoviesUseCase(this.repository);
  final MoviesRepository repository;

  Future<List<MovieEntity>> call(int page) {
    return repository.getPopularMovies(page);
  }
}

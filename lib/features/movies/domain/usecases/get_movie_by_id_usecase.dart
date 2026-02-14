import 'package:challenge_evertec/features/movies/domain/entities/movie_details_entity.dart';
import 'package:challenge_evertec/features/movies/domain/repositories/movies_repository.dart';

class GetMovieByIdUsecase {
  GetMovieByIdUsecase(this.repository);
  final MoviesRepository repository;

  Future<MovieDetailsEntity> call(String id) {
    return repository.getMovieById(id);
  }
}

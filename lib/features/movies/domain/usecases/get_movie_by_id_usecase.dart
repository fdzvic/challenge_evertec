import 'package:challenge_evertec/features/movies/domain/entities/movie_details_entity.dart';
import '../repositories/movies_repository.dart';

class GetMovieByIdUsecase {
  final MoviesRepository repository;

  GetMovieByIdUsecase(this.repository);

  Future<MovieDetailsEntity> call(String id) {
    return repository.getMovieById(id);
  }
}

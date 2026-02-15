import 'package:challenge_evertec/features/favorites/domain/repositories/favorites_repository.dart';

class RemoveFavoriteUseCase {

  RemoveFavoriteUseCase(this.repo);
  final FavoritesRepository repo;

  Future<void> call(int movieId) {
    return repo.removeFavorite(movieId);
  }
}

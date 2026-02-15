import 'package:challenge_evertec/core/database/database.dart';
import 'package:challenge_evertec/features/favorites/domain/repositories/favorites_repository.dart';

class AddFavoriteUseCase {
  AddFavoriteUseCase(this.repo);
  final FavoritesRepository repo;

  Future<void> call(FavoriteMoviesCompanion movie) {
    return repo.addFavorite(movie);
  }
}

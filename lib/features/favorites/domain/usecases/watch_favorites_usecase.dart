import 'package:challenge_evertec/core/database/database.dart';
import 'package:challenge_evertec/features/favorites/domain/repositories/favorites_repository.dart';

class WatchFavoritesUseCase {
  WatchFavoritesUseCase(this.repo);
  final FavoritesRepository repo;

  Stream<List<FavoriteMovy>> call() {
    return repo.watchFavorites();
  }
}

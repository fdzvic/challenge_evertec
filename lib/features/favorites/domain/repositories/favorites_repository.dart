import 'package:challenge_evertec/core/database/database.dart';

abstract class FavoritesRepository {
  Future<void> addFavorite(FavoriteMoviesCompanion movie);
  Future<void> removeFavorite(int movieId);
  Future<bool> isFavorite(int movieId);
  Stream<List<FavoriteMovy>> watchFavorites();
}

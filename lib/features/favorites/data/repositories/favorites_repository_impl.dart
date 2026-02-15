import 'package:challenge_evertec/core/database/database.dart';

import 'package:challenge_evertec/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:challenge_evertec/features/favorites/data/datasources/favorites_local_datasource.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  FavoritesRepositoryImpl(this.local);
  final FavoritesLocalDataSource local;

  @override
  Future<void> addFavorite(movie) => local.addFavorite(movie);

  @override
  Future<void> removeFavorite(int movieId) => local.removeFavorite(movieId);

  @override
  Future<bool> isFavorite(int movieId) => local.isFavorite(movieId);

  @override
  Stream<List<FavoriteMovy>> watchFavorites() => local.watchFavorites();
}

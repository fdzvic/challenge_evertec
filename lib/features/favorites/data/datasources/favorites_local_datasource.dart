import 'package:challenge_evertec/core/database/database.dart';

abstract class FavoritesLocalDataSource {
  Future<void> addFavorite(FavoriteMoviesCompanion movie);
  Future<void> removeFavorite(int movieId);
  Future<bool> isFavorite(int movieId);
  Stream<List<FavoriteMovy>> watchFavorites();
}

class FavoritesLocalDataSourceImpl implements FavoritesLocalDataSource {
  FavoritesLocalDataSourceImpl(this.db);
  final AppDatabase db;

  @override
  Future<void> addFavorite(FavoriteMoviesCompanion movie) async {
    await db.into(db.favoriteMovies).insert(movie);
  }

  @override
  Future<void> removeFavorite(int movieId) async {
    await (db.delete(
      db.favoriteMovies,
    )..where((tbl) => tbl.movieId.equals(movieId))).go();
  }

  @override
  Future<bool> isFavorite(int movieId) async {
    final query = await (db.select(
      db.favoriteMovies,
    )..where((tbl) => tbl.movieId.equals(movieId))).getSingleOrNull();

    return query != null;
  }

  @override
  Stream<List<FavoriteMovy>> watchFavorites() {
    return db.select(db.favoriteMovies).watch();
  }
}

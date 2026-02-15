import 'dart:async';

import 'package:challenge_evertec/core/database/database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:drift/drift.dart';
import 'package:challenge_evertec/features/favorites/domain/usecases/add_favorite_usecase.dart';
import 'package:challenge_evertec/features/favorites/domain/usecases/remove_favorite_usecase.dart';
import 'package:challenge_evertec/features/favorites/domain/usecases/watch_favorites_usecase.dart';
import 'package:challenge_evertec/features/favorites/presentation/cubit/favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit({
    required this.addFavorite,
    required this.removeFavorite,
    required this.watchFavorites,
  }) : super(FavoritesInitial());

  final AddFavoriteUseCase addFavorite;
  final RemoveFavoriteUseCase removeFavorite;
  final WatchFavoritesUseCase watchFavorites;

  StreamSubscription? _subscription;

  void startListening() {
    _subscription?.cancel();
    _subscription = watchFavorites().listen((favorites) {
      emit(FavoritesLoaded(favorites));
    });
  }

  Future<void> toggleFavorite({
    required int movieId,
    required String title,
    required String posterPath,
    required String backdropPath,
    required String originalTitle,
    required double voteAverage,
  }) async {
    if (state is FavoritesLoaded) {
      final favorites = (state as FavoritesLoaded).favorites;

      final exists = favorites.any((element) => element.movieId == movieId);

      if (exists) {
        await removeFavorite(movieId);
      } else {
        await addFavorite(
          FavoriteMoviesCompanion.insert(
            movieId: movieId,
            title: title,
            posterPath: posterPath,
            backdropPath: backdropPath,
            originalTitle: originalTitle,
            voteAverage: Value(voteAverage),
          ),
        );
      }
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}

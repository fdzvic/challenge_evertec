import 'package:challenge_evertec/core/config/locale_services.dart';
import 'package:challenge_evertec/core/database/database.dart';
import 'package:challenge_evertec/core/network/http_client_service.dart';
import 'package:challenge_evertec/core/storage/local_storage_service.dart';
import 'package:challenge_evertec/core/theme/theme.dart';
import 'package:challenge_evertec/features/auth/auth.dart';
import 'package:challenge_evertec/features/favorites/data/datasources/favorites_local_datasource.dart';
import 'package:challenge_evertec/features/favorites/data/repositories/favorites_repository_impl.dart';
import 'package:challenge_evertec/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:challenge_evertec/features/favorites/domain/usecases/add_favorite_usecase.dart';
import 'package:challenge_evertec/features/favorites/domain/usecases/remove_favorite_usecase.dart';
import 'package:challenge_evertec/features/favorites/domain/usecases/watch_favorites_usecase.dart';
import 'package:challenge_evertec/features/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:challenge_evertec/features/movies/data/datasources/movies_datasource.dart';
import 'package:challenge_evertec/features/movies/data/repositories/movies_repository_impl.dart';
import 'package:challenge_evertec/features/movies/domain/repositories/movies_repository.dart';
import 'package:challenge_evertec/features/movies/domain/usecases/get_movie_by_id_usecase.dart';
import 'package:challenge_evertec/features/movies/domain/usecases/get_now_playing_movies_usecase.dart';
import 'package:challenge_evertec/features/movies/domain/usecases/get_popular_movies_usecase.dart';
import 'package:challenge_evertec/features/movies/domain/usecases/get_top_rated_movies_usecase.dart';
import 'package:challenge_evertec/features/movies/domain/usecases/get_upcoming_movies_usecase.dart';
import 'package:challenge_evertec/features/movies/presentation/cubit/movie_detail/movie_detail_cubit.dart';
import 'package:challenge_evertec/features/movies/presentation/cubit/movies/movies_cubit.dart';
import 'package:challenge_evertec/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:challenge_evertec/features/profile/domain/repositories/profile_repository.dart';
import 'package:challenge_evertec/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:challenge_evertec/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

final getIt = GetIt.instance;

Future<void> serviceLocatorInit() async {
  // Local Storage
  final sharedPreferences = await SharedPreferences.getInstance();

  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  getIt.registerLazySingleton<LocalStorageService>(
    () => LocalStorageServiceImpl(getIt()),
  );

  //Database

  getIt.registerLazySingleton<AppDatabase>(() => AppDatabase());
  getIt.registerLazySingleton<FavoritesLocalDataSource>(
    () => FavoritesLocalDataSourceImpl(getIt()),
  );
  getIt.registerLazySingleton<FavoritesRepository>(
    () => FavoritesRepositoryImpl(getIt()),
  );

  getIt.registerLazySingleton(() => AddFavoriteUseCase(getIt()));
  getIt.registerLazySingleton(() => RemoveFavoriteUseCase(getIt()));
  getIt.registerLazySingleton(() => WatchFavoritesUseCase(getIt()));
  getIt.registerFactory(
    () => FavoritesCubit(
      addFavorite: getIt<AddFavoriteUseCase>(),
      removeFavorite: getIt<RemoveFavoriteUseCase>(),
      watchFavorites: getIt<WatchFavoritesUseCase>(),
    ),
  );

  // Theme
  getIt.registerLazySingleton<ThemeLocalDataSource>(
    () => ThemeLocalDataSource(getIt()),
  );
  getIt.registerLazySingleton<ThemeCubit>(() => ThemeCubit(getIt()));

  /// authentication

  // FirebaseAuth
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  // FirebaseFirestore
  getIt.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );
  // DataSource
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(getIt()),
  );
  // Repository
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      getIt<AuthRemoteDataSource>(),
      getIt<FirebaseFirestore>(),
    ),
  );
  // UseCases
  getIt.registerLazySingleton(() => LoginUseCase(getIt()));
  getIt.registerLazySingleton(() => RegisterUseCase(getIt()));
  getIt.registerLazySingleton(() => LogoutUseCase(getIt()));
  getIt.registerLazySingleton(() => GetCurrentUserUseCase(getIt()));
  // Cubit
  getIt.registerLazySingleton(
    () => AuthCubit(
      loginUseCase: getIt(),
      registerUseCase: getIt(),
      logoutUseCase: getIt(),
      getCurrentUserUseCase: getIt(),
    ),
  );

  /// Profile
  // DataSource
  getIt.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(getIt()),
  );
  // UseCases
  getIt.registerLazySingleton(() => GetProfileUseCase(getIt()));
  // Cubit
  getIt.registerFactory(() => ProfileCubit(getIt()));

  /// Network
  getIt.registerLazySingleton(() => HttpClientService(getIt()));
  getIt.registerLazySingleton(() => LocaleService());

  /// Movies

  getIt.registerLazySingleton<MoviesDataSource>(
    () => MoviesDataSourceImpl(getIt()),
  );

  getIt.registerLazySingleton<MoviesRepository>(
    () => MoviesRepositoryImpl(getIt()),
  );

  getIt.registerLazySingleton(() => GetPopularMoviesUseCase(getIt()));
  getIt.registerLazySingleton(() => GetNowPlayingMoviesUseCase(getIt()));
  getIt.registerLazySingleton(() => GetTopRatedMoviesUseCase(getIt()));
  getIt.registerLazySingleton(() => GetUpcomingMoviesUseCase(getIt()));

  getIt.registerFactory(
    () => MoviesCubit(
      getPopularMovies: getIt<GetPopularMoviesUseCase>(),
      getNowPlayingMovies: getIt<GetNowPlayingMoviesUseCase>(),
      getTopRatedMovies: getIt<GetTopRatedMoviesUseCase>(),
      getUpcomingMovies: getIt<GetUpcomingMoviesUseCase>(),
    ),
  );

  getIt.registerLazySingleton(() => GetMovieByIdUsecase(getIt()));

  getIt.registerFactory(() => MovieDetailCubit(getIt()));
}

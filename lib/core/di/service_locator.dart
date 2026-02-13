import 'package:challenge_evertec/core/storage/local_storage_service.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/auth/auth.dart';
import '../theme/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';


final getIt = GetIt.instance;

Future<void> serviceLocatorInit() async {
  // Local Storage
  final sharedPreferences = await SharedPreferences.getInstance();

  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  getIt.registerLazySingleton<LocalStorageService>(
    () => LocalStorageServiceImpl(getIt()),
  );
  // Theme
  getIt.registerLazySingleton<ThemeLocalDataSource>(
    () => ThemeLocalDataSource(getIt()),
  );
  getIt.registerLazySingleton<ThemeCubit>(() => ThemeCubit(getIt()));

  // authentication
  // FirebaseAuth
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  // DataSource
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(getIt()),
  );

  // Repository
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt()),
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
}

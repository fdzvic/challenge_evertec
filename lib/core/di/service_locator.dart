import 'package:challenge_evertec/core/storage/local_storage_service.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme/theme.dart';

final getIt = GetIt.instance;

Future<void> serviceLocatorInit() async {
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
}

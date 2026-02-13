import 'package:challenge_evertec/core/theme/theme_cubit.dart';
import 'package:get_it/get_it.dart';


final getIt = GetIt.instance;

Future<void> serviceLocatorInit() async {
  // Theme
  getIt.registerLazySingleton<ThemeCubit>(() => ThemeCubit());
}

import 'package:challenge_evertec/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeState> {

  ThemeCubit(this.localDataSource)
      : super(const ThemeState(themeMode: ThemeMode.system));
  final ThemeLocalDataSource localDataSource;

  Future<void> setDarkMode() async {
    await localDataSource.saveTheme('dark');
    emit(const ThemeState(themeMode: ThemeMode.dark));
  }

  Future<void> setLightMode() async {
    await localDataSource.saveTheme('light');
    emit(const ThemeState(themeMode: ThemeMode.light));
  }

  Future<void> loadTheme() async {
    final theme = localDataSource.getTheme();

    if (theme == 'dark') {
      emit(const ThemeState(themeMode: ThemeMode.dark));
    } else if (theme == 'light') {
      emit(const ThemeState(themeMode: ThemeMode.light));
    }
  }

  bool isDarkMode(Brightness platformBrightness) {
    switch (state.themeMode) {
      case ThemeMode.dark:
        return true;
      case ThemeMode.light:
        return false;
      case ThemeMode.system:
        return platformBrightness == Brightness.dark;
    }
  }
}

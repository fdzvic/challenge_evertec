import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeState(themeMode: ThemeMode.system));

  void setLightMode() {
    emit(state.copyWith(themeMode: ThemeMode.light, ));
  }

  void setDarkMode() {
    emit(state.copyWith(themeMode: ThemeMode.dark));
  }

  void setSystemMode() {
    emit(state.copyWith(themeMode: ThemeMode.system));
  }

  void toggleTheme() {
    if (state.themeMode == ThemeMode.light) {
      setDarkMode();
    } else {
      setLightMode();
    }
  }

  bool isDarkMode(Brightness platformBrightness) {
    if (state.themeMode == ThemeMode.dark) return true;
    if (state.themeMode == ThemeMode.light) return false;
    return platformBrightness == Brightness.dark;
  }
}

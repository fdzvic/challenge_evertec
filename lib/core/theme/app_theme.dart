import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static ThemeData _theme(Brightness brightness) {
    final scheme = ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: brightness,
    ).copyWith(primary: Colors.blue);

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
    );
  }

  static ThemeData get lightTheme => _theme(Brightness.light);
  static ThemeData get darkTheme => _theme(Brightness.dark);
}

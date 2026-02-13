import 'package:challenge_evertec/core/theme/theme_cubit.dart';
import 'package:challenge_evertec/core/theme/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';




void main() {
  group('ThemeCubit', () {
    late ThemeCubit cubit;

    setUp(() {
      cubit = ThemeCubit();
    });

    test('initial state is system mode', () {
      expect(cubit.state.themeMode, ThemeMode.system);
    });

    blocTest<ThemeCubit, ThemeState>(
      'emits light mode when setLightMode is called',
      build: () => cubit,
      act: (cubit) => cubit.setLightMode(),
      expect: () => [
        const ThemeState(themeMode: ThemeMode.light),
      ],
    );

    blocTest<ThemeCubit, ThemeState>(
      'emits dark mode when setDarkMode is called',
      build: () => cubit,
      act: (cubit) => cubit.setDarkMode(),
      expect: () => [
        const ThemeState(themeMode: ThemeMode.dark),
      ],
    );
  });
}

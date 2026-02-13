import 'package:bloc_test/bloc_test.dart';
import 'package:challenge_evertec/core/theme/theme_cubit.dart';
import 'package:challenge_evertec/core/theme/theme_state.dart';
import 'package:challenge_evertec/core/theme/data/theme_local_datasource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockThemeLocalDataSource extends Mock
    implements ThemeLocalDataSource {}

void main() {
  late ThemeCubit cubit;
  late MockThemeLocalDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockThemeLocalDataSource();

    // Stub por defecto
    when(() => mockDataSource.getTheme()).thenReturn(null);
    when(() => mockDataSource.saveTheme(any()))
        .thenAnswer((_) async {});

    cubit = ThemeCubit(mockDataSource);
  });

  group('ThemeCubit', () {
    test('initial state is system mode', () {
      expect(cubit.state.themeMode, ThemeMode.system);
    });

    blocTest<ThemeCubit, ThemeState>(
      'emits light mode when setLightMode is called',
      build: () => ThemeCubit(mockDataSource),
      act: (cubit) => cubit.setLightMode(),
      expect: () => [
        const ThemeState(themeMode: ThemeMode.light),
      ],
      verify: (_) {
        verify(() => mockDataSource.saveTheme('light')).called(1);
      },
    );

    blocTest<ThemeCubit, ThemeState>(
      'emits dark mode when setDarkMode is called',
      build: () => ThemeCubit(mockDataSource),
      act: (cubit) => cubit.setDarkMode(),
      expect: () => [
        const ThemeState(themeMode: ThemeMode.dark),
      ],
      verify: (_) {
        verify(() => mockDataSource.saveTheme('dark')).called(1);
      },
    );
  });
}

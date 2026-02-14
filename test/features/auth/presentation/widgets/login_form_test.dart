import 'package:bloc_test/bloc_test.dart';
import 'package:challenge_evertec/features/auth/presentation/widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:challenge_evertec/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:challenge_evertec/features/auth/auth.dart';

class MockAuthCubit extends Mock implements AuthCubit {}
class FakeAuthState extends Fake implements AuthState {}

void main() {
  late MockAuthCubit mockCubit;

  setUpAll(() {
    registerFallbackValue(FakeAuthState());
  });

  setUp(() {
    mockCubit = MockAuthCubit();
    when(() => mockCubit.state).thenReturn(AuthInitial());
    whenListen(
      mockCubit,
      Stream<AuthState>.fromIterable([AuthInitial()]),
    );
    when(() => mockCubit.login(any(), any())).thenAnswer((_) async {});
  });

    testWidgets('renders email, password and button', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        home: BlocProvider<AuthCubit>.value(
          value: mockCubit,
          child: const Scaffold(body: LoginForm()),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.text('Login'), findsOneWidget);
  });

    testWidgets('calls cubit login when form valid', (tester) async {

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        home: BlocProvider<AuthCubit>.value(
          value: mockCubit,
          child: const Scaffold(body: LoginForm()),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // escribir email
    await tester.enterText(find.byType(TextFormField).at(0), 'test@mail.com');

    // escribir password
    await tester.enterText(find.byType(TextFormField).at(1), '123456');

    // presionar botón
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();

    verify(() => mockCubit.login('test@mail.com', '123456')).called(1);
  });

    testWidgets('shows loading when state is loading', (tester) async {

    when(() => mockCubit.state).thenReturn(AuthLoading());
    whenListen(
      mockCubit,
      Stream<AuthState>.fromIterable([AuthLoading()]),
    );

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        home: BlocProvider<AuthCubit>.value(
          value: mockCubit,
          child: const Scaffold(body: LoginForm()),
        ),
      ),
    );
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
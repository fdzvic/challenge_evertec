import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:challenge_evertec/features/auth/auth.dart';

class MockLoginUseCase extends Mock implements LoginUseCase {}

class MockRegisterUseCase extends Mock implements RegisterUseCase {}

class MockLogoutUseCase extends Mock implements LogoutUseCase {}

class MockGetCurrentUserUseCase extends Mock implements GetCurrentUserUseCase {}

void main() {
  late AuthCubit cubit;
  late MockLoginUseCase mockLogin;
  late MockRegisterUseCase mockRegister;
  late MockLogoutUseCase mockLogout;
  late MockGetCurrentUserUseCase mockGetUser;

  setUp(() {
    mockLogin = MockLoginUseCase();
    mockRegister = MockRegisterUseCase();
    mockLogout = MockLogoutUseCase();
    mockGetUser = MockGetCurrentUserUseCase();

    cubit = AuthCubit(
      loginUseCase: mockLogin,
      registerUseCase: mockRegister,
      logoutUseCase: mockLogout,
      getCurrentUserUseCase: mockGetUser,
    );
  });
  blocTest<AuthCubit, AuthState>(
    'emits [AuthLoading, AuthAuthenticated] on successful login',
    build: () {
      when(
        () => mockLogin('test@mail.com', '123456'),
      ).thenAnswer((_) async => UserEntity(id: '1', email: 'test@mail.com'));
      return cubit;
    },
    act: (cubit) => cubit.login('test@mail.com', '123456'),
    expect: () => [isA<AuthLoading>(), isA<AuthAuthenticated>()],
  );

  blocTest<AuthCubit, AuthState>(
    'emits [AuthLoading, AuthError] on login failure',
    build: () {
      when(() => mockLogin(any(), any())).thenThrow(Exception('Login failed'));
      return cubit;
    },
    act: (cubit) => cubit.login('test@mail.com', '123456'),
    expect: () => [isA<AuthLoading>(), isA<AuthError>()],
  );
  blocTest<AuthCubit, AuthState>(
    'emits AuthAuthenticated when user exists',
    build: () {
      when(
        () => mockGetUser(),
      ).thenAnswer((_) async => UserEntity(id: '1', email: 'test@mail.com'));
      return cubit;
    },
    act: (cubit) => cubit.checkAuthStatus(),
    expect: () => [isA<AuthAuthenticated>()],
  );

  blocTest<AuthCubit, AuthState>(
    'emits AuthUnauthenticated when no user',
    build: () {
      when(() => mockGetUser()).thenAnswer((_) async => null);
      return cubit;
    },
    act: (cubit) => cubit.checkAuthStatus(),
    expect: () => [isA<AuthUnauthenticated>()],
  );
}

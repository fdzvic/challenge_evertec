import 'package:challenge_evertec/core/error/exceptions/auth_exception_mapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../auth.dart';


class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final LogoutUseCase logoutUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;

  AuthCubit({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.logoutUseCase,
    required this.getCurrentUserUseCase,
  }) : super(AuthInitial());

  Future<void> checkAuthStatus() async {
    final user = await getCurrentUserUseCase();
    if (user != null) {
      emit(AuthAuthenticated(user));
    } else {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> login(String email, String password) async {
  emit(AuthLoading());

  try {
    final user = await loginUseCase(email, password);
    emit(AuthAuthenticated(user));
  } on FirebaseAuthException catch (e) {
    final message = AuthExceptionMapper.map(e);
    emit(AuthError(message));
  } catch (_) {
    emit(AuthError('Ocurrió un error inesperado.'));
  }
}


  Future<void> register(String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await registerUseCase(email, password);
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> logout() async {
    await logoutUseCase();
    emit(AuthUnauthenticated());
  }
}

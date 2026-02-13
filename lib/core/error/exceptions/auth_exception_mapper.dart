import 'package:firebase_auth/firebase_auth.dart';

class AuthExceptionMapper {

  static String map(FirebaseAuthException e) {
    switch (e.code) {

      case 'invalid-email':
        return 'El correo electrónico no es válido.';

      case 'user-not-found':
        return 'No existe una cuenta con este correo.';

      case 'wrong-password':
        return 'La contraseña es incorrecta.';

      case 'email-already-in-use':
        return 'Este correo ya está registrado.';

      case 'weak-password':
        return 'La contraseña debe tener al menos 6 caracteres.';

      case 'network-request-failed':
        return 'Error de conexión. Verifica tu internet.';

      case 'invalid-credential':
        return 'Credenciales inválidas. Inténtalo nuevamente.';

      default:
        return 'Ocurrió un error inesperado. Inténtalo nuevamente.';
    }
  }
}

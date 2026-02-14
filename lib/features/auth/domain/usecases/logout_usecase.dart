import 'package:challenge_evertec/features/auth/domain/repositories/auth_repository.dart';

class LogoutUseCase {

  LogoutUseCase(this.repository);
  final AuthRepository repository;

  Future<void> call() {
    return repository.logout();
  }
}

import 'package:challenge_evertec/features/auth/domain/repositories/auth_repository.dart';
import 'package:challenge_evertec/features/auth/domain/entities/user_entity.dart';

class LoginUseCase {

  LoginUseCase(this.repository);
  final AuthRepository repository;

  Future<UserEntity> call(String email, String password) {
    return repository.login(email, password);
  }
}

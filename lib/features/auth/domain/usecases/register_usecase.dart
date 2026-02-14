import 'package:challenge_evertec/features/auth/domain/entities/user_entity.dart';
import 'package:challenge_evertec/features/auth/domain/repositories/auth_repository.dart';

class RegisterUseCase {

  RegisterUseCase(this.repository);
  final AuthRepository repository;

  Future<UserEntity> call({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String phone,
  }) {
    return repository.register(
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
      phone: phone,
    );
  }
}

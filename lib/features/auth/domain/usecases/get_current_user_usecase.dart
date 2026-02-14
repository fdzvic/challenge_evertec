import 'package:challenge_evertec/features/auth/domain/entities/user_entity.dart';
import 'package:challenge_evertec/features/auth/domain/repositories/auth_repository.dart';

class GetCurrentUserUseCase {

  GetCurrentUserUseCase(this.repository);
  final AuthRepository repository;

  Future<UserEntity?> call() {
    return repository.getCurrentUser();
  }
}

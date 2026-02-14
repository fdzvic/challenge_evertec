import 'package:challenge_evertec/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> login(String email, String password);
  Future<UserEntity> register({
  required String email,
  required String password,
  required String firstName,
  required String lastName,
  required String phone,
});
  Future<void> logout();
  Future<UserEntity?> getCurrentUser();
}

import 'package:challenge_evertec/features/profile/domain/entities/profile_entity.dart';
import 'package:challenge_evertec/features/profile/domain/repositories/profile_repository.dart';

class GetProfileUseCase {
  GetProfileUseCase(this.repository);
  final ProfileRepository repository;

  Future<ProfileEntity> call(String uid) {
    return repository.getProfile(uid);
  }
}

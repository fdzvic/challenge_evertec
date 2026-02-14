import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final FirebaseFirestore firestore;

  ProfileRepositoryImpl(this.firestore);

  @override
  Future<ProfileEntity> getProfile(String uid) async {
    final doc = await firestore.collection('users').doc(uid).get();

    final data = doc.data()!;

    return ProfileEntity(
      id: uid,
      firstName: data['firstName'] ?? '',
      lastName: data['lastName'] ?? '',
      email: data['email'] ?? '',
      phone: data['phone'] ?? '',
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final FirebaseFirestore firestore;

  AuthRepositoryImpl(this.remoteDataSource, this.firestore);

  @override
  Future<UserEntity> login(String email, String password) {
    return remoteDataSource.login(email, password);
  }

  @override
  Future<UserEntity> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String phone,
  }) async {
    final user = await remoteDataSource.register(email, password);

    await firestore.collection('users').doc(user.id).set({
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'email': email,
      'createdAt': FieldValue.serverTimestamp(),
    });

    return user;
  }

  @override
  Future<void> logout() {
    return remoteDataSource.logout();
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    return remoteDataSource.getCurrentUser();
  }
}

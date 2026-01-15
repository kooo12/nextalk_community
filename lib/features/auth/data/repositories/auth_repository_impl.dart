import 'package:firebase_auth/firebase_auth.dart';
import 'package:nextalk_community/core/error/exceptions.dart';
import 'package:nextalk_community/core/error/failures.dart';
import 'package:nextalk_community/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:nextalk_community/features/auth/domain/entities/user_entity.dart';
import 'package:nextalk_community/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<UserEntity> signInWithEmailAndPassword(String email, String password) {
    try {
      return remoteDataSource.signInWithEmailAndPassword(email, password);
    } on AuthException catch (e) {
      throw AuthFailure(e.message);
    } catch (e) {
      throw AuthFailure('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<UserEntity> signUpWithEmailAndPassword(
      String email, String password, String username) {
    try {
      return remoteDataSource.signUpWithEmailAndPassword(
          email, password, username);
    } on AuthException catch (e) {
      throw AuthFailure(e.message);
    } catch (e) {
      throw AuthFailure('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<UserEntity> signInWithGoogle() async {
    try {
      return await remoteDataSource.signInWithGoogle();
    } on AuthException catch (e) {
      throw AuthFailure(e.message);
    } catch (e) {
      throw AuthFailure('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await remoteDataSource.signOut();
    } on AuthException catch (e) {
      throw AuthFailure(e.message);
    } catch (e) {
      throw AuthFailure('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    try {
      return await remoteDataSource.getCurrentUser();
    } on AuthException catch (e) {
      throw AuthFailure(e.message);
    } catch (e) {
      return null;
    }
  }

  @override
  Stream<User?> get authStateChanges => remoteDataSource.authStateChanges;
}

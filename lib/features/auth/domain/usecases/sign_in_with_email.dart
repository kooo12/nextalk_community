import 'package:nextalk_community/features/auth/domain/entities/user_entity.dart';
import 'package:nextalk_community/features/auth/domain/repositories/auth_repository.dart';

class SignInWithEmail {
  final AuthRepository repository;

  SignInWithEmail(this.repository);

  Future<UserEntity> call(String email, String password) {
    return repository.signInWithEmailAndPassword(email, password);
  }
}

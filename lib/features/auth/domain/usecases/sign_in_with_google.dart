import 'package:nextalk_community/features/auth/domain/entities/user_entity.dart';
import 'package:nextalk_community/features/auth/domain/repositories/auth_repository.dart';

class SignInWithGoogle {
  AuthRepository repository;
  SignInWithGoogle(this.repository);

  Future<UserEntity> call() {
    return repository.signInWithGoogle();
  }
}

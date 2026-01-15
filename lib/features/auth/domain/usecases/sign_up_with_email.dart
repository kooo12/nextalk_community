import 'package:nextalk_community/features/auth/domain/entities/user_entity.dart';
import 'package:nextalk_community/features/auth/domain/repositories/auth_repository.dart';

class SignUpWithEmail {
  final AuthRepository repository;
  SignUpWithEmail(this.repository);

  Future<UserEntity> call(String email, String password, String username) {
    return repository.signUpWithEmailAndPassword(email, password, username);
  }
}

import 'package:nextalk_community/features/auth/domain/repositories/auth_repository.dart';

class SignOut {
  AuthRepository repository;
  SignOut(this.repository);

  Future<void> call() {
    return repository.signOut();
  }
}

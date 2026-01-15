import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nextalk_community/core/providers/firebase_providers.dart';
import 'package:nextalk_community/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:nextalk_community/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:nextalk_community/features/auth/domain/usecases/sign_in_with_email.dart';
import 'package:nextalk_community/features/auth/domain/usecases/sign_in_with_google.dart';
import 'package:nextalk_community/features/auth/domain/usecases/sign_out.dart';
import 'package:nextalk_community/features/auth/domain/usecases/sign_up_with_email.dart';
import 'package:nextalk_community/features/auth/presentation/controllers/auth_controller.dart';

final googleSignInProvider = Provider((ref) {
  return GoogleSignIn();
});

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((Ref ref) {
  return AuthRemoteDataSourceImpl(
      firebaseAuth: ref.watch(firebaseAuthProvider),
      firestore: ref.watch(firestoreProvider),
      googleSignIn: ref.watch(googleSignInProvider));
});

final authRepositoryProvider = Provider<AuthRepositoryImpl>((Ref ref) {
  return AuthRepositoryImpl(
      remoteDataSource: ref.watch(authRemoteDataSourceProvider));
});

final signInWithEmailProvider = Provider((Ref ref) {
  return SignInWithEmail(ref.watch(authRepositoryProvider));
});

final signUpWithEmailProvider = Provider<SignUpWithEmail>((ref) {
  return SignUpWithEmail(ref.watch(authRepositoryProvider));
});

final signInWithGoogleProvider = Provider<SignInWithGoogle>((ref) {
  return SignInWithGoogle(ref.watch(authRepositoryProvider));
});

final signOutProvider = Provider<SignOut>((ref) {
  return SignOut(ref.watch(authRepositoryProvider));
});

final authControllerProvider =
    StateNotifierProvider<AuthController, AuthState>((Ref ref) {
  return AuthController(
      signInWithEmail: ref.watch(signInWithEmailProvider),
      signInWithGoogle: ref.watch(signInWithGoogleProvider),
      signUpWithEmail: ref.watch(signUpWithEmailProvider),
      signOut: ref.watch(signOutProvider),
      authRepository: ref.watch(authRepositoryProvider));
});

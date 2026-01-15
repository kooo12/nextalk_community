import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/sign_in_with_email.dart';
import '../../domain/usecases/sign_up_with_email.dart';
import '../../domain/usecases/sign_in_with_google.dart';
import '../../domain/usecases/sign_out.dart';
import '../../../../core/error/failures.dart';

class AuthState {
  final AsyncValue<UserEntity?> user;
  final bool isLoading;

  const AuthState({
    required this.user,
    this.isLoading = false,
  });

  AuthState copyWith({
    AsyncValue<UserEntity?>? user,
    bool? isLoading,
  }) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class AuthController extends StateNotifier<AuthState> {
  final SignInWithEmail signInWithEmail;
  final SignUpWithEmail signUpWithEmail;
  final SignInWithGoogle signInWithGoogle;
  final SignOut signOut;
  final AuthRepository authRepository;
  StreamSubscription<User?>? _authStateSubscription;

  AuthController({
    required this.signInWithEmail,
    required this.signUpWithEmail,
    required this.signInWithGoogle,
    required this.signOut,
    required this.authRepository,
  }) : super(const AuthState(user: AsyncValue.loading())) {
    _init();
  }

  void _init() {
    // Listen to auth state changes
    _authStateSubscription = authRepository.authStateChanges.listen(
      (firebaseUser) async {
        if (firebaseUser == null) {
          state = state.copyWith(user: const AsyncValue.data(null));
        } else {
          // Load user from Firestore
          try {
            state = state.copyWith(user: const AsyncValue.loading());
            final user = await authRepository.getCurrentUser();
            state = state.copyWith(user: AsyncValue.data(user));
          } catch (e, stack) {
            state = state.copyWith(
              user: AsyncValue.error(e, stack),
            );
          }
        }
      },
      onError: (error, stack) {
        state = state.copyWith(
          user: AsyncValue.error(error, stack),
        );
      },
    );
  }

  @override
  void dispose() {
    _authStateSubscription?.cancel();
    super.dispose();
  }

  Future<void> signInEmail(String email, String password) async {
    state = state.copyWith(
      user: const AsyncValue.loading(),
      isLoading: true,
    );

    try {
      final user = await signInWithEmail(email, password);
      state = state.copyWith(
        user: AsyncValue.data(user),
        isLoading: false,
      );
    } on AuthFailure catch (e) {
      state = state.copyWith(
        user: AsyncValue.error(e, StackTrace.current),
        isLoading: false,
      );
      rethrow;
    } catch (e, stack) {
      state = state.copyWith(
        user: AsyncValue.error(e, stack),
        isLoading: false,
      );
      rethrow;
    }
  }

  Future<void> signUpEmail(
      String email, String password, String username) async {
    state = state.copyWith(
      user: const AsyncValue.loading(),
      isLoading: true,
    );

    try {
      final user = await signUpWithEmail(email, password, username);
      state = state.copyWith(
        user: AsyncValue.data(user),
        isLoading: false,
      );
    } on ValidationFailure catch (e) {
      state = state.copyWith(
        user: AsyncValue.error(e, StackTrace.current),
        isLoading: false,
      );
      rethrow;
    } on AuthFailure catch (e) {
      state = state.copyWith(
        user: AsyncValue.error(e, StackTrace.current),
        isLoading: false,
      );
      rethrow;
    } catch (e, stack) {
      state = state.copyWith(
        user: AsyncValue.error(e, stack),
        isLoading: false,
      );
      rethrow;
    }
  }

  Future<void> signInGoogle() async {
    state = state.copyWith(
      user: const AsyncValue.loading(),
      isLoading: true,
    );

    try {
      final user = await signInWithGoogle();
      state = state.copyWith(
        user: AsyncValue.data(user),
        isLoading: false,
      );
    } on AuthFailure catch (e) {
      state = state.copyWith(
        user: AsyncValue.error(e, StackTrace.current),
        isLoading: false,
      );
      rethrow;
    } catch (e, stack) {
      state = state.copyWith(
        user: AsyncValue.error(e, stack),
        isLoading: false,
      );
      rethrow;
    }
  }

  Future<void> signOutUser() async {
    state = state.copyWith(isLoading: true);
    try {
      await signOut();
      state = state.copyWith(
        user: const AsyncValue.data(null),
        isLoading: false,
      );
    } catch (e, stack) {
      state = state.copyWith(
        user: AsyncValue.error(e, stack),
        isLoading: false,
      );
      rethrow;
    }
  }
}

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nextalk_community/core/error/failures.dart';
import 'package:nextalk_community/features/auth/domain/entities/user_entity.dart';
import 'package:nextalk_community/features/auth/domain/repositories/auth_repository.dart';
import 'package:nextalk_community/features/auth/domain/usecases/sign_in_with_email.dart';
import 'package:nextalk_community/features/auth/domain/usecases/sign_in_with_google.dart';
import 'package:nextalk_community/features/auth/domain/usecases/sign_up_with_email.dart';
import 'package:nextalk_community/features/auth/domain/usecases/sign_out.dart';

class AuthState {
  final AsyncValue<UserEntity?> user;
  final bool isLoading;
  final String? errorMessage;

  const AuthState({
    required this.user,
    this.isLoading = false,
    this.errorMessage,
  });

  AuthState copyWith({
    AsyncValue<UserEntity?>? user,
    bool? isLoading,
    String? errorMessage,
  }) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class AuthController extends StateNotifier<AuthState> {
  final SignInWithEmail signInWithEmail;
  final SignInWithGoogle signInWithGoogle;
  final SignUpWithEmail signUpWithEmail;
  final SignOut signOut;
  final AuthRepository authRepository;
  StreamSubscription<User?>? _authStateSubscription;

  AuthController({
    required this.signInWithEmail,
    required this.signInWithGoogle,
    required this.signUpWithEmail,
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
                user: AsyncValue.error(e, stack), errorMessage: e.toString());
          }
        }
      },
      onError: (error, stack) {
        state = state.copyWith(
            user: AsyncValue.error(error, stack),
            errorMessage: error.toString());
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
        isLoading: true, user: const AsyncValue.loading(), errorMessage: null);
    try {
      final user = await signInWithEmail(email, password);
      state = state.copyWith(user: AsyncValue.data(user), isLoading: false);
    } on AuthFailure catch (e) {
      state = state.copyWith(
        user: AsyncValue.error(e, StackTrace.current),
        isLoading: false,
        errorMessage: e.message,
      );
      rethrow;
    } catch (e, stack) {
      state = state.copyWith(
          isLoading: false,
          user: AsyncValue.error(e, stack),
          errorMessage: e.toString());
      rethrow;
    }
  }

  Future<void> signUpEmail(
      String email, String password, String username) async {
    state = state.copyWith(
      user: const AsyncValue.loading(),
      isLoading: true,
      errorMessage: null,
    );

    try {
      final user = await signUpWithEmail(email, password, username);
      state = state.copyWith(
        user: AsyncValue.data(user),
        isLoading: false,
        errorMessage: null,
      );
    } on ValidationFailure catch (e) {
      state = state.copyWith(
        user: AsyncValue.error(e, StackTrace.current),
        isLoading: false,
        errorMessage: e.message,
      );
      rethrow;
    } on AuthFailure catch (e) {
      state = state.copyWith(
        user: AsyncValue.error(e, StackTrace.current),
        isLoading: false,
        errorMessage: e.message,
      );
      rethrow;
    } catch (e, stack) {
      state = state.copyWith(
        user: AsyncValue.error(e, stack),
        isLoading: false,
        errorMessage: e.toString(),
      );
      rethrow;
    }
  }

  Future<void> signInGoogle() async {
    state = state.copyWith(
      user: const AsyncValue.loading(),
      isLoading: true,
      errorMessage: null,
    );

    try {
      final user = await signInWithGoogle();
      state = state.copyWith(
        user: AsyncValue.data(user),
        isLoading: false,
        errorMessage: null,
      );
    } on AuthFailure catch (e) {
      state = state.copyWith(
        user: AsyncValue.error(e, StackTrace.current),
        isLoading: false,
        errorMessage: e.message,
      );
      rethrow;
    } catch (e, stack) {
      state = state.copyWith(
        user: AsyncValue.error(e, stack),
        isLoading: false,
        errorMessage: e.toString(),
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
        errorMessage: e.toString(),
      );
      rethrow;
    }
  }
}

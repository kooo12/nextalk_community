import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nextalk_community/core/providers/firebase_providers.dart';
import 'package:nextalk_community/features/auth/presentation/screens/login_screen.dart';
import 'package:nextalk_community/features/auth/presentation/screens/signup_screen.dart';
import 'package:nextalk_community/features/home/home.dart';

final routerProvider = Provider<GoRouter>((Ref ref) {
  final authStream = ref.watch(firebaseAuthProvider).authStateChanges();
  final refreshNotifier = GoRouterRefreshStream(authStream);

  final router = GoRouter(
      initialLocation: '/login',
      debugLogDiagnostics: true,
      refreshListenable: refreshNotifier,
      redirect: (context, state) {
        final currentUser = ref.read(currentUserProvider);
        final user = currentUser.value;
        final isLoggedIn = user != null;
        final isGoingToLogin = state.matchedLocation == '/login' ||
            state.matchedLocation == '/signup';

        // If not logged in and trying to access protected route
        if (!isLoggedIn && !isGoingToLogin) {
          return '/login';
        }

        // If logged in and trying to access auth routes
        if (isLoggedIn && isGoingToLogin) {
          return '/home';
        }

        return null;
      },
      routes: [
        // Auth routes
        GoRoute(
          path: '/login',
          name: 'login',
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(opacity: animation, child: child),
            child: const LoginScreen(),
          ),
        ),
        GoRoute(
          path: '/signup',
          name: 'signup',
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(opacity: animation, child: child),
            child: const SignUpScreen(),
          ),
        ),

        // Main app routes
        GoRoute(
          path: '/home',
          name: 'home',
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(opacity: animation, child: child),
            child: const HomeScreen(),
          ),
        ),
      ]);
  // Listen to auth state changes and refresh router
  ref.listen(currentUserProvider, (previous, next) {
    if (previous?.value != next.value) {
      router.refresh();
    }
  });

  return router;
});

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<User?> stream) {
    _subscription = stream.listen((_) => notifyListeners());
  }

  late final StreamSubscription<User?> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

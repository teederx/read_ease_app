import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_ease_app/pages/auth/signin/signin_page.dart';
import 'package:read_ease_app/pages/auth/signup/signup_page.dart';
import 'package:read_ease_app/pages/content/change_password/change_password.dart';
import 'package:read_ease_app/pages/content/main_page/main_page.dart';
import 'package:read_ease_app/pages/content/settings/settings_page.dart';
import 'package:read_ease_app/pages/firebase_error_page.dart';
import 'package:read_ease_app/pages/splash_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../pages/auth/reset_password/reset_password_page.dart';
import '../pages/widget/page_not_found.dart';
import '../repositories/auth_repository_provider.dart';
import 'route.dart';

part 'router_provider.g.dart';

@riverpod
GoRouter router(Ref ref) {
  final authState = ref.watch(authStateStreamProvider);
  return GoRouter(
    initialLocation: RoutePaths.splash,
    redirect: (context, state) {
      if (authState is AsyncError<User?>) {
        return RoutePaths.firebaseError;
      }
      final authenticated = authState.valueOrNull != null;
      if(authenticated) {
        return RoutePaths.main;
      }
      if(!authenticated && state.matchedLocation == RoutePaths.main){
        RoutePaths.signin;
      }
      return null;
    },
    routes: [
      GoRoute(
        path: RoutePaths.splash,
        name: RouteNames.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: RoutePaths.firebaseError,
        name: RouteNames.firebaseError,
        builder: (context, state) => const FirebaseErrorPage(),
      ),
      GoRoute(
        path: RoutePaths.signin,
        name: RouteNames.signin,
        builder: (context, state) => const SigninPage(),
      ),
      GoRoute(
        path: RoutePaths.signup,
        name: RouteNames.signup,
        builder: (context, state) => const SignupPage(),
      ),
      GoRoute(
        path: RoutePaths.resetPassword,
        name: RouteNames.resetPassword,
        builder: (context, state) => const ResetPasswordPage(),
      ),
      GoRoute(
        path: RoutePaths.main,
        name: RouteNames.main,
        builder: (context, state) => const MainPage(),
        routes: [
          GoRoute(
            path: RoutePaths.settings,
            name: RouteNames.settings,
            builder: (context, state) => const SettingsPage(),
          ),
          GoRoute(
            path: RoutePaths.changePassword,
            name: RouteNames.changePassword,
            builder: (context, state) => const ChangePassword(),
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => PageNotFound(
      errorMessage: state.error.toString(),
    ),
  );
}

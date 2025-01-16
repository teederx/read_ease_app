import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_ease_app/features/books/presentation/auth/pages/signin_page.dart';
import 'package:read_ease_app/features/books/presentation/content/pages/change_password.dart';
import 'package:read_ease_app/features/books/presentation/content/pages/edit_book_page.dart';
import 'package:read_ease_app/features/books/presentation/content/pages/settings_page.dart';
import 'package:read_ease_app/core/firebase_error_page.dart';
import 'package:read_ease_app/features/books/presentation/splash_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/books/data/models/book/book.dart';
import '../../features/books/data/repositories/auth_repository/auth_repository_provider.dart';
import '../../features/books/presentation/auth/pages/reset_password_page.dart';
import '../../features/books/presentation/auth/pages/signup_page.dart';
import '../../features/books/presentation/content/pages/add_new_book.dart';
import '../../features/books/presentation/content/pages/edit_notes_page.dart';
import '../../features/books/presentation/content/pages/main_page.dart';
import '../../features/books/presentation/content/pages/view_book_page.dart';
import '../../features/books/presentation/page_not_found.dart';
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
      if (authenticated) {
        if (state.matchedLocation == RoutePaths.signin ||
            state.matchedLocation == RoutePaths.signup) {
          return RoutePaths.main;
        }
      }
      if (!authenticated && state.matchedLocation == RoutePaths.main) {
        return RoutePaths.signin;
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
          GoRoute(
            path: RoutePaths.addNewBook,
            name: RouteNames.addNewBook,
            builder: (context, state) => const AddNewBook(),
          ),
          GoRoute(
            path: RoutePaths.editBook,
            name: RouteNames.editBook,
            builder: (context, state) {
              final book = state.extra as Book;
              return EditBookPage(
                book: book,
              );
            },
          ),
          GoRoute(
            path: RoutePaths.editNotes,
            name: RouteNames.editNotes,
            builder: (context, state) {
              final notes = state.extra as String;
              return EditNotesPage(
                notes: notes,
              );
            },
          ),
          GoRoute(
            path: RoutePaths.viewBook,
            name: RouteNames.viewBook,
            builder: (context, state) {
              final book = state.extra as Book;
              return ViewBookPage(
                book: book,
              );
            },
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => PageNotFound(
      errorMessage: state.error.toString(),
    ),
  );
}

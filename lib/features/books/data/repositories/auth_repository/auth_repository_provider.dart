import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../core/constants/firebase_constants.dart';
import '../profile_repository/profile_repository_provider.dart';
import 'auth_repository.dart';

part 'auth_repository_provider.g.dart';

@riverpod
AuthRepository authRepository(Ref ref) {
  final profileRepository = ref.read(profileRepositoryProvider);
  return AuthRepository(profileRepository);
}

@riverpod
Stream<User?> authStateStream(Ref ref) {
  return fbAuth.authStateChanges();
}
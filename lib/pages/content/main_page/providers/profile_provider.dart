import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_ease_app/models/app_user.dart';
import 'package:read_ease_app/repositories/profile_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_provider.g.dart';

@riverpod
FutureOr<AppUser> profile(Ref ref, String uid) {
  return ref.watch(profileRepositoryProvider).getProfile(uid: uid);
}
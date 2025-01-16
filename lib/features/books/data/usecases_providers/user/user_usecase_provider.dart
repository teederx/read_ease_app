import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_ease_app/features/books/data/repositories/user_repository/user_repo_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/usecases/user_useCase.dart';

part 'user_usecase_provider.g.dart';

@riverpod
UserUsecase userUsecase(Ref ref) {
  // ignore: avoid_manual_providers_as_generated_provider_dependency
  final userRepository = ref.read(userRepoProvider);
  return UserUsecase(userRepository);
}
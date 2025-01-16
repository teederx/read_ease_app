import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/repositories/auth_repository_provider.dart';
import '../../../domain/usecases/auth_usecase.dart';

part 'auth_use_case_provider.g.dart';

@riverpod
AuthUseCase authUseCase(Ref ref) {
  final authRepository = ref.read(authRepositoryProvider);
  return AuthUseCase(authRepository);
}
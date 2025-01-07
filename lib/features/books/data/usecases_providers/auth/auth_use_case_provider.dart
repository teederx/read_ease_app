import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/usecases/auth_usecase.dart';
import '../../repositories/auth_repository/auth_repository_provider.dart';

part 'auth_use_case_provider.g.dart';

@riverpod
AuthUseCase authUseCase(Ref ref) {
  final authRepository = ref.read(authRepositoryProvider);
  return AuthUseCase(authRepository);
}
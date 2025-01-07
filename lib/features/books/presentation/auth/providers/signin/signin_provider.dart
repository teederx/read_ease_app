import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../auth_use_case_provider.dart';

part 'signin_provider.g.dart';

@riverpod
class Signin extends _$Signin {
  Object? _key;

  @override
  FutureOr<void> build() {
    _key = Object();
    ref.onDispose(() {
      print('[signinProvider] disposed');
      _key = null;
    });
  }

  Future<void> signin({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();

    final key = _key;

    // ignore: avoid_manual_providers_as_generated_provider_dependency
    final authUseCase = ref.read(authUseCaseProvider);

    try {
      await authUseCase.signIn(email, password);
      if (key == _key) {
        state = const AsyncData(null);
      }
    } catch (e, st) {
      if (key == _key) {
        state = AsyncError(e, st);
      }
    }
  }
}
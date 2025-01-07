import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../auth_use_case_provider.dart';

part 'signup_provider.g.dart';

@riverpod
class Signup extends _$Signup {
  Object? _key;

  @override
  FutureOr<void> build() {
    _key = Object();
    ref.onDispose(() {
      print('[signupProvider] disposed');
      _key = null;
    });
  }

  Future<void> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading<void>();
    final key = _key;

    // ignore: avoid_manual_providers_as_generated_provider_dependency
    final authUseCase = ref.read(authUseCaseProvider);

    try {
      await authUseCase.signUp(name, email, password);
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
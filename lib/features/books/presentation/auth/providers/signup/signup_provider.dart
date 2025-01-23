import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../data/usecases_providers/auth/auth_use_case_provider.dart';
import '../../../../data/usecases_providers/user/user_usecase_provider.dart';

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

    final authUseCase = ref.read(authUseCaseProvider);
    final userUseCase = ref.read(userUsecaseProvider);

    try {
      await authUseCase.signUp(name, email, password);
      final user = authUseCase.currentUser;
      if (user != null) {
        await userUseCase.syncProfileToLocalDatabase();
      }
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

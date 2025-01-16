import 'package:read_ease_app/features/books/data/usecases_providers/user/user_usecase_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../data/usecases_providers/auth/auth_use_case_provider.dart';

 

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

    
    final authUseCase = ref.read(authUseCaseProvider);
    final userUseCase = ref.read(userUsecaseProvider);

    try {
      await authUseCase.signIn(email, password);
      final user = authUseCase.currentUser;
      if(user!= null){
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
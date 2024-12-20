import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../repositories/auth_repository_provider.dart';

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

    final newState = await AsyncValue.guard(
      () => ref.read(authRepositoryProvider).signUp(
            name: name,
            email: email,
            password: password,
          ),
    );

    if (key == _key) {
      state = newState;
      //State is not updated when the provider is disposed of...
      //When key = null, it means the provider is disposed of, hence, the state is not updated and the page changes with no error
      //but if key = Object, then the state is being updated meaning the provider has not been disposed of
    }
  }
}
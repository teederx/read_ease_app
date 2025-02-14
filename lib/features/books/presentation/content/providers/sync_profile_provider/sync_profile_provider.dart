import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../data/usecases_providers/auth/auth_use_case_provider.dart';

part 'sync_profile_provider.g.dart';

@riverpod
class SyncProfile extends _$SyncProfile {
  Object? _key;

  @override
  FutureOr<void> build() {
    _key = Object();
    ref.onDispose(() {
      print('[signinProvider] disposed');
      _key = null;
    });
  }

  Future<void> syncProfileToCloud() async {
    state = const AsyncLoading();

    final key = _key;

    
    final authUseCase = ref.read(authUseCaseProvider);

    try {
      await authUseCase.syncProfileToCloud();
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
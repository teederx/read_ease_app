import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../src/local_source/local_data_source_provider.dart';
import '../profile_repository/profile_repository_provider.dart';
import 'user_repo.dart';

part 'user_repo_provider.g.dart';

@riverpod
UserRepo userRepo(Ref ref) {
  final localDataSource = ref.read(localDataSourceProvider);
  final profileRepository = ref.read(profileRepositoryProvider);
  return UserRepo(localDataSource, profileRepository);
}
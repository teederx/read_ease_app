import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../src/local_source/local_data_source_provider.dart';
import 'profile_repository.dart';

part 'profile_repository_provider.g.dart';

@riverpod
ProfileRepository profileRepository(Ref ref) {
  final localDataSource = ref.read(localDataSourceProvider);
  return ProfileRepository(localDataSource);
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

<<<<<<<< HEAD:lib/features/books/data/repositories/profile_repository/profile_repository_provider.dart
import '../../src/local_source/local_data_source_provider.dart';
========
>>>>>>>> d5135a4ed65a6288121dbe2788f34407538e9bcf:lib/features/books/data/repositories/profile_repository_provider.dart
import 'profile_repository.dart';

part 'profile_repository_provider.g.dart';

@riverpod
ProfileRepository profileRepository(Ref ref) {
  final localDataSource = ref.read(localDataSourceProvider);
  return ProfileRepository(localDataSource);
}

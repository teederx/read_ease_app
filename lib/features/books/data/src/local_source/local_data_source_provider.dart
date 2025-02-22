import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'local_data_source.dart';

part 'local_data_source_provider.g.dart';

@riverpod
LocalDataSource localDataSource(Ref ref) {
  return LocalDataSource();
}
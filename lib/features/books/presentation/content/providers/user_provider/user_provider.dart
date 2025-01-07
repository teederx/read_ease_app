import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_ease_app/features/books/data/usecases_providers/user/user_usecase_provider.dart';
import 'package:read_ease_app/features/books/domain/entities/user_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';


part 'user_provider.g.dart';



@riverpod
UserEntity? user(Ref ref, String uid) {
  return ref.watch(userUsecaseProvider).getUser(id: uid);
}

@riverpod
Future<void> deleteUser(Ref ref, String uid) async {
  return await ref.watch(userUsecaseProvider).deleteUser(id: uid);
}

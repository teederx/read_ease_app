import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../book/book.dart';

part 'app_user.freezed.dart';
part 'app_user.g.dart';

@freezed
class AppUser with _$AppUser {
  @HiveType(typeId: 0)
  // To call toJson for nested objects as well
  @JsonSerializable(explicitToJson: true)
  const factory AppUser({
    @HiveField(0) @Default('') String userID,
    @HiveField(1) @Default('') String name,
    @HiveField(2) @Default('') String email,
    @HiveField(3) required List<Book> books,
  }) = _AppUser;

  factory AppUser.fromDoc(DocumentSnapshot appUserDoc) {
    final appUserData = appUserDoc.data() as Map<String, dynamic>;

    return AppUser(
      userID: appUserDoc.id,
      name: appUserData['name'] ?? '',
      email: appUserData['email'] ?? '',
      books: (appUserData['books'] as List<dynamic>)
          .map((book) => Book.fromJson(book as Map<String, dynamic>))
          .toList(),
    );
  }

  factory AppUser.fromJson(Map<String, dynamic> json) => _$AppUserFromJson(json);
}


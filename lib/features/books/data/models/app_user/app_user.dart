import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'app_user.freezed.dart';
part 'app_user.g.dart';

@freezed
class AppUser with _$AppUser {
  // To call toJson for nested objects as well
  @JsonSerializable(explicitToJson: true)
  const factory AppUser({
    @Default('') String userID,
    @Default('') String name,
    @Default('') String email,
    required List<Book> books,
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

@freezed
class Book with _$Book {
  @JsonSerializable(createToJson: true)
  const factory Book({
    @Default('') String bookID,
    @Default('') String imageURL,
    @Default('') String title,
    @Default('') String desc,
    @Default('') String notes,
    @Default(false) bool isFavorite,
  }) = _Book;

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);
}
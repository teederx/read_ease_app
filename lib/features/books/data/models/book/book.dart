import 'package:flutter_quill/quill_delta.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

part 'book.freezed.dart';
part 'book.g.dart';

Uuid uuid = const Uuid();

@freezed
class Book with _$Book {
  @HiveType(typeId: 1)
  @JsonSerializable(createToJson: true)
  const factory Book({
    @HiveField(0) @Default('') String bookID,
    @HiveField(1) @Default('') String imageURL,
    @HiveField(2) @Default('') String title,
    @HiveField(3) @Default('') String desc,
    @HiveField(4) @Default('') String notes,
    @HiveField(5) @Default(false) bool isFavorite,
    @HiveField(6) @Default('') String author,
    @HiveField(7) @Default(false) bool isCompleted,
  }) = _Book;

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);

  factory Book.add({
    required String imageURL,
    required String author,
    required String title,
    required String desc,
    required Delta notes,
  }) =>
      Book(
        bookID: uuid.v4(),
        imageURL: imageURL,
        author: author,
        title: title,
        desc: desc,
        notes: notes.toJson().toString(),
      );
}


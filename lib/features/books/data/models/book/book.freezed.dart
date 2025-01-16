// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'book.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Book _$BookFromJson(Map<String, dynamic> json) {
  return _Book.fromJson(json);
}

/// @nodoc
mixin _$Book {
  @HiveField(0)
  String get bookID => throw _privateConstructorUsedError;
  @HiveField(1)
  String get imageURL => throw _privateConstructorUsedError;
  @HiveField(2)
  String get title => throw _privateConstructorUsedError;
  @HiveField(3)
  String get desc => throw _privateConstructorUsedError;
  @HiveField(4)
  String get notes => throw _privateConstructorUsedError;
  @HiveField(5)
  bool get isFavorite => throw _privateConstructorUsedError;
  @HiveField(6)
  String get author => throw _privateConstructorUsedError;

  /// Serializes this Book to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Book
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BookCopyWith<Book> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookCopyWith<$Res> {
  factory $BookCopyWith(Book value, $Res Function(Book) then) =
      _$BookCopyWithImpl<$Res, Book>;
  @useResult
  $Res call(
      {@HiveField(0) String bookID,
      @HiveField(1) String imageURL,
      @HiveField(2) String title,
      @HiveField(3) String desc,
      @HiveField(4) String notes,
      @HiveField(5) bool isFavorite,
      @HiveField(6) String author});
}

/// @nodoc
class _$BookCopyWithImpl<$Res, $Val extends Book>
    implements $BookCopyWith<$Res> {
  _$BookCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Book
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bookID = null,
    Object? imageURL = null,
    Object? title = null,
    Object? desc = null,
    Object? notes = null,
    Object? isFavorite = null,
    Object? author = null,
  }) {
    return _then(_value.copyWith(
      bookID: null == bookID
          ? _value.bookID
          : bookID // ignore: cast_nullable_to_non_nullable
              as String,
      imageURL: null == imageURL
          ? _value.imageURL
          : imageURL // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      desc: null == desc
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String,
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String,
      isFavorite: null == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BookImplCopyWith<$Res> implements $BookCopyWith<$Res> {
  factory _$$BookImplCopyWith(
          _$BookImpl value, $Res Function(_$BookImpl) then) =
      __$$BookImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String bookID,
      @HiveField(1) String imageURL,
      @HiveField(2) String title,
      @HiveField(3) String desc,
      @HiveField(4) String notes,
      @HiveField(5) bool isFavorite,
      @HiveField(6) String author});
}

/// @nodoc
class __$$BookImplCopyWithImpl<$Res>
    extends _$BookCopyWithImpl<$Res, _$BookImpl>
    implements _$$BookImplCopyWith<$Res> {
  __$$BookImplCopyWithImpl(_$BookImpl _value, $Res Function(_$BookImpl) _then)
      : super(_value, _then);

  /// Create a copy of Book
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bookID = null,
    Object? imageURL = null,
    Object? title = null,
    Object? desc = null,
    Object? notes = null,
    Object? isFavorite = null,
    Object? author = null,
  }) {
    return _then(_$BookImpl(
      bookID: null == bookID
          ? _value.bookID
          : bookID // ignore: cast_nullable_to_non_nullable
              as String,
      imageURL: null == imageURL
          ? _value.imageURL
          : imageURL // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      desc: null == desc
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String,
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String,
      isFavorite: null == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@HiveType(typeId: 1)
@JsonSerializable(createToJson: true)
class _$BookImpl implements _Book {
  const _$BookImpl(
      {@HiveField(0) this.bookID = '',
      @HiveField(1) this.imageURL = '',
      @HiveField(2) this.title = '',
      @HiveField(3) this.desc = '',
      @HiveField(4) this.notes = '',
      @HiveField(5) this.isFavorite = false,
      @HiveField(6) this.author = ''});

  factory _$BookImpl.fromJson(Map<String, dynamic> json) =>
      _$$BookImplFromJson(json);

  @override
  @JsonKey()
  @HiveField(0)
  final String bookID;
  @override
  @JsonKey()
  @HiveField(1)
  final String imageURL;
  @override
  @JsonKey()
  @HiveField(2)
  final String title;
  @override
  @JsonKey()
  @HiveField(3)
  final String desc;
  @override
  @JsonKey()
  @HiveField(4)
  final String notes;
  @override
  @JsonKey()
  @HiveField(5)
  final bool isFavorite;
  @override
  @JsonKey()
  @HiveField(6)
  final String author;

  @override
  String toString() {
    return 'Book(bookID: $bookID, imageURL: $imageURL, title: $title, desc: $desc, notes: $notes, isFavorite: $isFavorite, author: $author)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookImpl &&
            (identical(other.bookID, bookID) || other.bookID == bookID) &&
            (identical(other.imageURL, imageURL) ||
                other.imageURL == imageURL) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.desc, desc) || other.desc == desc) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.isFavorite, isFavorite) ||
                other.isFavorite == isFavorite) &&
            (identical(other.author, author) || other.author == author));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, bookID, imageURL, title, desc, notes, isFavorite, author);

  /// Create a copy of Book
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BookImplCopyWith<_$BookImpl> get copyWith =>
      __$$BookImplCopyWithImpl<_$BookImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BookImplToJson(
      this,
    );
  }
}

abstract class _Book implements Book {
  const factory _Book(
      {@HiveField(0) final String bookID,
      @HiveField(1) final String imageURL,
      @HiveField(2) final String title,
      @HiveField(3) final String desc,
      @HiveField(4) final String notes,
      @HiveField(5) final bool isFavorite,
      @HiveField(6) final String author}) = _$BookImpl;

  factory _Book.fromJson(Map<String, dynamic> json) = _$BookImpl.fromJson;

  @override
  @HiveField(0)
  String get bookID;
  @override
  @HiveField(1)
  String get imageURL;
  @override
  @HiveField(2)
  String get title;
  @override
  @HiveField(3)
  String get desc;
  @override
  @HiveField(4)
  String get notes;
  @override
  @HiveField(5)
  bool get isFavorite;
  @override
  @HiveField(6)
  String get author;

  /// Create a copy of Book
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookImplCopyWith<_$BookImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

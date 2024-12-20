// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppUserImpl _$$AppUserImplFromJson(Map<String, dynamic> json) =>
    _$AppUserImpl(
      userID: json['userID'] as String? ?? '',
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      books: (json['books'] as List<dynamic>)
          .map((e) => Book.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$AppUserImplToJson(_$AppUserImpl instance) =>
    <String, dynamic>{
      'userID': instance.userID,
      'name': instance.name,
      'email': instance.email,
      'books': instance.books.map((e) => e.toJson()).toList(),
    };

_$BookImpl _$$BookImplFromJson(Map<String, dynamic> json) => _$BookImpl(
      bookID: json['bookID'] as String? ?? '',
      imageURL: json['imageURL'] as String? ?? '',
      title: json['title'] as String? ?? '',
      desc: json['desc'] as String? ?? '',
      notes: json['notes'] as String? ?? '',
      startDate: json['startDate'] as String? ?? '',
      isFavorite: json['isFavorite'] as bool? ?? false,
    );

Map<String, dynamic> _$$BookImplToJson(_$BookImpl instance) =>
    <String, dynamic>{
      'bookID': instance.bookID,
      'imageURL': instance.imageURL,
      'title': instance.title,
      'desc': instance.desc,
      'notes': instance.notes,
      'startDate': instance.startDate,
      'isFavorite': instance.isFavorite,
    };

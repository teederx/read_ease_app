// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppUserImplAdapter extends TypeAdapter<_$AppUserImpl> {
  @override
  final int typeId = 0;

  @override
  _$AppUserImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$AppUserImpl(
      userID: fields[0] as String,
      name: fields[1] as String,
      email: fields[2] as String,
      books: (fields[3] as List).cast<Book>(),
    );
  }

  @override
  void write(BinaryWriter writer, _$AppUserImpl obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.userID)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.books);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppUserImplAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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

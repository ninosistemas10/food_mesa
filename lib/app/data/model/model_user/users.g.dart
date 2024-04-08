// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Users _$UsersFromJson(Map<String, dynamic> json) => Users(
      id: json['id'] as String,
      nombre: json['nombre'] as String?,
      email: json['email'] as String,
      password: json['password'] as String,
      isAdmin: json['isAdmin'] as bool?,
      images: json['images'] == null
          ? null
          : Details.fromJson(json['images'] as Map<String, dynamic>),
      details: json['details'] == null
          ? null
          : Details.fromJson(json['details'] as Map<String, dynamic>),
      createdAt: json['createdAt'] as int?,
      updatedAt: json['updatedAt'] as int?,
    );

Map<String, dynamic> _$UsersToJson(Users instance) => <String, dynamic>{
      'id': instance.id,
      'nombre': instance.nombre,
      'email': instance.email,
      'password': instance.password,
      'isAdmin': instance.isAdmin,
      'images': instance.images?.toJson(),
      'details': instance.details?.toJson(),
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

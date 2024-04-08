// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataUser _$DataUserFromJson(Map<String, dynamic> json) => DataUser(
      token: json['token'] as String,
      user: Users.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataUserToJson(DataUser instance) => <String, dynamic>{
      'token': instance.token,
      'user': instance.user.toJson(),
    };

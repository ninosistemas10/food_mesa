// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_users.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelUsers _$ModelUsersFromJson(Map<String, dynamic> json) => ModelUsers(
      data: DataUser.fromJson(json['data'] as Map<String, dynamic>),
      errors: json['errors'],
      messages: (json['messages'] as List<dynamic>)
          .map((e) => Messages.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ModelUsersToJson(ModelUsers instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
      'errors': instance.errors,
      'messages': instance.messages.map((e) => e.toJson()).toList(),
    };

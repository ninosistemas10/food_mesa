// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelCategory _$ModelCategoryFromJson(Map<String, dynamic> json) =>
    ModelCategory(
      data: (json['data'] as List<dynamic>)
          .map((e) => CategoryData.fromJson(e as Map<String, dynamic>))
          .toList(),
      errors: json['errors'] as String?,
      messages: (json['messages'] as List<dynamic>)
          .map((e) => Messages.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ModelCategoryToJson(ModelCategory instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
      'errors': instance.errors,
      'messages': instance.messages.map((e) => e.toJson()).toList(),
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_promocion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelPromocion _$ModelPromocionFromJson(Map<String, dynamic> json) =>
    ModelPromocion(
      data: (json['data'] as List<dynamic>)
          .map((e) => PromocionData.fromJson(e as Map<String, dynamic>))
          .toList(),
      errors: json['errors'] as String?,
      messages: (json['messages'] as List<dynamic>)
          .map((e) => Messages.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ModelPromocionToJson(ModelPromocion instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
      'errors': instance.errors,
      'messages': instance.messages.map((e) => e.toJson()).toList(),
    };

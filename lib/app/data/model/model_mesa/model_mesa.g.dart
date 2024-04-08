// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_mesa.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelMesa _$ModelMesaFromJson(Map<String, dynamic> json) => ModelMesa(
      data: (json['data'] as List<dynamic>)
          .map((e) => MesaData.fromJson(e as Map<String, dynamic>))
          .toList(),
      errors: json['errors'],
      messages: (json['messages'] as List<dynamic>)
          .map((e) => Messages.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ModelMesaToJson(ModelMesa instance) => <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
      'errors': instance.errors,
      'messages': instance.messages.map((e) => e.toJson()).toList(),
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_categoria_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubCategoriaModel _$SubCategoriaModelFromJson(Map<String, dynamic> json) =>
    SubCategoriaModel(
      data: (json['data'] as List<dynamic>)
          .map((e) => SubCategoriaData.fromJson(e as Map<String, dynamic>))
          .toList(),
      errors: json['errors'],
      messages: (json['messages'] as List<dynamic>)
          .map((e) => Messages.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SubCategoriaModelToJson(SubCategoriaModel instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
      'errors': instance.errors,
      'messages': instance.messages.map((e) => e.toJson()).toList(),
    };

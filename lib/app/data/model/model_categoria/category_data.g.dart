// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryData _$CategoryDataFromJson(Map<String, dynamic> json) => CategoryData(
      id: json['id'] as String?,
      nombre: json['nombre'] as String,
      description: json['description'] as String?,
      images: json['images'] as String?,
      activo: json['activo'] as bool,
      createdAt: json['createdAt'] as int?,
      updateAt: json['updateAt'] as int?,
    );

Map<String, dynamic> _$CategoryDataToJson(CategoryData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nombre': instance.nombre,
      'description': instance.description,
      'images': instance.images,
      'activo': instance.activo,
      'createdAt': instance.createdAt,
      'updateAt': instance.updateAt,
    };

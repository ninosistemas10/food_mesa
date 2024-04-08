// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mmesa_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MesaData _$MesaDataFromJson(Map<String, dynamic> json) => MesaData(
      id: json['id'] as String?,
      nombre: json['nombre'] as String,
      url: json['url'] as String,
      images: json['images'] as String?,
      activo: json['activo'] as bool,
      createdAt: json['createdAt'] as int?,
      updatedAt: json['updatedAt'] as int?,
    );

Map<String, dynamic> _$MesaDataToJson(MesaData instance) => <String, dynamic>{
      'id': instance.id,
      'nombre': instance.nombre,
      'url': instance.url,
      'images': instance.images,
      'activo': instance.activo,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promocion_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PromocionData _$PromocionDataFromJson(Map<String, dynamic> json) =>
    PromocionData(
        id: json['id'] as String,
        nombre: json['nombre'] as String,
        description: json['description'] as String?,
        image: json['image'] as String?,
        precio: (json['precio'] as num).toDouble(),
        features: json['features'] as Map<String, dynamic>?,
        activo: json['activo'] as bool,
        created: json['created'] as int,
        updated: json['updated'] as int?,
    );

Map<String, dynamic> _$PromocionDataToJson(PromocionData instance) =>
    <String, dynamic>{
        'id': instance.id,
        'nombre': instance.nombre,
        'description': instance.description,
        'image': instance.image,
        'precio': instance.precio,
        'features': instance.features,
        'activo': instance.activo,
        'created': instance.created,
        'updated': instance.updated,
    };  

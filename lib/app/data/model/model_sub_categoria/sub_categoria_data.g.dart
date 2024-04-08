// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_categoria_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubCategoriaData _$SubCategoriaDataFromJson(Map<String, dynamic> json) =>
    SubCategoriaData(
      id: json['id'] as String?,
      idcategoria: json['idCategoria'] as String,
      nombre: json['nombre'] as String,
      precio: (json['precio'] as num?)?.toDouble(),
      imagen: json['imagen'] as String?,
      descripcion: json['descripcion'] as String?,
      time: json['time'] as String?,
      calorias: (json['calorias'] as num?)?.toDouble(),
      activo: json['activo'] as bool,
      createdAt: json['createdAt'] as int?,
      updatedAt: json['updatedAt'] as int?,
    );

Map<String, dynamic> _$SubCategoriaDataToJson(SubCategoriaData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'idCategoria': instance.idcategoria,
      'nombre': instance.nombre,
      'precio': instance.precio,
      'imagen': instance.imagen,
      'descripcion': instance.descripcion,
      'activo': instance.activo,
      'time': instance.time,
      'calorias': instance.calorias,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

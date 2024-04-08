
import 'package:json_annotation/json_annotation.dart';

part 'sub_categoria_data.g.dart';

@JsonSerializable(explicitToJson: true)
class SubCategoriaData {
  String? id;
  String idcategoria;  
  String nombre;
  double? precio;
  String? imagen;  
  String? descripcion;
  bool activo;
  String? time;
  double? calorias;
  int? createdAt;
  int? updatedAt;

  SubCategoriaData({
    this.id,
    required this.idcategoria,
    required this.nombre,
    this.precio,
    this.imagen,
    this.descripcion,
    this.time,
    this.calorias,
    required this.activo,
    this.createdAt,
    this.updatedAt,
  });

  factory SubCategoriaData.fromJson(Map<String, dynamic> data) => _$SubCategoriaDataFromJson(data);

  Map<String, dynamic> toJson() => _$SubCategoriaDataToJson(this);
}

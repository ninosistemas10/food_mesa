
import 'dart:typed_data';

import 'package:json_annotation/json_annotation.dart';
part 'promocion_data.g.dart';

@JsonSerializable(explicitToJson: true)
class PromocionData {
    String id;
    String nombre;
    String? description;
    String? image;
    double precio;
    Map<String, dynamic>? features;
    bool activo;
    int created;
    int? updated;

    PromocionData({
        required this.id,
        required this.nombre,
        this.description,
        this.image,
        required this.precio,
        this.features,
        required this.activo,
        required this.created,
        this.updated
    });

    factory PromocionData.fromJson(Map<String, dynamic> data) => _$PromocionDataFromJson(data);
    Map<String, dynamic> toJson() => _$PromocionDataToJson(this);
}
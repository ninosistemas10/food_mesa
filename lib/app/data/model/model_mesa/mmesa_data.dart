import 'package:json_annotation/json_annotation.dart';
part 'mmesa_data.g.dart';

@JsonSerializable(explicitToJson: true)

class MesaData{
    String? id;
    String nombre;
    String url;
    String? images;
    bool activo;
    int? createdAt;
    int? updatedAt;
    
    MesaData({
        this.id,
        required this.nombre,
        required this.url,
        this.images,
        required this.activo,
        this.createdAt,
        this.updatedAt
    });
    factory MesaData.fromJson(Map<String, dynamic> data) => _$MesaDataFromJson(data);
    Map<String, dynamic> toJson() => _$MesaDataToJson(this);
}
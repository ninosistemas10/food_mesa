import 'package:json_annotation/json_annotation.dart';
part 'category_data.g.dart';



@JsonSerializable(explicitToJson: true)
class CategoryData {
    String? id;
    String nombre;
    String? description;
    String? images;
    bool  activo;
    int? createdAt;
    int? updateAt;

    CategoryData({
        this.id,
        required this.nombre,
        this.description,
        this.images,
        required this.activo,
        this.createdAt,
        this.updateAt
    });



    factory CategoryData.fromJson(Map<String, dynamic> data) => _$CategoryDataFromJson(data);
    Map<String, dynamic> toJson() => _$CategoryDataToJson(this);
}


import 'package:dashboard_bloc/app/data/model/model_categoria/message.dart';
import 'package:dashboard_bloc/app/data/model/model_sub_categoria/sub_categoria_data.dart';
import 'package:json_annotation/json_annotation.dart';
part 'sub_categoria_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SubCategoriaModel {
    List<SubCategoriaData> data;
    dynamic errors;
    List<Messages> messages;

    SubCategoriaModel ({
        required this.data,
        required this.errors,
        required this.messages,
    });

    factory SubCategoriaModel.fromJson(Map<String, dynamic> data) => _$SubCategoriaModelFromJson(data);
    Map<String, dynamic> toJson() => _$SubCategoriaModelToJson(this);
}
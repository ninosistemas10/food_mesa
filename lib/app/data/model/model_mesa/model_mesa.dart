
import 'package:dashboard_bloc/app/data/model/model_mesa/message.dart';
import 'package:dashboard_bloc/app/data/model/model_mesa/mmesa_data.dart';
import 'package:json_annotation/json_annotation.dart';
part 'model_mesa.g.dart';

@JsonSerializable(explicitToJson: true)

class ModelMesa{
    List<MesaData> data;
    dynamic errors;
    List<Messages> messages;

    ModelMesa({
        required this.data,
        required this.errors,
        required this.messages,
    });

    factory ModelMesa.fromJson(Map<String, dynamic> data) => _$ModelMesaFromJson(data);
    Map<String, dynamic> toJson() => _$ModelMesaToJson(this);
}
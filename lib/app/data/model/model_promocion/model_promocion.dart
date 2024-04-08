
import 'package:dashboard_bloc/app/data/model/model_categoria/message.dart';
import 'package:dashboard_bloc/app/data/model/model_promocion/promocion_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'model_promocion.g.dart';

@JsonSerializable(explicitToJson: true)
class ModelPromocion {
    List<PromocionData> data;
    String? errors;
    List<Messages> messages;

    ModelPromocion({ 
        required this.data, 
        this.errors, 
        required this.messages,
    });

    factory ModelPromocion.fromJson(Map<String, dynamic> data) => _$ModelPromocionFromJson(data);

    //set images(String images) {}

    Map<String, dynamic> toJson() => _$ModelPromocionToJson(this);
}



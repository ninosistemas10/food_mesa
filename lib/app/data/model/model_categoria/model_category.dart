
import 'package:dashboard_bloc/app/data/model/model_categoria/category_data.dart';
import 'package:dashboard_bloc/app/data/model/model_categoria/message.dart';
import 'package:json_annotation/json_annotation.dart';

part 'model_category.g.dart';

@JsonSerializable(explicitToJson: true)
class ModelCategory {
    List<CategoryData> data;
    String? errors;
    List<Messages> messages;

    

    ModelCategory({ 
        required this.data, 
        this.errors, 
        required this.messages,
    });

    factory ModelCategory.fromJson(Map<String, dynamic> data) => _$ModelCategoryFromJson(data);

  set images(String images) {}

    Map<String, dynamic> toJson() => _$ModelCategoryToJson(this);
}



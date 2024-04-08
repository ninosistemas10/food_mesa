import 'package:dashboard_bloc/app/data/model/model_user/data.dart';
import 'package:dashboard_bloc/app/data/model/model_user/message.dart';
import 'package:json_annotation/json_annotation.dart';

part 'model_users.g.dart';

@JsonSerializable(explicitToJson: true)
class ModelUsers {
    DataUser data;
    dynamic errors;
    List<Messages> messages;

    

    ModelUsers({ 
        required this.data, 
        required this.errors, 
        required this.messages,
    });

    factory ModelUsers.fromJson(Map<String, dynamic> data) => _$ModelUsersFromJson(data);

    Map<String, dynamic> toJson() => _$ModelUsersToJson(this);
}


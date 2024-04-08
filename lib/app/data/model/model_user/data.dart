import 'package:dashboard_bloc/app/data/model/model_user/users.dart';
import 'package:json_annotation/json_annotation.dart';

part 'data.g.dart';

@JsonSerializable(explicitToJson: true)
class DataUser {
    String token;
    Users user;

    DataUser({ 
        required this.token, 
        required this.user,
    });

    factory DataUser.fromJson(Map<String, dynamic> data) => _$DataUserFromJson(data);

    Map<String, dynamic> toJson() => _$DataUserToJson(this);

}
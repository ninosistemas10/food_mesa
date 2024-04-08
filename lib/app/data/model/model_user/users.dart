
import 'package:dashboard_bloc/app/data/model/model_user/details.dart';
import 'package:json_annotation/json_annotation.dart';
part 'users.g.dart';

@JsonSerializable(explicitToJson: true)
class Users{
    String id;
    String? nombre;
    String email;
    String password;
    bool? isAdmin;
    Details? images;
    Details? details;
    int? createdAt;
    int? updatedAt;

    Users({
        required this.id,
        this.nombre,
        required this.email,
        required this.password,
        this.isAdmin,
        this.images,
        this.details,
        this.createdAt,
        this.updatedAt

    });
    factory Users.fromJson(Map<String, dynamic> data) => _$UsersFromJson(data);
    Map<String, dynamic> toJson() => _$UsersToJson(this);

}


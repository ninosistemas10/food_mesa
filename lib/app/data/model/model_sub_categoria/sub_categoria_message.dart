
import 'package:json_annotation/json_annotation.dart';
part 'sub_categoria_message.g.dart';

@JsonSerializable(explicitToJson: true)
class Messages{
    String code;
    String message;
    Messages ({
        required this.code,
        required this.message
    });

    factory Messages.fromJson(Map<String, dynamic> data) => _$MessagesFromJson(data);
    Map<String, dynamic> toJson() => _$MessagesToJson(this);
}


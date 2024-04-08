import 'package:json_annotation/json_annotation.dart';
part 'details.g.dart';

@JsonSerializable(explicitToJson: true) 
class Details {
    String? details;
    

    Details({
        this.details,
    });

    factory Details.fromJson(Map<String, dynamic> data) => _$DetailsFromJson(data);

    Map<String, dynamic> toJson() => _$DetailsToJson(this);

}
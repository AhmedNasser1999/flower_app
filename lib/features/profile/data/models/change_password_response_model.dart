import 'package:json_annotation/json_annotation.dart';

part 'change_password_response_model.g.dart';

@JsonSerializable()
class ChangePasswordResponseModel {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "token")
  final String token;

  ChangePasswordResponseModel({
    this.message,
    required this.token,
  });

  factory ChangePasswordResponseModel.fromJson(Map<String, dynamic> json) {
    return _$ChangePasswordResponseModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ChangePasswordResponseModelToJson(this);
  }
}

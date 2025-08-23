import 'package:json_annotation/json_annotation.dart';

part 'reset_password_request_model.g.dart';

@JsonSerializable()
class ResetPasswordRequestModel {
  @JsonKey(name: "email")
  final String email;
  @JsonKey(name: "newPassword")
  final String newPassword;

  ResetPasswordRequestModel ({
    required this.email,
    required this.newPassword,
  });

  factory ResetPasswordRequestModel.fromJson(Map<String, dynamic> json) {
    return _$ResetPasswordRequestModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ResetPasswordRequestModelToJson(this);
  }
}



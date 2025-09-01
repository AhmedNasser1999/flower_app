import 'package:json_annotation/json_annotation.dart';

part 'change_password_request_model.g.dart';

@JsonSerializable()
class ChangePasswordRequestModel {
  @JsonKey(name: "password")
  final String? password;
  @JsonKey(name: "newPassword")
  final String? newPassword;

  ChangePasswordRequestModel ({
    this.password,
    this.newPassword,
  });

  factory ChangePasswordRequestModel.fromJson(Map<String, dynamic> json) {
    return _$ChangePasswordRequestModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ChangePasswordRequestModelToJson(this);
  }
}



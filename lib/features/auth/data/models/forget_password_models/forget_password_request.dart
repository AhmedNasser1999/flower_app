import 'package:json_annotation/json_annotation.dart';

part 'forget_password_request.g.dart';

@JsonSerializable()
class ForgetPasswordRequestModel {
  @JsonKey(name: "email")
  final String email;

  ForgetPasswordRequestModel ({
    required this.email,
  });

  factory ForgetPasswordRequestModel.fromJson(Map<String, dynamic> json) {
    return _$ForgetPasswordRequestModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ForgetPasswordRequestModelToJson(this);
  }
}



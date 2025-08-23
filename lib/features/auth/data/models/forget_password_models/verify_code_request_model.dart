import 'package:json_annotation/json_annotation.dart';

part 'verify_code_request_model.g.dart';

@JsonSerializable()
class VerifyCodeRequestModel {
  @JsonKey(name: "resetCode")
  final String resetCode;

  VerifyCodeRequestModel ({
    required this.resetCode,
  });

  factory VerifyCodeRequestModel.fromJson(Map<String, dynamic> json) {
    return _$VerifyCodeRequestModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$VerifyCodeRequestModelToJson(this);
  }
}



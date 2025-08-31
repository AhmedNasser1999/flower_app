import 'package:json_annotation/json_annotation.dart';

import '../../../auth/data/models/login_models/login_response_model.dart';

part 'profile_response.g.dart';

@JsonSerializable()
class ProfileResponse {
  @JsonKey(name: "message")
  final String message;
  @JsonKey(name: "user")
  final User user;

  ProfileResponse ({
    required this.message,
    required this.user,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return _$ProfileResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ProfileResponseToJson(this);
  }
}



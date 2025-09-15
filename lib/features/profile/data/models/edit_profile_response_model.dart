import 'package:json_annotation/json_annotation.dart';
import '../../../auth/data/models/login_models/user_model.dart';

part 'edit_profile_response_model.g.dart';

@JsonSerializable()
class EditProfileResponseModel {
  @JsonKey(name: "message")
  final String message;
  @JsonKey(name: "user")
  final User user;

  EditProfileResponseModel({
    required this.message,
    required this.user,
  });

  factory EditProfileResponseModel.fromJson(Map<String, dynamic> json) {
    return _$EditProfileResponseModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$EditProfileResponseModelToJson(this);
  }
}

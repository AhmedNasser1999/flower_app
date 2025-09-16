import 'package:json_annotation/json_annotation.dart';

part 'upload_photo_response.g.dart';

@JsonSerializable()
class UploadPhotoResponse {
  @JsonKey(name: "message")
  final String message;

  UploadPhotoResponse({
    required this.message,
  });

  factory UploadPhotoResponse.fromJson(Map<String, dynamic> json) {
    return _$UploadPhotoResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UploadPhotoResponseToJson(this);
  }
}

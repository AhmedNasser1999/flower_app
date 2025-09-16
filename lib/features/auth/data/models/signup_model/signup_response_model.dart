import 'package:json_annotation/json_annotation.dart';

part 'signup_response_model.g.dart';

@JsonSerializable()
class RegisterResponse {
  @JsonKey(name: "message")
  final String? message;

  @JsonKey(name: "user")
  final User? user;

  @JsonKey(name: "token")
  final String? token;

  RegisterResponse({
    this.message,
    this.user,
    this.token,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterResponseToJson(this);
}

@JsonSerializable()
class User {
  @JsonKey(name: "firstName")
  final String? firstName;

  @JsonKey(name: "lastName")
  final String? lastName;

  @JsonKey(name: "email")
  final String? email;

  @JsonKey(name: "gender")
  final String? gender;

  @JsonKey(name: "phone")
  final String? phone;

  @JsonKey(name: "photo")
  final String? photo;

  @JsonKey(name: "role")
  final String? role;

  @JsonKey(name: "wishlist")
  final List<dynamic>? wishlist;

  @JsonKey(name: "_id")
  final String? id;

  @JsonKey(name: "addresses")
  final List<dynamic>? addresses;

  @JsonKey(name: "createdAt")
  final String? createdAt;

  User({
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.phone,
    this.photo,
    this.role,
    this.wishlist,
    this.id,
    this.addresses,
    this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

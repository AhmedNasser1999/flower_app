// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      Id: json['_id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      gender: json['gender'] as String,
      phone: json['phone'] as String,
      photo: json['photo'] as String,
      role: json['role'] as String,
      wishlist: json['wishlist'] as List<dynamic>,
      addresses: json['addresses'] as List<dynamic>,
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      '_id': instance.Id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'gender': instance.gender,
      'phone': instance.phone,
      'photo': instance.photo,
      'role': instance.role,
      'wishlist': instance.wishlist,
      'addresses': instance.addresses,
      'createdAt': instance.createdAt,
    };

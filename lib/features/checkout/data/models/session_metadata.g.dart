// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionMetadata _$SessionMetadataFromJson(Map<String, dynamic> json) =>
    SessionMetadata(
      city: json['city'] as String?,
      lat: json['lat'] as String?,
      long: json['long'] as String?,
      phone: json['phone'] as String?,
      street: json['street'] as String?,
    );

Map<String, dynamic> _$SessionMetadataToJson(SessionMetadata instance) =>
    <String, dynamic>{
      'city': instance.city,
      'lat': instance.lat,
      'long': instance.long,
      'phone': instance.phone,
      'street': instance.street,
    };

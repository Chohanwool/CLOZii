// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_User _$UserFromJson(Map<String, dynamic> json) => _User(
  uid: json['uid'] as String,
  name: json['name'] as String,
  phoneNumber: json['phoneNumber'] as String,
  birthDate: json['birthDate'] == null
      ? null
      : DateTime.parse(json['birthDate'] as String),
  gender: json['gender'] as String?,
  isVerified: json['isVerified'] as bool? ?? false,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$UserToJson(_User instance) => <String, dynamic>{
  'uid': instance.uid,
  'name': instance.name,
  'phoneNumber': instance.phoneNumber,
  'birthDate': instance.birthDate?.toIso8601String(),
  'gender': instance.gender,
  'isVerified': instance.isVerified,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
};

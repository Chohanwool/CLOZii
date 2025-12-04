// User model for data layer
// Data Layer: JSON 직렬화를 담당하는 모델

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:clozii/features/auth/domain/entities/user.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
sealed class UserModel with _$UserModel {
  const UserModel._();

  factory UserModel({
    required String uid,
    required String name,
    required String phoneNumber,
    DateTime? birthDate,
    String? gender,
    @Default(false) bool isVerified,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _UserModel;

  // JSON 직렬화 (freezed가 자동 생성)
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  // Domain Entity → Data Model 변환 (수동 작성)
  factory UserModel.fromEntity(User entity) {
    return UserModel(
      uid: entity.uid,
      name: entity.name,
      phoneNumber: entity.phoneNumber,
      birthDate: entity.birthDate,
      gender: entity.gender,
      isVerified: entity.isVerified,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  User toEntity() {
    return User(
      uid: uid,
      name: name,
      phoneNumber: phoneNumber,
      birthDate: birthDate,
      gender: gender,
      isVerified: isVerified,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

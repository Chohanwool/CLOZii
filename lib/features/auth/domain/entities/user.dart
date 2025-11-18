// User entity for auth_sample

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
sealed class User with _$User {
  const factory User({
    required String uid,
    required String name,
    required String phoneNumber,
    DateTime? birthDate,
    String? gender,
    @Default(false) bool isVerified,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _User;

  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);
}

// User entity for auth_sample
// Domain Layer: 순수한 비즈니스 엔티티 (외부 패키지 의존 없음)

class User {
  final String uid;
  final String name;
  final String phoneNumber;
  final DateTime? birthDate;
  final String? gender;
  final bool isVerified;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const User({
    required this.uid,
    required this.name,
    required this.phoneNumber,
    this.birthDate,
    this.gender,
    this.isVerified = false,
    required this.createdAt,
    this.updatedAt,
  });

  // toString (디버깅용 - 현재 verify_otp_code.dart:45에서 사용 중)
  @override
  String toString() {
    return 'User(uid: $uid, name: $name, phoneNumber: $phoneNumber, '
        'birthDate: $birthDate, gender: $gender, isVerified: $isVerified, '
        'createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

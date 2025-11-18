// User entity for auth_sample
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

  User copyWith({
    String? uid,
    String? name,
    String? phoneNumber,
    DateTime? birthDate,
    String? gender,
    bool? isVerified,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return User(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      birthDate: birthDate ?? this.birthDate,
      gender: gender ?? this.gender,
      isVerified: isVerified ?? this.isVerified,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is User && other.uid == uid;
  }

  @override
  int get hashCode => uid.hashCode;

  @override
  String toString() {
    return 'User(id: $uid, name: $name, phoneNumber: $phoneNumber, name: $name, birthDate: $birthDate, gender: $gender, createdAt: $createdAt, updatedAt: $updatedAt, isVerified: $isVerified)';
  }
}

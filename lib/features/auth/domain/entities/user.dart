// User entity for auth_sample
class User {
  final String id;
  final String name;
  final String phoneNumber;
  final DateTime? birthDate;
  final String? gender;
  final bool isVerified;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const User({
    required this.id,
    required this.name,
    required this.phoneNumber,
    this.birthDate,
    this.gender,
    this.isVerified = false,
    required this.createdAt,
    this.updatedAt,
  });

  User copyWith({
    String? id,
    String? name,
    String? phoneNumber,
    DateTime? birthDate,
    String? gender,
    bool? isVerified,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return User(
      id: id ?? this.id,
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
    return other is User && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'User(id: $id, name: $name, phoneNumber: $phoneNumber, isVerified: $isVerified)';
  }
}

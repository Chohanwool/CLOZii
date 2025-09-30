class ValidationRules {
  // 전화번호 검증
  static bool isValidPhoneNumber(String phone) {
    final cleanNumber = phone.replaceAll(RegExp(r'[^\d]'), '');
    return cleanNumber.length == 11 && cleanNumber.startsWith('09');
  }

  // 이름 검증
  static bool isValidName(String name) {
    final trimmedName = name.trim();
    return trimmedName.length >= 2 &&
        trimmedName.length <= 50 &&
        RegExp(r'^[a-zA-Z\s]+$').hasMatch(trimmedName);
  }

  // 생년월일 검증 (13세 이상)
  static bool isValidAge(DateTime birthDate) {
    final now = DateTime.now();
    final age = now.year - birthDate.year;
    final monthDiff = now.month - birthDate.month;
    final dayDiff = now.day - birthDate.day;

    if (monthDiff < 0 || (monthDiff == 0 && dayDiff < 0)) {
      return age - 1 >= 13;
    }
    return age >= 13;
  }

  // 인증번호 검증
  static bool isValidVerificationCode(String code) {
    return RegExp(r'^\d{6}$').hasMatch(code);
  }

  // 성별 검증
  static bool isValidGender(String? gender) {
    return gender != null && ['Male', 'Female', 'Other'].contains(gender);
  }
}

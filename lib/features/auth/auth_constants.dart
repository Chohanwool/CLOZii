import 'package:clozii/features/auth/core/enum/auth_step.dart';

class AuthConstants {
  static const int phoneNumberMaxLength = 11;
  static const String phoneNumberPrefix = '+639';

  // 헤더 텍스트 상수
  static const Map<AuthStep, String> headerTexts = {
    AuthStep.phoneSignup: 'Sign Up with phone number.',
    AuthStep.phoneLogin: 'Login with phone number.',
    AuthStep.name: 'What should we call you?',
    AuthStep.birthdate: 'We need your birthdate to verify your age.',
    AuthStep.gender: 'This helps us personalize your experience.',
  };

  // 인증 관련
  static const int verificationCodeLength = 6;
  static const int verificationCodeExpiryMinutes = 5;
  static const int maxVerificationAttempts = 3;

  // 폼 검증 관련
  static const int minNameLength = 2;
  static const int maxNameLength = 50;
  static const int minAge = 13;
  static const int maxAge = 120;

  // 에러 메시지
  static const String phoneAlreadyRegistered =
      'This phone number is already registered. Try signing in.';
  static const String invalidPhoneNumber = 'Please enter a valid phone number.';
  static const String invalidName = 'Please enter a valid name.';
  static const String invalidAge =
      'You must be at least 13 years old to sign up.';
  static const String verificationCodeExpired =
      'Verification code has expired.';
  static const String invalidVerificationCode = 'Invalid verification code.';
  static const String maxAttemptsReached =
      'Maximum verification attempts reached.';

  // 성공 메시지
  static const String verificationCodeSent =
      'Verification code sent successfully.';
  static const String signUpSuccess = 'Account created successfully.';
  static const String signInSuccess = 'Signed in successfully.';
}

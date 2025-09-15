// 상수로 분리
import 'package:clozii/features/auth/data/auth_step.dart';

const int phoneNumberMaxLength = 11;
const String phoneNumberPrefix = '+639';

// 헤더 텍스트 상수
const Map<AuthStep, String> headerTexts = {
  AuthStep.phoneSignup: 'Sign Up with phone number.',
  AuthStep.phoneLogin: 'Login with phone number.',
  AuthStep.name: 'What should we call you?',
  AuthStep.birthdate: 'We need your birthdate to verify your age.',
  AuthStep.gender: 'This helps us personalize your experience.',
};

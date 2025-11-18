import 'package:clozii/features/auth/auth_constants.dart';
import 'package:clozii/features/auth/core/enum/auth_step.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_state.freezed.dart';

@freezed
class SignUpState with _$SignUpState {
  const SignUpState._();

  const factory SignUpState({
    @Default(AuthStep.phoneSignup) AuthStep currentStep,
    @Default('') String phoneNumber,
    @Default('') String name,
    String? birthDate,
    String? gender,
    @Default(false) bool isLoading,
    String? errorMessage,
    @Default(false) bool isSuccess,
    @Default(false) bool showTermsAndAgree,

    // 인증번호 관련
    String? verificationId,
    int? resendToken,

    // 약관동의 관련
    @Default(false) bool isAllAgreed, // 전체 동의
    @Default(false) bool isTermAgreed, // 이용약관
    @Default(false) bool isPrivacyPolicyAgreed, // 개인정보 약관
    @Default(false) bool isLocationPolicyAgreed, // 위치정보
    @Default(false) bool isAgeVerified, // 연령 확인
    @Default(false) bool isMarketingAgreed, // 마켓 수신 동의
    @Default(false) bool isThirdPartyAgreed, // 제3자 서비스(파이어베이스 등) 데이터 공유
    @Default(false) bool isPushAgreed, // 푸시 노티피케이션 동의
  }) = _SignUpState;

  String get formattedPhoneNumber =>
      '${AuthConstants.phoneNumberPrefix}${phoneNumber.replaceAll('-', '').replaceFirst('09', '')}';

  String get stepTitle => _getStepTitle(currentStep);

  String _getStepTitle(AuthStep step) {
    switch (step) {
      case AuthStep.phoneSignup:
        return "What is your phone number?";
      case AuthStep.name:
        return "What should we call you?";
      case AuthStep.birthdate:
        return "When is your birthday?";
      case AuthStep.gender:
        return "What is your gender?";
      case AuthStep.phoneLogin:
        return "Enter your phone number";
    }
  }

  // 유효성 검사
  bool get isPhoneValid => phoneNumber.length == 11;
  bool get isNameValid => name.trim().isNotEmpty;
  bool get isBirthDateValid => birthDate != null;
  bool get isGenderValid => gender != null && gender!.isNotEmpty;

  // 현재 단계별 유효성 검사
  bool get isCurrentStepValid {
    switch (currentStep) {
      case AuthStep.phoneSignup:
        return isPhoneValid;
      case AuthStep.name:
        return isNameValid;
      case AuthStep.birthdate:
        return isBirthDateValid;
      case AuthStep.gender:
        return isGenderValid;
      case AuthStep.phoneLogin:
        return isPhoneValid;
    }
  }

  // 전체 폼 유효성 검사
  bool get isFormValid =>
      isPhoneValid && isNameValid && isBirthDateValid && isGenderValid;
}

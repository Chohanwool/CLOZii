import 'package:clozii/features/auth/auth_constants.dart';
import 'package:clozii/features/auth/core/enum/auth_step.dart';

class SignUpState {
  final AuthStep currentStep;
  final String phoneNumber;
  final String name;
  final DateTime? birthDate;
  final String? gender;
  final bool isLoading;
  final String? errorMessage;
  final bool isSuccess;
  final bool showTermsAndAgree;

  // 인증번호 관련
  final String? verificationId;
  final int? resendToken;

  const SignUpState({
    this.currentStep = AuthStep.phoneSignup,
    this.phoneNumber = '',
    this.name = '',
    this.birthDate,
    this.gender,
    this.isLoading = false,
    this.errorMessage,
    this.isSuccess = false,
    this.showTermsAndAgree = false,
    this.verificationId,
    this.resendToken,
  });

  String get formattedPhoneNumber =>
      '${AuthConstants.phoneNumberPrefix}${phoneNumber.replaceAll('-', '').replaceFirst('09', '')}';

  SignUpState copyWith({
    AuthStep? currentStep,
    String? phoneNumber,
    String? name,
    DateTime? birthDate,
    String? gender,
    bool? isLoading,
    String? errorMessage,
    bool? isSuccess,
    bool? showTermsAndAgree,
    String? verificationId,
    int? resendToken,
  }) {
    return SignUpState(
      currentStep: currentStep ?? this.currentStep,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      name: name ?? this.name,
      birthDate: birthDate ?? this.birthDate,
      gender: gender ?? this.gender,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
      showTermsAndAgree: showTermsAndAgree ?? this.showTermsAndAgree,
      verificationId: verificationId ?? this.verificationId,
      resendToken: resendToken ?? this.resendToken,
    );
  }

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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SignUpState &&
        other.currentStep == currentStep &&
        other.phoneNumber == phoneNumber &&
        other.name == name &&
        other.birthDate == birthDate &&
        other.gender == gender &&
        other.isLoading == isLoading &&
        other.errorMessage == errorMessage &&
        other.isSuccess == isSuccess;
  }

  @override
  int get hashCode {
    return currentStep.hashCode ^
        phoneNumber.hashCode ^
        name.hashCode ^
        birthDate.hashCode ^
        gender.hashCode ^
        isLoading.hashCode ^
        errorMessage.hashCode ^
        isSuccess.hashCode;
  }

  @override
  String toString() {
    return 'SignUpState(currentStep: $currentStep, phoneNumber: $phoneNumber, name: $name, birthDate: $birthDate, gender: $gender, isLoading: $isLoading, errorMessage: $errorMessage, isSuccess: $isSuccess)';
  }
}

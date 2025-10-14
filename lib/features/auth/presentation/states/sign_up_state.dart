import 'package:clozii/features/auth/auth_constants.dart';
import 'package:clozii/features/auth/core/enum/agreement_type.dart';
import 'package:clozii/features/auth/core/enum/auth_step.dart';

class SignUpState {
  final AuthStep currentStep;
  final String phoneNumber;
  final String name;
  final String? birthDate;
  final String? gender;
  final bool isLoading;
  final String? errorMessage;
  final bool isSuccess;
  final bool showTermsAndAgree;

  // 인증번호 관련
  final String? verificationId;
  final int? resendToken;

  // 약관동의 관련
  final bool isAllAgreed; // 전체 동의
  final bool isTermAgreed; // 이용약관
  final bool isPrivacyPolicyAgreed; // 개인정보 약관
  final bool isLocationPolicyAgreed; // 위치정보
  final bool isAgeVerified; // 연령 확인
  final bool isMarketingAgreed; // 마켓 수신 동의
  final bool isThirdPartyAgreed; // 제3자 서비스(파이어베이스 등) 데이터 공유
  final bool isPushAgreed; // 푸시 노티피케이션 동의
  final AgreementType? pendingAgreementToOpen; // 약관 상세 대상 타입

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

    // 약관 동의 관련
    // 18세 이상 인증
    // - 제휴를 통해 통신사 조회 API를 쓰면 18세 이상 여부 확인 가능
    //   한국처럼 표준화된 API가 공개되어 있진 않고, 개별 통신사(Globe, Smart, DITO)와 계약해야 함
    // - SMS 인증으로 본인 번호 확인 → 추가로 신분증 사진 + 셀피 인증 요청
    //   Onfido, Jumio, ShuftiPro, SmileID 같은 외부 KYC 서비스가 API로 제공

    // 	•	서비스사가 법적으로 해야 할 건 “14세 미만 가입 불가”를 약관에 명시하고, 생년월일을 받는 절차 정도.
    // 	•	실제 나이 위변조는 사용자 책임이고, 서비스사는 면책됩니다.
    // 	•	그래서 당근마켓, 쿠팡, 네이버 등도 별도 나이 검증 절차 없이 SMS 인증만으로 운영합니다.

    // ✅ CLOZ 같은 글로벌 서비스도 필리핀 로컬 법률 기준으로:
    // 	•	가입 시 “만 18세 이상만 사용 가능”을 약관에 명시.
    // 	•	사용자 입력 + SMS 인증만으로 처리 → 실제 나이 확인은 안 하지만 법적 책임은 회피 가능.
    this.isAllAgreed = false,
    this.isTermAgreed = false,
    this.isPrivacyPolicyAgreed = false,
    this.isLocationPolicyAgreed = false,
    this.isAgeVerified = false,
    this.isMarketingAgreed = false,
    this.isThirdPartyAgreed = false,
    this.isPushAgreed = false,
    this.pendingAgreementToOpen,
  });

  String get formattedPhoneNumber =>
      '${AuthConstants.phoneNumberPrefix}${phoneNumber.replaceAll('-', '').replaceFirst('09', '')}';

  SignUpState copyWith({
    AuthStep? currentStep,
    String? phoneNumber,
    String? name,
    String? birthDate,
    String? gender,
    bool? isLoading,
    String? errorMessage,
    bool? isSuccess,
    bool? showTermsAndAgree,
    String? verificationId,
    int? resendToken,
    bool? isAllAgreed,
    bool? isTermAgreed,
    bool? isPrivacyPolicyAgreed,
    bool? isLocationPolicyAgreed,
    bool? isAgeVerified,
    bool? isMarketingAgreed,
    bool? isThirdPartyAgreed,
    bool? isPushAgreed,
    AgreementType? pendingAgreementToOpen,
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
      isAllAgreed: isAllAgreed ?? this.isAllAgreed,
      isTermAgreed: isTermAgreed ?? this.isTermAgreed,
      isPrivacyPolicyAgreed:
          isPrivacyPolicyAgreed ?? this.isPrivacyPolicyAgreed,
      isLocationPolicyAgreed:
          isLocationPolicyAgreed ?? this.isLocationPolicyAgreed,
      isAgeVerified: isAgeVerified ?? this.isAgeVerified,
      isMarketingAgreed: isMarketingAgreed ?? this.isMarketingAgreed,
      isThirdPartyAgreed: isThirdPartyAgreed ?? this.isThirdPartyAgreed,
      isPushAgreed: isPushAgreed ?? this.isPushAgreed,
      pendingAgreementToOpen:
          pendingAgreementToOpen ?? this.pendingAgreementToOpen,
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
        other.isSuccess == isSuccess &&
        other.showTermsAndAgree == showTermsAndAgree &&
        other.verificationId == verificationId &&
        other.resendToken == resendToken &&
        other.isAllAgreed == isAllAgreed &&
        other.isTermAgreed == isTermAgreed &&
        other.isPrivacyPolicyAgreed == isPrivacyPolicyAgreed &&
        other.isLocationPolicyAgreed == isLocationPolicyAgreed &&
        other.isAgeVerified == isAgeVerified &&
        other.isMarketingAgreed == isMarketingAgreed &&
        other.isThirdPartyAgreed == isThirdPartyAgreed &&
        other.isPushAgreed == isPushAgreed &&
        other.pendingAgreementToOpen == pendingAgreementToOpen;
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
        isSuccess.hashCode ^
        showTermsAndAgree.hashCode ^
        verificationId.hashCode ^
        resendToken.hashCode ^
        isAllAgreed.hashCode ^
        isTermAgreed.hashCode ^
        isPrivacyPolicyAgreed.hashCode ^
        isLocationPolicyAgreed.hashCode ^
        isAgeVerified.hashCode ^
        isMarketingAgreed.hashCode ^
        isThirdPartyAgreed.hashCode ^
        isPushAgreed.hashCode ^
        pendingAgreementToOpen.hashCode;
  }

  @override
  String toString() {
    return '''
SignUpState(
  currentStep: $currentStep,
  phoneNumber: $phoneNumber,
  name: $name,
  birthDate: $birthDate,
  gender: $gender,
  isLoading: $isLoading,
  errorMessage: $errorMessage,
  isSuccess: $isSuccess,
  showTermsAndAgree: $showTermsAndAgree,
  verificationId: $verificationId,
  resendToken: $resendToken,

  // 약관 동의 관련
  isAllAgreed: $isAllAgreed,
  isTermAgreed: $isTermAgreed,
  isPrivacyPolicyAgreed: $isPrivacyPolicyAgreed,
  isLocationPolicyAgreed: $isLocationPolicyAgreed,
  isAgeVerified: $isAgeVerified,
  isMarketingAgreed: $isMarketingAgreed,
  isThirdPartyAgreed: $isThirdPartyAgreed,
  isPushAgreed: $isPushAgreed
)
''';
  }
}

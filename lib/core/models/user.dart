class User {
  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.profileImageUrl,
    required this.birthDate,
    required this.gender,
    required this.consent,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final String profileImageUrl;
  final String birthDate;
  final String gender;

  // 약관 동의 정보
  final ConsentInfo consent;

  final String createdAt;
  final String updatedAt;
}

/// 약관 동의 정보
/// - 약관 동의 여부
/// - 마케팅 동의 여부
/// - 위치 동의 여부
/// - 18세 이상 동의 여부
class ConsentInfo {
  const ConsentInfo({
    required this.isTermsOfServiceAgreed,
    required this.isPrivacyPolicyAgreed,
    required this.isMarketingAgreed,
    required this.isLocationAgreed,
    required this.isOver18Agreed,
    required this.termsOfServiceAgreedAt,
    required this.privacyPolicyAgreedAt,
    required this.marketingAgsreedAt,
    required this.locationAgreedAt,
    required this.over18AgreedAt,
  });

  final bool isTermsOfServiceAgreed; // 서비스 이용 약관
  final bool isPrivacyPolicyAgreed; // 개인정보 수집 및 이용
  final bool isMarketingAgreed; // 마케팅 정보 수신 동의
  final bool isLocationAgreed; // 위치 정보 수집 및 이용
  final bool isOver18Agreed; // 18세 이상 동의

  final DateTime termsOfServiceAgreedAt;
  final DateTime privacyPolicyAgreedAt;
  final DateTime marketingAgsreedAt;
  final DateTime locationAgreedAt;
  final DateTime over18AgreedAt;
}

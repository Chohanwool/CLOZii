/// 인증 화면 모드
/// - signUp: 회원가입 (OTP 검증 + Firestore 저장)
/// - signIn: 로그인 (OTP 검증 + Firestore 조회)
enum VerificationMode {
  signUp,
  signIn,
}

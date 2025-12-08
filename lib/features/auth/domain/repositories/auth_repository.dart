import 'package:clozii/features/auth/domain/entities/auth_result.dart';
import 'package:clozii/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  // 전화번호 중복 확인
  Future<AuthResult<bool>> isPhoneRegistered(String phoneNumber);

  // 인증번호 전송
  Future<AuthResult<String>> sendVerificationCode(String phoneNumber);

  // 인증번호 검증 (uid, phoneNumber만 포함된 User 반환)
  Future<AuthResult<User>> verifyCode(String verificationId, String otpCode);

  // Firestore에 사용자 정보 저장
  Future<AuthResult<void>> saveUserToFirestore(User user);

  // Firestore에서 사용자 정보 조회
  Future<AuthResult<User>> getUserFromFirestore(String uid);

  // ✅ 추가: 현재 로그인된 유저 정보 가져오기
  Future<AuthResult<User>> getCurrentUser();

  // ✅ 추가: 현재 Firebase Auth 유저 삭제 (롤백용)
  Future<AuthResult<void>> deleteCurrentFirebaseUser();
}

import 'package:clozii/features/auth/domain/entities/auth_result.dart';
import 'package:clozii/features/auth/domain/entities/user.dart' as domain;
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  // 회원가입: 사용자 정보 저장
  Future<AuthResult<User>> signUp({
    required String name,
    required String phoneNumber,
    required DateTime birthDate,
    required String gender,
  });

  // 로그인
  Future<AuthResult<User>> signIn(String phoneNumber);

  // 로그아웃
  Future<AuthResult<User>> signOut();

  // 전화번호 중복 확인
  Future<AuthResult<bool>> isPhoneRegistered(String phoneNumber);

  // 인증번호 전송
  Future<AuthResult<String>> sendVerificationCode(String phoneNumber);

  // 인증번호 재전송
  Future<AuthResult<bool>> resendVerificationCode(String phoneNumber);

  // 인증번호 검증 및 회원가입
  Future<AuthResult<User>> verifyCode(String verificationId, String otpCode);

  // Firestore에 사용자 정보 저장
  Future<AuthResult<void>> saveUserToFirestore(domain.User user);
}

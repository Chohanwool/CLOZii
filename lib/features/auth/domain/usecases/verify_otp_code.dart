import 'package:clozii/features/auth/core/errors/auth_failures.dart';
import 'package:clozii/features/auth/domain/entities/auth_result.dart';
import 'package:clozii/features/auth/domain/repositories/auth_repository.dart';
import 'package:clozii/features/auth/domain/entities/user.dart';
import 'package:flutter/foundation.dart';

/// UseCase
class VerifyOtpCode {
  final AuthRepository _authRepository;

  VerifyOtpCode(this._authRepository);

  Future<AuthResult<User>> call(
    String verificationId,
    String otpCode,
    String name,
    String phoneNumber,
    DateTime birthDate,
    String gender,
  ) async {
    try {
      // 1. OTP 검증 (Firebase 연락처 자동 로그인 사용)
      final verifyResult = await _authRepository.verifyCode(
        verificationId,
        otpCode,
      );

      if (!verifyResult.isSuccess) {
        return AuthResult.failure(verifyResult.failure!);
      }

      final firebaseUser = verifyResult.data!; // Firebase User

      // 2. 회원가입 완료 (Firebase User → 도메인 User 변환)
      final domainUser = User(
        uid: firebaseUser.uid,
        phoneNumber: firebaseUser.phoneNumber!,
        name: name,
        birthDate: birthDate,
        gender: gender,
        createdAt: DateTime.now(),
      );

      debugPrint('====== verifyOtpCodeUsecase.call ======');
      debugPrint(domainUser.toString());
      debugPrint('====== verifyOtpCodeUsecase.call ======');

      // 3. Firestore에 사용자 정보 저장
      final saveResult = await _authRepository.saveUserToFirestore(domainUser);

      // Firestore 저장 실패 시 생성된 Firebase Auth 사용자 삭제 (롤백)
      if (!saveResult.isSuccess) {
        try {
          debugPrint('====== Firebase Auth 사용자 롤백 완료 ======');
          await firebaseUser.delete();
        } catch (deleteError) {
          debugPrint('====== Firebase Auth 사용자 삭제 실패: $deleteError ======');
        }
        return AuthResult.failure(saveResult.failure!);
      }

      return AuthResult.success(domainUser);
    } catch (e) {
      return AuthResult.failure(UnknownFailure(e.toString()));
    }
  }
}

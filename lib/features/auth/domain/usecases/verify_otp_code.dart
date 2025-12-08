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
    DateTime birthDate,
    String gender,
  ) async {
    try {
      // 1. OTP 검증 (uid, phoneNumber만 포함된 User 반환)
      final verifyResult = await _authRepository.verifyCode(
        verificationId,
        otpCode,
      );

      if (!verifyResult.isSuccess) {
        return AuthResult.failure(verifyResult.failure!);
      }

      final verifiedUser = verifyResult.data!; // domain.User (uid, phoneNumber만)

      // 2. 회원가입 완료 (추가 정보 포함한 완전한 User 생성)
      final domainUser = User(
        uid: verifiedUser.uid,
        phoneNumber: verifiedUser.phoneNumber,
        name: name,
        birthDate: birthDate,
        gender: gender,
        isVerified: true,  // OTP 검증 완료
        createdAt: DateTime.now(),
      );

      debugPrint('====== verifyOtpCodeUsecase.call ======');
      debugPrint(domainUser.toString());
      debugPrint('====== verifyOtpCodeUsecase.call ======');

      // 3. Firestore에 사용자 정보 저장
      final saveResult = await _authRepository.saveUserToFirestore(domainUser);

      // Firestore 저장 실패 시 생성된 Firebase Auth 사용자 삭제 (롤백)
      if (!saveResult.isSuccess) {
        await _authRepository.deleteCurrentFirebaseUser();
        return AuthResult.failure(saveResult.failure!);
      }

      return AuthResult.success(domainUser);
    } catch (e) {
      return AuthResult.failure(UnknownFailure(e.toString()));
    }
  }
}

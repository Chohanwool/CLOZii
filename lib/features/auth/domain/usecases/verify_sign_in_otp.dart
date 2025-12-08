import 'package:clozii/features/auth/core/errors/auth_failures.dart';
import 'package:clozii/features/auth/domain/entities/auth_result.dart';
import 'package:clozii/features/auth/domain/repositories/auth_repository.dart';
import 'package:clozii/features/auth/domain/entities/user.dart';
import 'package:flutter/foundation.dart';

/// 로그인용 OTP 검증 UseCase
class VerifySignInOtp {
  final AuthRepository _authRepository;

  VerifySignInOtp(this._authRepository);

  Future<AuthResult<User>> call(
    String verificationId,
    String otpCode,
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

      debugPrint('====== verifySignInOtpUsecase.call ======');
      debugPrint('UID: ${verifiedUser.uid}');
      debugPrint('====== verifySignInOtpUsecase.call ======');

      // 2. Firestore에서 전체 사용자 정보 조회
      final getUserResult =
          await _authRepository.getUserFromFirestore(verifiedUser.uid);

      if (!getUserResult.isSuccess) {
        // Firestore에 사용자 정보가 없으면 회원가입 필요
        return AuthResult.failure(getUserResult.failure!);
      }

      return AuthResult.success(getUserResult.data!);
    } catch (e) {
      return AuthResult.failure(UnknownFailure(e.toString()));
    }
  }
}

import 'package:clozii/features/auth/core/errors/auth_failures.dart';
import 'package:clozii/features/auth/domain/entities/auth_result.dart';
import 'package:clozii/features/auth/domain/repositories/auth_repository.dart';
import 'package:clozii/features/auth/domain/entities/user.dart';
import 'package:flutter/foundation.dart';

class VerifyOtpCodeUsecase {
  final AuthRepository _authRepository;

  VerifyOtpCodeUsecase(this._authRepository);

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

      // TODO: 추가 정보를 Firestore에 저장
      // await _userRepository.saveUser(domainUser);

      return AuthResult.success(domainUser);
    } catch (e) {
      return AuthResult.failure(UnknownFailure(e.toString()));
    }
  }
}

import 'package:clozii/features/auth/core/errors/auth_failures.dart';
import 'package:clozii/features/auth/domain/entities/auth_result.dart';
import 'package:clozii/features/auth/domain/repositories/auth_repository.dart';

/// 인증번호 전송 유스케이스
/// - Firebase 연락처 로그인을 위한 인증번호 발송
///   실제 발송 optCode 확인 불가능!!
class SendVerificationUsecase {
  final AuthRepository _authRepository;

  SendVerificationUsecase(this._authRepository);

  Future<AuthResult<String>> call(String phoneNumber) async {
    try {
      final result = await _authRepository.sendVerificationCode(phoneNumber);

      if (!result.isSuccess) {
        return AuthResult.failure(result.failure!);
      }

      return AuthResult.success(result.data!);
    } catch (e) {
      return AuthResult.failure(UnknownFailure(e.toString()));
    }
  }
}

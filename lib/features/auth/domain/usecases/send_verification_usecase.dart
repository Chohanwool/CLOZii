import 'package:clozii/features/auth/core/errors/auth_failures.dart';
import 'package:clozii/features/auth/domain/entities/auth_result.dart';
import 'package:clozii/features/auth/domain/repositories/auth_repository.dart';

class SendVerificationUsecase {
  final AuthRepository _authRepository;

  SendVerificationUsecase(this._authRepository);

  Future<AuthResult<bool>> call(String phoneNumber) async {
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

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:clozii/features/auth/domain/repositories/auth_repository.dart';
import 'package:clozii/features/auth/data/repositories/auth_repository_impl.dart';

import 'package:clozii/features/auth/domain/usecases/send_verification_usecase.dart';
import 'package:clozii/features/auth/domain/usecases/verify_otp_code_usecase.dart';

part 'auth_providers.g.dart';

/// auth 도메인의 DI provider 모음
/// - authRepository -> authRepositoryProvider
/// - sendVerification -> sendVerificationProvider
/// - verifyOtpCode -> verifyOtpCodeProvider

@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepositoryImpl();
}

@riverpod
SendVerification sendVerification(Ref ref) {
  return SendVerification(ref.read(authRepositoryProvider));
}

@riverpod
VerifyOtpCode verifyOtpCode(Ref ref) {
  return VerifyOtpCode(ref.read(authRepositoryProvider));
}

import 'package:clozii/features/auth/domain/usecases/verify_otp_code_usecase.dart';
import 'package:clozii/features/auth/presentation/providers/auth_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final verifyOtpCodeUsecaseProvider = Provider<VerifyOtpCodeUsecase>((ref) {
  final authrepository = ref.read(authRepositoryProvider);
  return VerifyOtpCodeUsecase(authrepository);
});

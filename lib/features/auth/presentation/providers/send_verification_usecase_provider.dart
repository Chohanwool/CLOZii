import 'package:clozii/features/auth/domain/usecases/send_verification_usecase.dart';
import 'package:clozii/features/auth/presentation/providers/auth_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// final sendVerificationUsecaseProvider = Provider<SendVerificationUsecase>(
//   (ref) => SendVerificationUsecase(ref.read(authRepositoryProvider)),
// );

final sendVerificationUsecaseProvider = Provider<SendVerificationUsecase>((
  ref,
) {
  final authRepository = ref.read(authRepositoryProvider);
  return SendVerificationUsecase(authRepository);
});

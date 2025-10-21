import 'package:clozii/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:clozii/features/auth/presentation/providers/auth_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final signUpUsecaseProvider = Provider<SignUpUsecase>((ref) {
  final authrepository = ref.read(authRepositoryProvider);
  return SignUpUsecase(authrepository);
});

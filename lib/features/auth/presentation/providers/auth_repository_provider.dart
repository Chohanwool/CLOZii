import 'package:clozii/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:clozii/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(),
);

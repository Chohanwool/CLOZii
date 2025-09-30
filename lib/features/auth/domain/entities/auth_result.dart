// Auth result entity for auth_sample
import 'package:clozii/features/auth/core/errors/auth_failures.dart';

class AuthResult<T> {
  final T? data;
  final AuthFailure? failure;
  final bool isSuccess;

  const AuthResult._({this.data, this.failure, required this.isSuccess});

  factory AuthResult.success(T data) {
    return AuthResult._(data: data, isSuccess: true);
  }

  factory AuthResult.failure(AuthFailure failure) {
    return AuthResult._(failure: failure, isSuccess: false);
  }

  void when({
    required Function(T data) success,
    required Function(AuthFailure failure) failure,
  }) {
    if (isSuccess) {
      success(data as T);
    } else {
      failure(this.failure!);
    }
  }

  R map<R>({
    required R Function(T data) success,
    required R Function(AuthFailure failure) failure,
  }) {
    if (isSuccess) {
      return success(data as T);
    } else {
      return failure(this.failure!);
    }
  }
}

import 'package:clozii/features/auth/domain/entities/auth_result.dart';
import 'package:clozii/features/auth/domain/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<AuthResult<User>> signUp({
    required String name,
    required String phoneNumber,
    required DateTime birthDate,
    required String gender,
  }) {
    // TODO: implement signUp
    throw UnimplementedError();
  }

  @override
  Future<AuthResult<User>> signIn(String phoneNumber) {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future<AuthResult<User>> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<AuthResult<bool>> isPhoneRegistered(String phoneNumber) {
    // TODO: implement isPhoneRegistered
    throw UnimplementedError();
  }

  @override
  Future<AuthResult<String>> sendVerificationCode(String phoneNumber) async {
    Future.delayed(const Duration(seconds: 2));

    // 임시 작성
    return await AuthResult.success('123456');
  }

  @override
  Future<AuthResult<bool>> resendVerificationCode(String phoneNumber) {
    // TODO: implement resendVerificationCode
    throw UnimplementedError();
  }

  @override
  Future<AuthResult<bool>> verifyCode(String phoneNumber, String code) {
    // TODO: implement verifyCode
    throw UnimplementedError();
  }
}

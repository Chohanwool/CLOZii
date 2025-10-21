import 'dart:async';

import 'package:clozii/features/auth/core/errors/auth_failures.dart';
import 'package:clozii/features/auth/domain/entities/auth_result.dart';
import 'package:clozii/features/auth/domain/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';

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
    debugPrint('연락처 정보: $phoneNumber');

    var auth = FirebaseAuth.instance;

    try {
      final Completer<String> completer = Completer<String>();

      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,

        // Android 기기의 SMS 코드 자동 처리
        verificationCompleted: (PhoneAuthCredential credential) async {
          // ANDROID ONLY!

          await auth.signInWithCredential(credential);
        },

        // 잘못된 전화번호나 SMS 할당량 초과 여부 등의 실패 이벤트 처리
        verificationFailed: (FirebaseAuthException e) {
          debugPrint('=== Firebase Auth Error ===');
          debugPrint('Error Code: ${e.code}');
          debugPrint('Error Message: ${e.message}');
          debugPrint('=======================');

          if (!completer.isCompleted) {
            completer.completeError(e);
          }
        },

        // Firebase에서 기기로 코드가 전송된 경우를 처리
        codeSent: (String verificationId, int? resendToken) async {
          debugPrint('=== codeSent ===');
          debugPrint('verificationId: $verificationId');

          if (!completer.isCompleted) {
            completer.complete(verificationId);
          }
        },

        // 자동 SMS 코드 처리 실패 시 시간 초과
        timeout: const Duration(seconds: 60),
        codeAutoRetrievalTimeout: (String verificationId) {
          debugPrint('Code auto retrieval timeout');

          if (!completer.isCompleted) {
            completer.complete(verificationId);
          }
        },
      );

      final verificationId = await completer.future;
      return AuthResult.success(verificationId);
      //
    } on FirebaseAuthException catch (e) {
      debugPrint('FirebaseAuthException: ${e.message}');
      return AuthResult.failure(
        AuthenticationFailure(
          e.message ?? 'Firebase auth error occurred',
          e.code,
        ),
      );
    } catch (e) {
      debugPrint('UnknownError: $e');
      return AuthResult.failure(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<AuthResult<bool>> resendVerificationCode(String phoneNumber) {
    // TODO: implement resendVerificationCode
    throw UnimplementedError();
  }

  @override
  Future<AuthResult<User>> verifyCode(
    String verificationId,
    String otpCode,
  ) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otpCode,
      );

      var auth = FirebaseAuth.instance;

      // 로그인 시도
      UserCredential userCredential = await auth.signInWithCredential(
        credential,
      );

      User? user = userCredential.user;

      if (user != null) {
        debugPrint('로그인 성공: ${user.phoneNumber}');
        return AuthResult.success(user);
      } else {
        return AuthResult.failure(UnknownFailure('User is null'));
      }
    } catch (e) {
      return AuthResult.failure(UnknownFailure(e.toString()));
    }

    // throw UnimplementedError();
  }
}

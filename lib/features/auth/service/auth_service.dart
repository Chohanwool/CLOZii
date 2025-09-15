// TODO: 인증번호 전송 로직 구현
// lib/features/auth/service/auth_service.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  static Future<void> sendVerificationCode({
    required String phoneNumber,
    required Function(String verificationId, int? resendToken) onCodeSent,
    required Function(FirebaseAuthException e) onVerificationFailed,
    required Function(PhoneAuthCredential credential) onVerificationCompleted,
    required Function(String verificationId) onCodeAutoRetrievalTimeout,
    bool shouldNavigate = true, // 네비게이션 여부 플래그
  }) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: onVerificationCompleted,
      verificationFailed: onVerificationFailed,
      codeSent: (verificationId, resendToken) async {
        // ✅ shouldNavigate 플래그에 따라 네비게이션 콜백 실행
        if (shouldNavigate) {
          onCodeSent(verificationId, resendToken);
        } else {
          // 재전송 시에는 네비게이션 없이 성공만 알림
          debugPrint('Code resent successfully');
        }
      },
      codeAutoRetrievalTimeout: onCodeAutoRetrievalTimeout,
      timeout: const Duration(seconds: 60),
    );
  }
}

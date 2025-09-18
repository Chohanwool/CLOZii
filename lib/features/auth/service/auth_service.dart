import 'package:clozii/core/utils/show_loading_overlay.dart';
import 'package:clozii/features/auth/data/auth_type.dart';
import 'package:clozii/features/auth/presentation/screens/verification_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  // Private 생성자 - 기본적으로 외부에서의 생성자 호출을 막음
  AuthService._internal();

  // 싱글톤 인스턴스
  static final AuthService _instance = AuthService._internal();
  // factory 생성자 - 외부에서 AuthService()를 호출할 수 있게 해줌
  // 이때 반환되는 객체는 미리 생성된 싱글톤 인스턴스
  // 즉, 외부에서 AuthService()를 호출할 때마다 동일한 인스턴스가 반환됨
  factory AuthService() => _instance;

  // FirebaseAuth 인스턴스
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // 첫 번째 인증 여부 플래그
  bool _isFirstVerification = true;

  /// 핵심) 연락처 인증번호 전송 로직
  Future<void> sendVerificationCode(
    String phoneNumber,
    BuildContext context,
    AuthType authType,
  ) async {
    final loading = showLoadingOverlay(context);

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,

        // Android 기기의 SMS 코드 자동 처리
        verificationCompleted: (PhoneAuthCredential credential) async {
          // ANDROID ONLY!
          // Sign the user in (or link) with the auto-generated credential
          await _auth.signInWithCredential(credential);
        },

        // 잘못된 전화번호나 SMS 할당량 초과 여부 등의 실패 이벤트 처리
        verificationFailed: (FirebaseAuthException e) {
          loading.remove();

          // 상세한 오류 정보 출력
          debugPrint('=== Firebase Auth Error ===');
          debugPrint('Error Code: ${e.code}');
          debugPrint('Error Message: ${e.message}');
          debugPrint('Error Details: ${e.toString()}');
          debugPrint('=======================');
        },

        // Firebase에서 기기로 코드가 전송된 경우를 처리하며 사용자에게 코드을 입력하라는 메시지를 표시
        codeSent: (String verificationId, int? resendToken) async {
          // 인증번호 발송 성공시 네비게이션 진행

          debugPrint('=== codeSent ===');
          debugPrint('verificationId: $verificationId');

          if (loading.mounted) {
            loading.remove();
          }

          if (_isFirstVerification && context.mounted) {
            _isFirstVerification = false;

            debugPrint('isFirstVerification: $_isFirstVerification');
            if (context.mounted) {
              navigateToVerification(
                context,
                phoneNumber,
                verificationId,
                resendToken,
                authType,
              );
            }
          }
        },

        // 자동 SMS 코드 처리에 실패한 경우 시간 초과를 설정
        timeout: const Duration(seconds: 60),
        codeAutoRetrievalTimeout: (String verificationId) {
          loading.remove();
        },
      );
    } catch (e) {
      debugPrint('Error sending verification code: $e');
    } finally {
      if (loading.mounted) {
        loading.remove();
      }
    }
  }

  bool isPhoneNumberRegistered(String phoneNumber) {
    // TODO: 입력된 전화번호로 가입된 계정이 있는지 확인하는 로직 구현
    // 로직 구현 후 함수 반환 타입을 Future<bool> 로 변경 예정

    // Firebase DB에 저장된 '+639171234567' 번호만 가입된 유저로 인식 (임시)
    // return phoneNumber == '+639171234567';
    return false;
  }

  void navigateToVerification(
    BuildContext context,
    String phoneNumber,
    String verificationId,
    int? resendToken,
    AuthType authType,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => VerificationScreen(
          phoneNumber: phoneNumber,
          authType: authType,
          verificationId: verificationId,
          resendToken: resendToken,
          onResendCode: (String phoneNumber) {
            sendVerificationCode(phoneNumber, context, authType);
          },
        ),
      ),
    );
  }
}

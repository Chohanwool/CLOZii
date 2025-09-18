import 'package:clozii/features/auth/data/auth_service.dart';
import 'package:clozii/features/auth/data/auth_type.dart';
import 'package:clozii/features/auth/data/constants.dart';
import 'package:flutter/material.dart';

abstract class AuthBaseScreen extends StatefulWidget {
  const AuthBaseScreen({super.key});
}

abstract class AuthBaseScreenState<T extends AuthBaseScreen> extends State<T> {
  // AuthService 인스턴스
  final AuthService _authService = AuthService();

  // 전화번호 컨트롤러와 포커스 노드
  final TextEditingController phoneNumberController = TextEditingController();
  final FocusNode phoneNumberFocusNode = FocusNode();

  // 전화번호 완성 메서드: '09...' -> '+639...'
  String get completePhoneNumber =>
      '$phoneNumberPrefix${phoneNumberController.text.replaceAll('-', '').replaceFirst('09', '')}';


  // AuthService를 통한 인증번호 전송
  Future<void> sendVerificationCode() async {
    await _authService.sendVerificationCode(
      completePhoneNumber,
      context,
      getAuthType(),
    );
  }

  // 전화번호 등록 여부 확인
  bool isPhoneNumberRegistered() {
    return _authService.isPhoneNumberRegistered(completePhoneNumber);
  }

  // 인증 화면에서 3회 인증 실패 시 돌아갈 화면을 정할 때 필요!
  // AuthType.signup -> SignUpScreen()
  // AuthType.login -> LoginScreen()
  AuthType getAuthType();
}

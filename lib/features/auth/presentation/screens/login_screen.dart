import 'package:clozii/core/theme/context_extension.dart';
import 'package:clozii/core/utils/show_alert_dialog.dart';
import 'package:clozii/core/utils/show_loading_overlay.dart';
import 'package:clozii/core/widgets/custom_button.dart';
import 'package:clozii/features/auth/data/auth_step.dart';
import 'package:clozii/features/auth/data/auth_type.dart';
import 'package:clozii/features/auth/data/constants.dart';
import 'package:clozii/features/auth/presentation/screens/verification_screen.dart';
import 'package:clozii/features/auth/presentation/widgets/auth_screen/phone_number_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _currentStep = AuthStep.phoneLogin;

  // 컨트롤러
  final TextEditingController _phoneNumberController = TextEditingController();

  // 포커스 노드
  final FocusNode _phoneNumberFocusNode = FocusNode();

  // 전역 키
  final _formKey = GlobalKey<FormState>();

  // PhoneLogin 관련 상태 변수
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _verificationId = '';
  bool _isFirstVerification = true;

  @override
  void initState() {
    super.initState();

    // 각 필드별 이벤트 리스너 등록하여 입력 값 변경 시 이벤트 발생
    _phoneNumberController.addListener(_checkPhoneNumberValid);

    // 포커스 상태 변경 시 이벤트 발생
    _phoneNumberFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _phoneNumberController.removeListener(_checkPhoneNumberValid);
    _phoneNumberController.dispose();
    _phoneNumberFocusNode.dispose();
    super.dispose();
  }

  // 전화번호 완성 메서드: '09...' -> '+639...'
  String get _completePhoneNumber {
    final cleanNumber = _phoneNumberController.text
        .replaceAll('-', '')
        .replaceFirst('09', '');

    return '$phoneNumberPrefix$cleanNumber';
  }

  // PhoneNumberField 입력 값 비어 있는지 확인
  // bool _isPhoneNumberValid() => _phoneNumberController.text.trim().isNotEmpty;

  //////////////////////////////////////////////////////////////

  /// 1) PhoneNumberField 입력 값 유효성 검사
  void _checkPhoneNumberValid() async {
    final cleanNumber = _phoneNumberController.text.replaceAll('-', '');

    // 입력된 전화번호 길이가 11 이면서
    // _currentStep == (AuthStep.phoneSignup 또는 AuthStep.phoneLogin) 인 경우
    if (cleanNumber.length == phoneNumberMaxLength) {
      debugPrint(_completePhoneNumber);

      // 로그인 화면에서는 전화번호 입력 필드만 필요하므로, _currentStep을 변경 시킬 필요가 없음
      // if (widget.authType == AuthType.login) {
      //   return;
      // }
    }

    // 번호가 입력 될때마다 UI 리로드 (suffixIcon 표시에 필요!)
    setState(() {});
  }

  /// 핵심) 연락처 인증번호 전송 로직
  Future<void> _sendVerificationCode(String phoneNumber) async {
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
          setState(() {
            loading.remove();
            // _errorMessage = '인증번호 발송 실패: ${e.message}';
          });

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

          setState(() {
            _verificationId = verificationId;
          });

          if (loading != null && loading.mounted) {
            loading.remove();
          }

          if (_isFirstVerification && mounted) {
            _isFirstVerification = false;

            debugPrint('isFirstVerification: $_isFirstVerification');
            if (mounted) {
              _navigateToVerification(phoneNumber, verificationId, resendToken);
            }
          }
        },

        // 자동 SMS 코드 처리에 실패한 경우 시간 초과를 설정
        timeout: const Duration(seconds: 60),
        codeAutoRetrievalTimeout: (String verificationId) {
          setState(() {
            loading.remove();
            // _errorMessage = '인증번호 발송 실패: 인증번호 처리 시간 초과';
          });
        },
      );
    } catch (e) {
      debugPrint('Error sending verification code: $e');
    } finally {
      if (loading != null && loading.mounted) {
        loading.remove();
      }
    }
  }

  bool _isPhoneNumberRegistered() {
    // TODO: 입력된 전화번호로 가입된 계정이 있는지 확인하는 로직 구현
    // 로직 구현 후 함수 반환 타입을 Future<bool> 로 변경 예정

    // Firebase DB에 저장된 '+639171234567' 번호만 가입된 유저로 인식 (임시)
    return _completePhoneNumber == '+639171234567';
  }

  void _navigateToVerification(
    String phoneNumber,
    String verificationId,
    int? resendToken,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => VerificationScreen(
          phoneNumber: phoneNumber,
          authType: AuthType.login,
          verificationId: verificationId,
          resendToken: resendToken,
          onResendCode: (String phoneNumber) {
            _sendVerificationCode(phoneNumber);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

      bottomSheet: KeyboardVisibilityBuilder(
        builder: (context, isKeyboardVisible) {
          final buttonText = 'Continue';
          final buttonHeight = 50.0;

          Widget? button = CustomButton(
            text: buttonText,
            onTap: () {
              if (_isPhoneNumberRegistered()) {
                _sendVerificationCode(_completePhoneNumber);
              } else {
                final isFormValid = _formKey.currentState?.validate() ?? false;

                if (!isFormValid) return;

                showAlertDialog(
                  context,
                  'This phone number is not registered. Please sign up first.',
                );
              }
            },

            height: buttonHeight,
            isKeyboardVisible: isKeyboardVisible,
          );

          return Material(
            child: Container(
              padding: !isKeyboardVisible
                  ? EdgeInsets.symmetric(horizontal: 16.0)
                  : null,
              color: Colors.transparent,
              child: button,
            ),
          );
        },
      ),

      bottomNavigationBar: Container(height: kToolbarHeight),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  headerTexts[_currentStep]!,
                  style: context.textTheme.titleLarge,
                ),

                const SizedBox(height: 24.0),

                PhoneNumberField(
                  controller: _phoneNumberController,
                  focusNode: _phoneNumberFocusNode,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

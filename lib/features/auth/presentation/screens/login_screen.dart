import 'package:clozii/core/theme/context_extension.dart';
import 'package:clozii/core/utils/show_alert_dialog.dart';
import 'package:clozii/core/widgets/custom_button.dart';
import 'package:clozii/features/auth/data/auth_step.dart';
import 'package:clozii/features/auth/data/auth_type.dart';
import 'package:clozii/features/auth/data/constants.dart';
import 'package:clozii/features/auth/presentation/screens/auth_base_screen.dart';
import 'package:clozii/features/auth/presentation/widgets/auth_screen/phone_number_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class LoginScreen extends AuthBaseScreen {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends AuthBaseScreenState<LoginScreen> {
  final _currentStep = AuthStep.phoneLogin;

  // 전역 키
  final _formKey = GlobalKey<FormState>();

  @override
  AuthType getAuthType() => AuthType.login;

  // 전화번호 입력 검증 
  // 가입된 전화번호인 경우, 인증번호 요청 - sendVerificationCode()
  // 가입되지 않은 전화번호인 경우, validator 검증 후 등록되지 않은 번호임을 사용자에게 알림
  void _verifyPhoneNumber() {
    if (isPhoneNumberRegistered()) {
      sendVerificationCode();
    } else {
      final isFormValid = _formKey.currentState?.validate() ?? false;

      if (!isFormValid) return;

      showAlertDialog(
        context,
        'This phone number is not registered. Please sign up first.',
      );
    }
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
            onTap: _verifyPhoneNumber,

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
                  controller: phoneNumberController,
                  focusNode: phoneNumberFocusNode,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

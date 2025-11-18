import 'package:flutter/material.dart';

// APIs
import 'package:flutter_riverpod/flutter_riverpod.dart';

// core
import 'package:clozii/core/theme/context_extension.dart';
import 'package:clozii/core/constants/app_constants.dart';
import 'package:clozii/core/widgets/custom_button.dart';

// providers/states
import 'package:clozii/features/auth/presentation/sign_up/sign_up_provider.dart';
import 'package:clozii/features/auth/core/enum/auth_step.dart';

// widgets
import 'package:clozii/features/auth/presentation/widgets/forms/sign_up_form.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:clozii/core/utils/show_loading_overlay.dart';
import 'package:clozii/features/auth/presentation/widgets/terms_and_conditions.dart';
import 'package:clozii/features/auth/presentation/widgets/agreement_detail.dart';

// screens
import 'package:clozii/features/auth/presentation/screens/verification_screen.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  OverlayEntry? _loadingOverlay;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _loadingOverlay?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final signUpState = ref.watch(signUpProvider);
    final signUpNotifier = ref.read(signUpProvider.notifier);

    // signUpState.isLoading 변경 시 로딩 오버레이 추가/제거
    ref.listen<SignUpState>(signUpProvider, (previous, next) {
      if (previous?.isLoading != next.isLoading) {
        if (next.isLoading) {
          _loadingOverlay = showLoadingOverlay(context);
        } else {
          _loadingOverlay?.remove();
          _loadingOverlay = null;
        }
      }
    });

    // showTermsAndAgree 감지 - 약관 모달 표시
    ref.listen<SignUpState>(signUpProvider, (previous, next) async {
      if (previous?.showTermsAndAgree != next.showTermsAndAgree) {
        if (next.showTermsAndAgree) {
          final isPop =
              await showModalBottomSheet(
                context: context,
                isScrollControlled: true, // 높이 제한을 해제합니다.
                barrierColor: AppColors.black26,
                backgroundColor: AppColors.white,
                builder: (context) => TermsAndConditions(
                  onShowAgreementDetail: (type) {
                    showModalBottomSheet(
                      context: context, // 올바른 context 사용
                      isScrollControlled: true,
                      isDismissible: false,
                      enableDrag: false,
                      builder: (_) => AgreementDetail(type: type),
                    );
                  },
                ), // 모달 내용: 약
              ) ??
              false; // 약관 동의하지 않고 모달만 닫은 경우 false 반환

          // 약관 동의 여부에 따른 분기 처리
          if (isPop) {
            signUpNotifier.sendVerificationCode();
          } else {
            signUpNotifier.setShowTermsAndAgreeToFalse();
          }
        }
      }
    });

    // 인증번호 전송 성공 감지 - VerificationScreen으로 이동
    ref.listen<SignUpState>(signUpProvider, (previous, next) {
      if (previous?.isSuccess != next.isSuccess && next.isSuccess) {
        if (next.verificationId != null) {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (contxt) => VerificationScreen()));
          debugPrint('✅ Navigate to VerificationScreen');
        }
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign up'),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.clear),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: signUpNotifier.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    signUpState.stepTitle,
                    style: context.textTheme.titleLarge,
                  ),
                  const SizedBox(height: 24.0),

                  SignUpForm(
                    signUpState: signUpState,

                    onPhoneChanged: signUpNotifier.updatePhoneNumber,
                    phoneNumberFocusNode: signUpNotifier.phoneNumberFocusNode,

                    onNameChanged: signUpNotifier.updateName,
                    nameFocusNode: signUpNotifier.nameFocusNode,

                    onBirthDateChanged: signUpNotifier.updateBirthDate,
                    birthDateFocusNode: signUpNotifier.birthDateFocusNode,

                    onGenderChanged: signUpNotifier.updateGender,
                    genderFocusNode: signUpNotifier.genderFocusNode,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomSheet:
          (signUpState.currentStep == AuthStep.name ||
              signUpState.currentStep == AuthStep.gender)
          ? KeyboardVisibilityBuilder(
              builder: (BuildContext contex, bool isKeyboardVisible) {
                final String buttonText = 'Continue';
                final double buttonHeight = 50.0;
                Widget? button;

                if (signUpState.currentStep == AuthStep.name) {
                  button = CustomButton(
                    text: buttonText,
                    onTap: signUpNotifier.showBirthDatePicker,
                    height: buttonHeight,
                    isKeyboardVisible: isKeyboardVisible,
                  );
                }

                if (signUpState.currentStep == AuthStep.gender) {
                  button = CustomButton(
                    text: buttonText,
                    onTap: () {
                      signUpNotifier.checkAllFieldsValid();
                    },
                    height: buttonHeight,
                    isKeyboardVisible: isKeyboardVisible,
                  );
                }

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
            )
          : null,
      bottomNavigationBar: Container(height: kToolbarHeight),
    );
  }
}

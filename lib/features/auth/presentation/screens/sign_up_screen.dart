import 'package:flutter/material.dart';

// APIs
import 'package:flutter_riverpod/flutter_riverpod.dart';

// core
import 'package:clozii/core/theme/context_extension.dart';
import 'package:clozii/core/constants/app_constants.dart';
import 'package:clozii/core/widgets/custom_button.dart';

// providers/states
import 'package:clozii/features/auth/presentation/providers/sign_up_provider.dart';
import 'package:clozii/features/auth/core/enum/auth_step.dart';
import 'package:clozii/features/auth/presentation/states/sign_up_state.dart';

// widgets
import 'package:clozii/features/auth/presentation/widgets/forms/sign_up_form.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:clozii/core/utils/show_loading_overlay.dart';
import 'package:clozii/features/auth/presentation/widgets/terms_and_conditions.dart';

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
          final isPop = await showModalBottomSheet(
            context: context,
            barrierColor: AppColors.black26,
            backgroundColor: AppColors.white,
            isScrollControlled: true, // 모달이 화면 높이만큼 채워짐
            // - 하지만 약관 위젯에서 Wrap 위젯 사용해서 내부 요소만큼만 모달이 채워짐
            builder: (context) => const TermsAndConditions(), // 모달 내용: 약
          );

          if (isPop) {
            signUpNotifier.sendVerificationCode();
          }
        }
      }
    });

    return Scaffold(
      appBar: AppBar(
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

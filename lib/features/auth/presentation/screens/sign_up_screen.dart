import 'package:clozii/core/widgets/custom_button.dart';
import 'package:clozii/features/auth/core/enum/auth_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

// APIs
import 'package:flutter_riverpod/flutter_riverpod.dart';

// core
import 'package:clozii/core/theme/context_extension.dart';

// providers/states
import 'package:clozii/features/auth/presentation/providers/sign_up_provider.dart';

// widgets
import 'package:clozii/features/auth/presentation/widgets/forms/sign_up_form.dart';

class SignUpScreen extends ConsumerWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signUpState = ref.watch(signUpProvider);
    final signUpNotifier = ref.read(signUpProvider.notifier);

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
                      // TODO: 약관 표시 후 인증 화면으로 이동
                      debugPrint(signUpState.toString());
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

import 'package:flutter/material.dart';

import 'package:clozii/features/auth/core/enum/auth_step.dart';
import 'package:clozii/features/auth/presentation/states/sign_up_state.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpViewModel extends Notifier<SignUpState> {
  final formKey = GlobalKey<FormState>();

  //TODO: 나중에 signUpUseCase 읽어와야함
  late FocusNode phoneNumberFocusNode;
  late FocusNode nameFocusNode;
  late FocusNode birthDateFocusNode;
  late FocusNode genderFocusNode;

  @override
  SignUpState build() {
    phoneNumberFocusNode = FocusNode();
    nameFocusNode = FocusNode();
    birthDateFocusNode = FocusNode();
    genderFocusNode = FocusNode();

    // provider에서 .autoDispose를 사용한 부분을 실질적으로 콜백으로 등록하는 부분
    // 프로바이더 해제 시, autoDispose 동작 -> onDispose 콜백 호출
    ref.onDispose(() {
      phoneNumberFocusNode.dispose();
      nameFocusNode.dispose();
      birthDateFocusNode.dispose();
      genderFocusNode.dispose();
    });

    return const SignUpState();
  }

  void updatePhoneNumber(String phoneNumber) {
    final rawNumber = phoneNumber.replaceAll('-', '');

    state = state.copyWith(phoneNumber: rawNumber, errorMessage: null);

    if (state.isPhoneValid && state.currentStep == AuthStep.phoneSignup) {
      state = state.copyWith(currentStep: AuthStep.name);

      // 혹시 모를 실패를 대비해서 UI 업데이트 후 포커스 이동
      WidgetsBinding.instance.addPostFrameCallback((_) {
        nameFocusNode.requestFocus();
      });
    }

    // debugPrint(state.toString());
  }

  void updateName(String name) {
    state = state.copyWith(name: name, errorMessage: null);
  }

  void showBirthDatePicker() {
    if (state.isNameValid && state.currentStep == AuthStep.name) {
      state = state.copyWith(currentStep: AuthStep.birthdate);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        birthDateFocusNode.requestFocus();
      });
    }
  }

  void updateBirthDate(DateTime? birthDate) {
    state = state.copyWith(birthDate: birthDate, errorMessage: null);

    if (state.isBirthDateValid && state.currentStep == AuthStep.birthdate) {
      state = state.copyWith(currentStep: AuthStep.gender);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        genderFocusNode.requestFocus();
      });
    }
  }

  void updateGender(String? gender) {
    state = state.copyWith(gender: gender, errorMessage: null);

    if (state.isGenderValid && state.currentStep == AuthStep.gender) {
      // TODO: 약관 표시 후 인증 화면으로 이동
    }
  }

  void checkAllFieldsValid() {
    final isFormValid = formKey.currentState?.validate() ?? false;

    if (!isFormValid) return;

    debugPrint(' ✅ All fields are valid ' + state.toString());
  }

  Future<void> termsAgree() async {}
}

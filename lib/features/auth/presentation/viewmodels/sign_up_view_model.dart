import 'package:flutter/material.dart';

import 'package:clozii/features/auth/core/enum/auth_step.dart';
import 'package:clozii/features/auth/presentation/states/sign_up_state.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpViewModel extends Notifier<SignUpState> {
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

  Future<void> proceedToNextStep() async {}

  Future<void> termsAgree() async {}
}

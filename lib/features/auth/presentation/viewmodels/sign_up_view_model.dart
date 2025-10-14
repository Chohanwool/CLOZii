import 'package:clozii/features/auth/presentation/providers/send_verification_usecase_provider.dart';
import 'package:flutter/material.dart';

import 'package:clozii/features/auth/core/enum/auth_step.dart';
import 'package:clozii/features/auth/presentation/states/sign_up_state.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

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

  /// 연락처 필드 입력시 호출
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

  // 이름 필드 입력시 호출
  void updateName(String name) {
    state = state.copyWith(name: name, errorMessage: null);
  }

  // 이름 필드 입력 후, 하단 'Continue' 버튼 클릭 -> 생년월일 선택 필드 노출
  void showBirthDatePicker() {
    if (state.isNameValid && state.currentStep == AuthStep.name) {
      state = state.copyWith(currentStep: AuthStep.birthdate);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        birthDateFocusNode.requestFocus();
      });
    }
  }

  // 생년월일 필드 값 선택시 호출
  void updateBirthDate(DateTime? birthDate) {
    // 시간 정보를 제거한 날짜 정보로 변경
    final String formattedDate = DateFormat('yyyy-MM-dd').format(birthDate!);

    state = state.copyWith(birthDate: formattedDate, errorMessage: null);

    if (state.isBirthDateValid && state.currentStep == AuthStep.birthdate) {
      state = state.copyWith(currentStep: AuthStep.gender);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        genderFocusNode.requestFocus();
      });
    }
  }

  // 성별 필드 값 선택시 호출
  void updateGender(String? gender) {
    state = state.copyWith(gender: gender, errorMessage: null);

    if (state.isGenderValid && state.currentStep == AuthStep.gender) {
      // TODO: 약관 표시 후 인증 화면으로 이동
    }
  }

  // 모든 필드 유효성 검증 및 검증 후 약관 동의 모달 노출
  Future<void> checkAllFieldsValid() async {
    final isFormValid = formKey.currentState?.validate() ?? false;

    if (!isFormValid) return;

    // ✅ 로딩 시작 - 오버레이 표시됨
    state = state.copyWith(isLoading: true);

    //TODO: 연락처 중복 확인 로직 추가
    // 서버 통신 등 시간이 걸리는 작업
    // await Future.delayed(Duration(seconds: 2));

    // ✅ 로딩 종료 - 오버레이 제거됨
    // state = state.copyWith(isLoading: false);

    // viewModel에서는 위젯을 import하면 안되기 때문에 새로운 상태 값을 추가하여
    // 상태 값만 변경하여 위젯에서 사용할 수 있도록 함
    state = state.copyWith(isLoading: false, showTermsAndAgree: true);

    debugPrint('SignUpState: ${state.toString()}');
  }

  // 약관 동의 모달 닫기
  void setShowTermsAndAgreeToFalse() {
    state = state.copyWith(showTermsAndAgree: false);
  }

  void toggleAllAgreement() {
    final newAgreementState = !state.isAllAgreed;
    state = state.copyWith(
      isAllAgreed: newAgreementState,
      isTermAgreed: newAgreementState,
      isPrivacyPolicyAgreed: newAgreementState,
      isLocationPolicyAgreed: newAgreementState,
      isMarketingAgreed: newAgreementState,
      isThirdPartyAgreed: newAgreementState,
      isPushAgreed: newAgreementState,
    );
  }

  void updateIndividualAgreement({
    bool? isTermAgreed,
    bool? isPrivacyPolicyAgreed,
    bool? isLocationPolicyAgreed,
    bool? isAgeVerified,
    bool? isMarketingAgreed,
    bool? isThirdPartyAgreed,
    bool? isPushAgreed,
  }) {
    final newState = state.copyWith(
      isTermAgreed: isTermAgreed ?? state.isTermAgreed,
      isPrivacyPolicyAgreed:
          isPrivacyPolicyAgreed ?? state.isPrivacyPolicyAgreed,
      isLocationPolicyAgreed:
          isLocationPolicyAgreed ?? state.isLocationPolicyAgreed,
      isAgeVerified: isAgeVerified ?? state.isAgeVerified,
      isMarketingAgreed: isMarketingAgreed ?? state.isMarketingAgreed,
      isThirdPartyAgreed: isThirdPartyAgreed ?? state.isThirdPartyAgreed,
      isPushAgreed: isPushAgreed ?? state.isPushAgreed,
    );

    final allAgreed = [
      newState.isTermAgreed,
      newState.isPrivacyPolicyAgreed,
      newState.isLocationPolicyAgreed,
      newState.isAgeVerified,
      newState.isMarketingAgreed,
      newState.isThirdPartyAgreed,
      newState.isPushAgreed,
    ].every((e) => e);

    state = newState.copyWith(isAllAgreed: allAgreed);

    print(state.isTermAgreed);
    print(state.isPrivacyPolicyAgreed);
    print(state.isLocationPolicyAgreed);
    print(state.isAgeVerified);
    print(state.isMarketingAgreed);
    print(state.isThirdPartyAgreed);
    print(state.isPushAgreed);
  }

  // Firebase 연락처 인증 로직 호출
  Future<void> sendVerificationCode() async {
    try {
      // 로딩 오버레이
      state = state.copyWith(isLoading: true, showTermsAndAgree: false);

      // 유스케이스 읽어오기
      final sendVerificationUsecase = ref.read(sendVerificationUsecaseProvider);
      final result = await sendVerificationUsecase(state.formattedPhoneNumber);

      debugPrint('------------------');
      debugPrint(result.data);

      if (result.isSuccess) {
        debugPrint('✅ VERIFICATION CODE SENT SUCCESSFULLY');
        debugPrint('verificationId: ${result.data}');

        // VerificationScreen 이동을 위한 상태 값 변경 및 로딩 오버레이 제거
        state = state.copyWith(
          isLoading: false,
          isSuccess: true,
          verificationId: result.data,
        );
      } else {
        debugPrint('❌ VERIFICATION CODE SEND FAILED');
        state = state.copyWith(
          isLoading: false,
          errorMessage:
              result.failure?.message ?? 'Failed to send verification code',
        );
      }
    } catch (e) {
      debugPrint('❌ ERROR IN sendVerificationCode: $e');
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'An unexpected error occurred',
      );
    }
  }
}

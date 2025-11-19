import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// core
import 'package:clozii/features/auth/auth_constants.dart';

// providers
import 'package:clozii/features/auth/presentation/providers/auth_providers.dart';

// parts
part 'sign_in_provider.freezed.dart';
part 'sign_in_provider.g.dart';

// ============================================================================
// State
// ============================================================================

@freezed
sealed class SignInState with _$SignInState {
  const SignInState._();

  const factory SignInState({
    @Default('') String phoneNumber,
    @Default(false) bool isLoading,
    @Default(false) bool isSuccess, // 인증번호 전송 성공 여부
    String? verificationId,
    String? errorMessage,
  }) = _SignInState;

  // Computed properties
  String get formattedPhoneNumber =>
      '${AuthConstants.phoneNumberPrefix}${phoneNumber.replaceAll('-', '').replaceFirst('09', '')}';

  bool get isPhoneValid => phoneNumber.length == 11;
}

// ============================================================================
// Provider (ViewModel)
// ============================================================================

@riverpod
class SignIn extends _$SignIn {
  final formKey = GlobalKey<FormState>();
  late FocusNode phoneNumberFocusNode;

  @override
  SignInState build() {
    phoneNumberFocusNode = FocusNode();

    ref.onDispose(() {
      phoneNumberFocusNode.dispose();
    });

    return const SignInState();
  }

  /// 전화번호 입력
  void updatePhoneNumber(String phoneNumber) {
    final rawNumber = phoneNumber.replaceAll('-', '');
    state = state.copyWith(phoneNumber: rawNumber, errorMessage: null);
  }

  /// Firebase 인증번호 전송
  Future<void> sendVerificationCode() async {
    try {
      // 로딩 시작
      state = state.copyWith(isLoading: true, errorMessage: null);

      // 유스케이스 호출
      final sendVerificationUsecase = ref.read(sendVerificationProvider);
      final result = await sendVerificationUsecase(state.formattedPhoneNumber);

      debugPrint('------------------');
      debugPrint('Sign In - Verification Code Send Result: ${result.data}');
      debugPrint('------------------');

      if (result.isSuccess) {
        debugPrint('✅ VERIFICATION CODE SENT SUCCESSFULLY (Sign In)');
        debugPrint('verificationId: ${result.data}');

        // 성공: VerificationScreen 이동을 위한 상태 변경
        state = state.copyWith(
          isLoading: false,
          isSuccess: true,
          verificationId: result.data,
        );
      } else {
        debugPrint('❌ VERIFICATION CODE SEND FAILED (Sign In)');
        state = state.copyWith(
          isLoading: false,
          errorMessage:
              result.failure?.message ?? 'Failed to send verification code',
        );
      }
    } catch (e) {
      debugPrint('❌ ERROR IN sendVerificationCode (Sign In): $e');
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'An unexpected error occurred',
      );
    }
  }

  /// 상태 초기화
  void reset() {
    state = const SignInState();
  }
}

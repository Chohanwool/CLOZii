import 'dart:async';
import 'package:clozii/features/auth/presentation/providers/sign_up_provider.dart';
import 'package:clozii/features/auth/presentation/providers/sign_up_usecase_provider.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:clozii/features/auth/presentation/states/verification_state.dart';

class VerificationViewModel extends Notifier<VerificationState> {
  Timer? _cooldownTimer;

  @override
  VerificationState build() {
    ref.onDispose(() => _cooldownTimer?.cancel());
    return const VerificationState();
  }

  void startCooldownTimer({int totalSeconds = 120}) {
    _cooldownTimer?.cancel();
    state = state.copyWith(
      minutes: totalSeconds ~/ 60,
      seconds: totalSeconds % 60,
    );

    _cooldownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final total = state.minutes * 60 + state.seconds;
      final next = total - 1;

      if (next <= 0) {
        timer.cancel();
        state = state.copyWith(minutes: 0, seconds: 0);
      } else {
        state = state.copyWith(minutes: next ~/ 60, seconds: next % 60);
      }
    });
  }

  void stopCooldownTimer() {
    _cooldownTimer?.cancel();
    _cooldownTimer = null;
    state = state.copyWith(minutes: 0, seconds: 0);
  }

  void updateAttemptCount() {
    final count = state.attemptCount + 1;
    state = state.copyWith(attemptCount: count);
  }

  // OTP 입력
  void updateOtpCode(newValue) {
    state = state.copyWith(otpCode: newValue);

    // 6자리 입력 완료시 검증
    if (state.isCodeValid) {
      _verifiyOtp();
    }
  }

  Future<void> _verifiyOtp() async {
    if (!state.canSubmit) {
      if (state.remainingSeconds == 0) {
        state = state.copyWith(errorMessage: '제한시간 초과');
      } else if (state.isLocked) {
        state = state.copyWith(errorMessage: '너무 많은 요청');
      }
      return;
    }

    state = state.copyWith(isSubmitting: true, errorMessage: null);

    try {
      final signUp = ref.read(signUpProvider);

      // UseCase 호출
      final signUpUsecase = ref.read(signUpUsecaseProvider);

      // 결과 처리
      final result = await signUpUsecase(
        signUp.verificationId!,
        state.otpCode,
        signUp.name,
        signUp.phoneNumber,
        DateTime.parse(signUp.birthDate!),
        signUp.gender!,
      );

      if (result.isSuccess) {
        state = state.copyWith(
          isSubmitting: false,
          // isSuccess: true,
          errorMessage: null,
        );
        debugPrint('회원가입 및 로그인 성공!!');
      } else {
        state = state.copyWith(
          isSubmitting: false,
          errorMessage: result.failure?.message ?? '인증 실패',
        );
        updateAttemptCount();
      }
    } catch (e) {
      state = state.copyWith(
        isSubmitting: false,
        errorMessage: '예상치 못한 오류가 발생했습니다',
      );
      updateAttemptCount();
    }
  }
}

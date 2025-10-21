import 'dart:async';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// providers
import 'package:clozii/features/auth/presentation/providers/sign_up_provider.dart';
import 'package:clozii/features/auth/presentation/providers/verify_otp_code_usecase_provider.dart';

// states
import 'package:clozii/features/auth/presentation/states/verification_state.dart';

class VerificationViewModel extends Notifier<VerificationState> {
  Timer? _cooldownTimer;

  @override
  VerificationState build() {
    ref.onDispose(() => _cooldownTimer?.cancel());
    return const VerificationState();
  }

  /// 인증번호 입력 타이머 시작
  /// totalSeconds : 120초(2분)
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

  /// 타이머 종료
  void stopCooldownTimer() {
    _cooldownTimer?.cancel();
    _cooldownTimer = null;
    state = state.copyWith(minutes: 0, seconds: 0);
  }

  /// 인증번호 입력 시도 횟수 카운트
  void updateAttemptCount() {
    final count = state.attemptCount + 1;
    state = state.copyWith(attemptCount: count);

    // 5회 이상 실패시, 잠금
    if (count >= 5) {
      state = state.copyWith(isLocked: true);
    }
  }

  /// OTP 입력
  void updateOtpCode(newValue) {
    state = state.copyWith(otpCode: newValue);

    // 6자리 입력 완료시 검증: _verifyOtp 호출
    if (state.isCodeValid) {
      _verifiyOtp();
    }
  }

  /// 인증번호 검증
  /// - 검증 성공 시, 자동 회원가입(로그인)
  Future<void> _verifiyOtp() async {
    if (!state.canSubmit) {
      if (state.remainingSeconds == 0) {
        // TODO: 에러 메시지 작업 예정
        state = state.copyWith(errorMessage: '제한시간 초과');
      } else if (state.isLocked) {
        // TODO: 에러 메시지 작업 예정
        state = state.copyWith(errorMessage: '너무 많은 요청');
      }
      return;
    }

    state = state.copyWith(
      isLoading: true, // 로딩바 오버레이 노출
      isSubmitting: true,
      errorMessage: null,
    );

    try {
      // 회원가입 Form 정보 읽어오기
      final signUp = ref.read(signUpProvider);

      // UseCase 호출
      final signUpUsecase = ref.read(verifyOtpCodeUsecaseProvider);

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
          isLoading: false,
          isSubmitting: false,
          errorMessage: null,
        );
        debugPrint('====== verificationViewModel._verifyOtp ======');
        debugPrint(result.toString());
        debugPrint('====== verificationViewModel._verifyOtp ======');
      } else {
        state = state.copyWith(
          isLoading: false,
          isSubmitting: false,
          errorMessage: result.failure?.message ?? '인증 실패',
        );

        // 인증번호 시도 횟수 증가
        updateAttemptCount();
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        isSubmitting: false,
        errorMessage: '예상치 못한 오류가 발생했습니다',
      );

      // 인증번호 시도 횟수 증가
      updateAttemptCount();
    }
  }
}

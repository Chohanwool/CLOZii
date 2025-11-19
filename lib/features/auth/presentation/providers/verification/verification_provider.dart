import 'dart:async';
import 'package:flutter/rendering.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// providers
import 'package:clozii/features/auth/presentation/providers/sign_up/sign_up_provider.dart';
import 'package:clozii/features/auth/presentation/providers/sign_in/sign_in_provider.dart';
import 'package:clozii/features/auth/presentation/providers/auth_providers.dart';

// failures
import 'package:clozii/features/auth/core/errors/auth_failures.dart';

// enum
import 'package:clozii/features/auth/core/enum/verification_mode.dart';

// parts
part 'verification_provider.freezed.dart';
part 'verification_provider.g.dart';

// ============================================================================
// Constants
// ============================================================================

const int maxAttemptCount = 3;

// ============================================================================
// State
// ============================================================================

@freezed
sealed class VerificationState with _$VerificationState {
  const VerificationState._();

  const factory VerificationState({
    @Default('') String otpCode, // 6자리 입력
    @Default(false) bool isSubmitting, // 제출 로딩
    @Default(false) bool isLoading,
    @Default(0) int cooldownTimer,
    @Default(0) int minutes,
    @Default(0) int seconds,
    @Default(0) int resendCooldown, // 재전송 쿨다운(초)
    @Default(1) int attemptCount, // 시도 횟수
    @Default(false) bool isLocked, // 잠금 여부
    @Default(false) bool autoFillAvailable, // 자동완성 가능 여부
    @Default(false) bool isSuccess, // 인증 성공 여부
    @Default(false) bool hasCriticalError, // 심각한 오류 발생 (Firestore 저장 실패 등)
    @Default(VerificationMode.signUp) VerificationMode mode, // 회원가입/로그인 구분
    String? errorMessage, // 에러 메시지
  }) = _VerificationState;

  // Computed properties
  bool get isCodeValid => otpCode.length == 6;
  int get remainingSeconds => minutes * 60 + seconds;

  // otp validate 가능 여부
  bool get canSubmit =>
      isCodeValid && !isSubmitting && !isLocked && remainingSeconds > 0;

  // 재전송 가능 여부
  bool get canResend =>
      remainingSeconds == 0 && !isSubmitting && attemptCount < maxAttemptCount;
}

// ============================================================================
// Provider (ViewModel)
// ============================================================================

@riverpod
class Verification extends _$Verification {
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

  /// 인증 모드 설정
  void setMode(VerificationMode mode) {
    state = state.copyWith(mode: mode);
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
      // mode에 따라 다른 UseCase 호출
      if (state.mode == VerificationMode.signUp) {
        // 회원가입
        await _verifySignUpOtp();
      } else {
        // 로그인
        await _verifySignInOtp();
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

  /// 회원가입용 OTP 검증
  Future<void> _verifySignUpOtp() async {
    // 회원가입 Form 정보 읽어오기
    final signUp = ref.read(signUpProvider);

    // UseCase 호출
    final signUpUsecase = ref.read(verifyOtpCodeProvider);

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
        isSuccess: true,
        errorMessage: null,
      );
      debugPrint('====== verificationViewModel._verifySignUpOtp ======');
      debugPrint(result.toString());
      debugPrint('====== verificationViewModel._verifySignUpOtp ======');
    } else {
      // Firestore 저장 실패 등 심각한 오류 체크 (타입 기반)
      final isCritical = result.failure is FirestoreSaveFailure;

      state = state.copyWith(
        isLoading: false,
        isSubmitting: false,
        hasCriticalError: isCritical,
        errorMessage: isCritical
            ? '예기치 않은 서비스 오류가 발생했습니다.\n처음부터 다시 시도해주세요.'
            : result.failure?.message ?? '인증 실패',
      );

      // 일반 인증 실패인 경우만 시도 횟수 증가
      if (!isCritical) {
        updateAttemptCount();
      }
    }
  }

  /// 로그인용 OTP 검증
  Future<void> _verifySignInOtp() async {
    // 로그인 Form 정보 읽어오기
    final signIn = ref.read(signInProvider);

    // UseCase 호출
    final signInUsecase = ref.read(verifySignInOtpProvider);

    // 결과 처리
    final result = await signInUsecase(
      signIn.verificationId!,
      state.otpCode,
    );

    if (result.isSuccess) {
      state = state.copyWith(
        isLoading: false,
        isSubmitting: false,
        isSuccess: true,
        errorMessage: null,
      );
      debugPrint('====== verificationViewModel._verifySignInOtp ======');
      debugPrint(result.toString());
      debugPrint('====== verificationViewModel._verifySignInOtp ======');
    } else {
      state = state.copyWith(
        isLoading: false,
        isSubmitting: false,
        errorMessage: result.failure?.message ?? '인증 실패',
      );

      // 인증번호 시도 횟수 증가
      updateAttemptCount();
    }
  }
}

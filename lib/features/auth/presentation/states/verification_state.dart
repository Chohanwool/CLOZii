import 'package:freezed_annotation/freezed_annotation.dart';

part 'verification_state.freezed.dart';

const int maxAttemptCount = 3;

@freezed
class VerificationState with _$VerificationState {
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
    String? errorMessage, // 에러 메시지
  }) = _VerificationState;

  bool get isCodeValid => otpCode.length == 6;
  int get remainingSeconds => minutes * 60 + seconds;

  // otp validate 가능 여부
  bool get canSubmit =>
      isCodeValid && !isSubmitting && !isLocked && remainingSeconds > 0;

  // 재전송 가능 여부
  bool get canResend =>
      remainingSeconds == 0 && !isSubmitting && attemptCount < maxAttemptCount;
}

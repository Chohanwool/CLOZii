// lib/features/auth/presentation/states/verification_state.dart
const int maxAttemptCount = 3;

class VerificationState {
  final String otpCode; // 6자리 입력
  final bool isSubmitting; // 제출 로딩
  final bool isLoading; //
  final int cooldownTimer;
  final int minutes;
  final int seconds;
  final int resendCooldown; // 재전송 쿨다운(초)
  final int attemptCount; // 시도 횟수
  final bool isLocked; // 잠금 여부
  final bool autoFillAvailable; // 자동완성 가능 여부

  final String? errorMessage; // 에러 메시지

  const VerificationState({
    this.otpCode = '',
    this.isSubmitting = false,
    this.isLoading = false,
    this.cooldownTimer = 0,
    this.minutes = 0,
    this.seconds = 0,
    this.resendCooldown = 0,
    this.attemptCount = 1,
    this.isLocked = false,
    this.autoFillAvailable = false,
    this.errorMessage,
  });

  bool get isCodeValid => otpCode.length == 6;
  int get remainingSeconds => minutes * 60 + seconds;

  // otp validate 가능 여부
  bool get canSubmit =>
      isCodeValid && !isSubmitting && !isLocked && remainingSeconds > 0;

  // 재전송 가능 여부
  bool get canResend =>
      remainingSeconds == 0 && !isSubmitting && attemptCount < maxAttemptCount;

  VerificationState copyWith({
    String? otpCode,
    bool? isSubmitting,
    bool? isLoading,
    int? cooldownTimer,
    int? minutes,
    int? seconds,
    int? resendCooldown,
    int? attemptCount,
    bool? isLocked,
    bool? autoFillAvailable,
    String? errorMessage,
  }) {
    return VerificationState(
      otpCode: otpCode ?? this.otpCode,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isLoading: isLoading ?? this.isLoading,
      cooldownTimer: cooldownTimer ?? this.cooldownTimer,
      minutes: minutes ?? this.minutes,
      seconds: seconds ?? this.seconds,
      resendCooldown: resendCooldown ?? this.resendCooldown,
      attemptCount: attemptCount ?? this.attemptCount,
      isLocked: isLocked ?? this.isLocked,
      autoFillAvailable: autoFillAvailable ?? this.autoFillAvailable,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

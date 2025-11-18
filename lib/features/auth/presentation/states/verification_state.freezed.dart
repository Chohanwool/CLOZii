// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'verification_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$VerificationState {
  String get otpCode => throw _privateConstructorUsedError; // 6자리 입력
  bool get isSubmitting => throw _privateConstructorUsedError; // 제출 로딩
  bool get isLoading => throw _privateConstructorUsedError;
  int get cooldownTimer => throw _privateConstructorUsedError;
  int get minutes => throw _privateConstructorUsedError;
  int get seconds => throw _privateConstructorUsedError;
  int get resendCooldown => throw _privateConstructorUsedError; // 재전송 쿨다운(초)
  int get attemptCount => throw _privateConstructorUsedError; // 시도 횟수
  bool get isLocked => throw _privateConstructorUsedError; // 잠금 여부
  bool get autoFillAvailable =>
      throw _privateConstructorUsedError; // 자동완성 가능 여부
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of VerificationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VerificationStateCopyWith<VerificationState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VerificationStateCopyWith<$Res> {
  factory $VerificationStateCopyWith(
          VerificationState value, $Res Function(VerificationState) then) =
      _$VerificationStateCopyWithImpl<$Res, VerificationState>;
  @useResult
  $Res call(
      {String otpCode,
      bool isSubmitting,
      bool isLoading,
      int cooldownTimer,
      int minutes,
      int seconds,
      int resendCooldown,
      int attemptCount,
      bool isLocked,
      bool autoFillAvailable,
      String? errorMessage});
}

/// @nodoc
class _$VerificationStateCopyWithImpl<$Res, $Val extends VerificationState>
    implements $VerificationStateCopyWith<$Res> {
  _$VerificationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VerificationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? otpCode = null,
    Object? isSubmitting = null,
    Object? isLoading = null,
    Object? cooldownTimer = null,
    Object? minutes = null,
    Object? seconds = null,
    Object? resendCooldown = null,
    Object? attemptCount = null,
    Object? isLocked = null,
    Object? autoFillAvailable = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      otpCode: null == otpCode
          ? _value.otpCode
          : otpCode // ignore: cast_nullable_to_non_nullable
              as String,
      isSubmitting: null == isSubmitting
          ? _value.isSubmitting
          : isSubmitting // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      cooldownTimer: null == cooldownTimer
          ? _value.cooldownTimer
          : cooldownTimer // ignore: cast_nullable_to_non_nullable
              as int,
      minutes: null == minutes
          ? _value.minutes
          : minutes // ignore: cast_nullable_to_non_nullable
              as int,
      seconds: null == seconds
          ? _value.seconds
          : seconds // ignore: cast_nullable_to_non_nullable
              as int,
      resendCooldown: null == resendCooldown
          ? _value.resendCooldown
          : resendCooldown // ignore: cast_nullable_to_non_nullable
              as int,
      attemptCount: null == attemptCount
          ? _value.attemptCount
          : attemptCount // ignore: cast_nullable_to_non_nullable
              as int,
      isLocked: null == isLocked
          ? _value.isLocked
          : isLocked // ignore: cast_nullable_to_non_nullable
              as bool,
      autoFillAvailable: null == autoFillAvailable
          ? _value.autoFillAvailable
          : autoFillAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VerificationStateImplCopyWith<$Res>
    implements $VerificationStateCopyWith<$Res> {
  factory _$$VerificationStateImplCopyWith(_$VerificationStateImpl value,
          $Res Function(_$VerificationStateImpl) then) =
      __$$VerificationStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String otpCode,
      bool isSubmitting,
      bool isLoading,
      int cooldownTimer,
      int minutes,
      int seconds,
      int resendCooldown,
      int attemptCount,
      bool isLocked,
      bool autoFillAvailable,
      String? errorMessage});
}

/// @nodoc
class __$$VerificationStateImplCopyWithImpl<$Res>
    extends _$VerificationStateCopyWithImpl<$Res, _$VerificationStateImpl>
    implements _$$VerificationStateImplCopyWith<$Res> {
  __$$VerificationStateImplCopyWithImpl(_$VerificationStateImpl _value,
      $Res Function(_$VerificationStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of VerificationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? otpCode = null,
    Object? isSubmitting = null,
    Object? isLoading = null,
    Object? cooldownTimer = null,
    Object? minutes = null,
    Object? seconds = null,
    Object? resendCooldown = null,
    Object? attemptCount = null,
    Object? isLocked = null,
    Object? autoFillAvailable = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_$VerificationStateImpl(
      otpCode: null == otpCode
          ? _value.otpCode
          : otpCode // ignore: cast_nullable_to_non_nullable
              as String,
      isSubmitting: null == isSubmitting
          ? _value.isSubmitting
          : isSubmitting // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      cooldownTimer: null == cooldownTimer
          ? _value.cooldownTimer
          : cooldownTimer // ignore: cast_nullable_to_non_nullable
              as int,
      minutes: null == minutes
          ? _value.minutes
          : minutes // ignore: cast_nullable_to_non_nullable
              as int,
      seconds: null == seconds
          ? _value.seconds
          : seconds // ignore: cast_nullable_to_non_nullable
              as int,
      resendCooldown: null == resendCooldown
          ? _value.resendCooldown
          : resendCooldown // ignore: cast_nullable_to_non_nullable
              as int,
      attemptCount: null == attemptCount
          ? _value.attemptCount
          : attemptCount // ignore: cast_nullable_to_non_nullable
              as int,
      isLocked: null == isLocked
          ? _value.isLocked
          : isLocked // ignore: cast_nullable_to_non_nullable
              as bool,
      autoFillAvailable: null == autoFillAvailable
          ? _value.autoFillAvailable
          : autoFillAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$VerificationStateImpl extends _VerificationState {
  const _$VerificationStateImpl(
      {this.otpCode = '',
      this.isSubmitting = false,
      this.isLoading = false,
      this.cooldownTimer = 0,
      this.minutes = 0,
      this.seconds = 0,
      this.resendCooldown = 0,
      this.attemptCount = 1,
      this.isLocked = false,
      this.autoFillAvailable = false,
      this.errorMessage})
      : super._();

  @override
  @JsonKey()
  final String otpCode;
// 6자리 입력
  @override
  @JsonKey()
  final bool isSubmitting;
// 제출 로딩
  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final int cooldownTimer;
  @override
  @JsonKey()
  final int minutes;
  @override
  @JsonKey()
  final int seconds;
  @override
  @JsonKey()
  final int resendCooldown;
// 재전송 쿨다운(초)
  @override
  @JsonKey()
  final int attemptCount;
// 시도 횟수
  @override
  @JsonKey()
  final bool isLocked;
// 잠금 여부
  @override
  @JsonKey()
  final bool autoFillAvailable;
// 자동완성 가능 여부
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'VerificationState(otpCode: $otpCode, isSubmitting: $isSubmitting, isLoading: $isLoading, cooldownTimer: $cooldownTimer, minutes: $minutes, seconds: $seconds, resendCooldown: $resendCooldown, attemptCount: $attemptCount, isLocked: $isLocked, autoFillAvailable: $autoFillAvailable, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VerificationStateImpl &&
            (identical(other.otpCode, otpCode) || other.otpCode == otpCode) &&
            (identical(other.isSubmitting, isSubmitting) ||
                other.isSubmitting == isSubmitting) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.cooldownTimer, cooldownTimer) ||
                other.cooldownTimer == cooldownTimer) &&
            (identical(other.minutes, minutes) || other.minutes == minutes) &&
            (identical(other.seconds, seconds) || other.seconds == seconds) &&
            (identical(other.resendCooldown, resendCooldown) ||
                other.resendCooldown == resendCooldown) &&
            (identical(other.attemptCount, attemptCount) ||
                other.attemptCount == attemptCount) &&
            (identical(other.isLocked, isLocked) ||
                other.isLocked == isLocked) &&
            (identical(other.autoFillAvailable, autoFillAvailable) ||
                other.autoFillAvailable == autoFillAvailable) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      otpCode,
      isSubmitting,
      isLoading,
      cooldownTimer,
      minutes,
      seconds,
      resendCooldown,
      attemptCount,
      isLocked,
      autoFillAvailable,
      errorMessage);

  /// Create a copy of VerificationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VerificationStateImplCopyWith<_$VerificationStateImpl> get copyWith =>
      __$$VerificationStateImplCopyWithImpl<_$VerificationStateImpl>(
          this, _$identity);
}

abstract class _VerificationState extends VerificationState {
  const factory _VerificationState(
      {final String otpCode,
      final bool isSubmitting,
      final bool isLoading,
      final int cooldownTimer,
      final int minutes,
      final int seconds,
      final int resendCooldown,
      final int attemptCount,
      final bool isLocked,
      final bool autoFillAvailable,
      final String? errorMessage}) = _$VerificationStateImpl;
  const _VerificationState._() : super._();

  @override
  String get otpCode; // 6자리 입력
  @override
  bool get isSubmitting; // 제출 로딩
  @override
  bool get isLoading;
  @override
  int get cooldownTimer;
  @override
  int get minutes;
  @override
  int get seconds;
  @override
  int get resendCooldown; // 재전송 쿨다운(초)
  @override
  int get attemptCount; // 시도 횟수
  @override
  bool get isLocked; // 잠금 여부
  @override
  bool get autoFillAvailable; // 자동완성 가능 여부
  @override
  String? get errorMessage;

  /// Create a copy of VerificationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VerificationStateImplCopyWith<_$VerificationStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

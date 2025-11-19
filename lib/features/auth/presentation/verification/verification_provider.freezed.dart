// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'verification_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VerificationState {

 String get otpCode;// 6자리 입력
 bool get isSubmitting;// 제출 로딩
 bool get isLoading; int get cooldownTimer; int get minutes; int get seconds; int get resendCooldown;// 재전송 쿨다운(초)
 int get attemptCount;// 시도 횟수
 bool get isLocked;// 잠금 여부
 bool get autoFillAvailable;// 자동완성 가능 여부
 bool get isSuccess;// 인증 성공 여부
 String? get errorMessage;
/// Create a copy of VerificationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerificationStateCopyWith<VerificationState> get copyWith => _$VerificationStateCopyWithImpl<VerificationState>(this as VerificationState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerificationState&&(identical(other.otpCode, otpCode) || other.otpCode == otpCode)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.cooldownTimer, cooldownTimer) || other.cooldownTimer == cooldownTimer)&&(identical(other.minutes, minutes) || other.minutes == minutes)&&(identical(other.seconds, seconds) || other.seconds == seconds)&&(identical(other.resendCooldown, resendCooldown) || other.resendCooldown == resendCooldown)&&(identical(other.attemptCount, attemptCount) || other.attemptCount == attemptCount)&&(identical(other.isLocked, isLocked) || other.isLocked == isLocked)&&(identical(other.autoFillAvailable, autoFillAvailable) || other.autoFillAvailable == autoFillAvailable)&&(identical(other.isSuccess, isSuccess) || other.isSuccess == isSuccess)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,otpCode,isSubmitting,isLoading,cooldownTimer,minutes,seconds,resendCooldown,attemptCount,isLocked,autoFillAvailable,isSuccess,errorMessage);

@override
String toString() {
  return 'VerificationState(otpCode: $otpCode, isSubmitting: $isSubmitting, isLoading: $isLoading, cooldownTimer: $cooldownTimer, minutes: $minutes, seconds: $seconds, resendCooldown: $resendCooldown, attemptCount: $attemptCount, isLocked: $isLocked, autoFillAvailable: $autoFillAvailable, isSuccess: $isSuccess, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $VerificationStateCopyWith<$Res>  {
  factory $VerificationStateCopyWith(VerificationState value, $Res Function(VerificationState) _then) = _$VerificationStateCopyWithImpl;
@useResult
$Res call({
 String otpCode, bool isSubmitting, bool isLoading, int cooldownTimer, int minutes, int seconds, int resendCooldown, int attemptCount, bool isLocked, bool autoFillAvailable, bool isSuccess, String? errorMessage
});




}
/// @nodoc
class _$VerificationStateCopyWithImpl<$Res>
    implements $VerificationStateCopyWith<$Res> {
  _$VerificationStateCopyWithImpl(this._self, this._then);

  final VerificationState _self;
  final $Res Function(VerificationState) _then;

/// Create a copy of VerificationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? otpCode = null,Object? isSubmitting = null,Object? isLoading = null,Object? cooldownTimer = null,Object? minutes = null,Object? seconds = null,Object? resendCooldown = null,Object? attemptCount = null,Object? isLocked = null,Object? autoFillAvailable = null,Object? isSuccess = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
otpCode: null == otpCode ? _self.otpCode : otpCode // ignore: cast_nullable_to_non_nullable
as String,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,cooldownTimer: null == cooldownTimer ? _self.cooldownTimer : cooldownTimer // ignore: cast_nullable_to_non_nullable
as int,minutes: null == minutes ? _self.minutes : minutes // ignore: cast_nullable_to_non_nullable
as int,seconds: null == seconds ? _self.seconds : seconds // ignore: cast_nullable_to_non_nullable
as int,resendCooldown: null == resendCooldown ? _self.resendCooldown : resendCooldown // ignore: cast_nullable_to_non_nullable
as int,attemptCount: null == attemptCount ? _self.attemptCount : attemptCount // ignore: cast_nullable_to_non_nullable
as int,isLocked: null == isLocked ? _self.isLocked : isLocked // ignore: cast_nullable_to_non_nullable
as bool,autoFillAvailable: null == autoFillAvailable ? _self.autoFillAvailable : autoFillAvailable // ignore: cast_nullable_to_non_nullable
as bool,isSuccess: null == isSuccess ? _self.isSuccess : isSuccess // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [VerificationState].
extension VerificationStatePatterns on VerificationState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VerificationState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VerificationState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VerificationState value)  $default,){
final _that = this;
switch (_that) {
case _VerificationState():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VerificationState value)?  $default,){
final _that = this;
switch (_that) {
case _VerificationState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String otpCode,  bool isSubmitting,  bool isLoading,  int cooldownTimer,  int minutes,  int seconds,  int resendCooldown,  int attemptCount,  bool isLocked,  bool autoFillAvailable,  bool isSuccess,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VerificationState() when $default != null:
return $default(_that.otpCode,_that.isSubmitting,_that.isLoading,_that.cooldownTimer,_that.minutes,_that.seconds,_that.resendCooldown,_that.attemptCount,_that.isLocked,_that.autoFillAvailable,_that.isSuccess,_that.errorMessage);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String otpCode,  bool isSubmitting,  bool isLoading,  int cooldownTimer,  int minutes,  int seconds,  int resendCooldown,  int attemptCount,  bool isLocked,  bool autoFillAvailable,  bool isSuccess,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _VerificationState():
return $default(_that.otpCode,_that.isSubmitting,_that.isLoading,_that.cooldownTimer,_that.minutes,_that.seconds,_that.resendCooldown,_that.attemptCount,_that.isLocked,_that.autoFillAvailable,_that.isSuccess,_that.errorMessage);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String otpCode,  bool isSubmitting,  bool isLoading,  int cooldownTimer,  int minutes,  int seconds,  int resendCooldown,  int attemptCount,  bool isLocked,  bool autoFillAvailable,  bool isSuccess,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _VerificationState() when $default != null:
return $default(_that.otpCode,_that.isSubmitting,_that.isLoading,_that.cooldownTimer,_that.minutes,_that.seconds,_that.resendCooldown,_that.attemptCount,_that.isLocked,_that.autoFillAvailable,_that.isSuccess,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _VerificationState extends VerificationState {
  const _VerificationState({this.otpCode = '', this.isSubmitting = false, this.isLoading = false, this.cooldownTimer = 0, this.minutes = 0, this.seconds = 0, this.resendCooldown = 0, this.attemptCount = 1, this.isLocked = false, this.autoFillAvailable = false, this.isSuccess = false, this.errorMessage}): super._();
  

@override@JsonKey() final  String otpCode;
// 6자리 입력
@override@JsonKey() final  bool isSubmitting;
// 제출 로딩
@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  int cooldownTimer;
@override@JsonKey() final  int minutes;
@override@JsonKey() final  int seconds;
@override@JsonKey() final  int resendCooldown;
// 재전송 쿨다운(초)
@override@JsonKey() final  int attemptCount;
// 시도 횟수
@override@JsonKey() final  bool isLocked;
// 잠금 여부
@override@JsonKey() final  bool autoFillAvailable;
// 자동완성 가능 여부
@override@JsonKey() final  bool isSuccess;
// 인증 성공 여부
@override final  String? errorMessage;

/// Create a copy of VerificationState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VerificationStateCopyWith<_VerificationState> get copyWith => __$VerificationStateCopyWithImpl<_VerificationState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VerificationState&&(identical(other.otpCode, otpCode) || other.otpCode == otpCode)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.cooldownTimer, cooldownTimer) || other.cooldownTimer == cooldownTimer)&&(identical(other.minutes, minutes) || other.minutes == minutes)&&(identical(other.seconds, seconds) || other.seconds == seconds)&&(identical(other.resendCooldown, resendCooldown) || other.resendCooldown == resendCooldown)&&(identical(other.attemptCount, attemptCount) || other.attemptCount == attemptCount)&&(identical(other.isLocked, isLocked) || other.isLocked == isLocked)&&(identical(other.autoFillAvailable, autoFillAvailable) || other.autoFillAvailable == autoFillAvailable)&&(identical(other.isSuccess, isSuccess) || other.isSuccess == isSuccess)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,otpCode,isSubmitting,isLoading,cooldownTimer,minutes,seconds,resendCooldown,attemptCount,isLocked,autoFillAvailable,isSuccess,errorMessage);

@override
String toString() {
  return 'VerificationState(otpCode: $otpCode, isSubmitting: $isSubmitting, isLoading: $isLoading, cooldownTimer: $cooldownTimer, minutes: $minutes, seconds: $seconds, resendCooldown: $resendCooldown, attemptCount: $attemptCount, isLocked: $isLocked, autoFillAvailable: $autoFillAvailable, isSuccess: $isSuccess, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$VerificationStateCopyWith<$Res> implements $VerificationStateCopyWith<$Res> {
  factory _$VerificationStateCopyWith(_VerificationState value, $Res Function(_VerificationState) _then) = __$VerificationStateCopyWithImpl;
@override @useResult
$Res call({
 String otpCode, bool isSubmitting, bool isLoading, int cooldownTimer, int minutes, int seconds, int resendCooldown, int attemptCount, bool isLocked, bool autoFillAvailable, bool isSuccess, String? errorMessage
});




}
/// @nodoc
class __$VerificationStateCopyWithImpl<$Res>
    implements _$VerificationStateCopyWith<$Res> {
  __$VerificationStateCopyWithImpl(this._self, this._then);

  final _VerificationState _self;
  final $Res Function(_VerificationState) _then;

/// Create a copy of VerificationState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? otpCode = null,Object? isSubmitting = null,Object? isLoading = null,Object? cooldownTimer = null,Object? minutes = null,Object? seconds = null,Object? resendCooldown = null,Object? attemptCount = null,Object? isLocked = null,Object? autoFillAvailable = null,Object? isSuccess = null,Object? errorMessage = freezed,}) {
  return _then(_VerificationState(
otpCode: null == otpCode ? _self.otpCode : otpCode // ignore: cast_nullable_to_non_nullable
as String,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,cooldownTimer: null == cooldownTimer ? _self.cooldownTimer : cooldownTimer // ignore: cast_nullable_to_non_nullable
as int,minutes: null == minutes ? _self.minutes : minutes // ignore: cast_nullable_to_non_nullable
as int,seconds: null == seconds ? _self.seconds : seconds // ignore: cast_nullable_to_non_nullable
as int,resendCooldown: null == resendCooldown ? _self.resendCooldown : resendCooldown // ignore: cast_nullable_to_non_nullable
as int,attemptCount: null == attemptCount ? _self.attemptCount : attemptCount // ignore: cast_nullable_to_non_nullable
as int,isLocked: null == isLocked ? _self.isLocked : isLocked // ignore: cast_nullable_to_non_nullable
as bool,autoFillAvailable: null == autoFillAvailable ? _self.autoFillAvailable : autoFillAvailable // ignore: cast_nullable_to_non_nullable
as bool,isSuccess: null == isSuccess ? _self.isSuccess : isSuccess // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

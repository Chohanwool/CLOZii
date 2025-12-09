// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_up_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SignUpState {
  AuthStep get currentStep;
  String get phoneNumber;
  String get name;
  String? get birthDate;
  String? get gender;
  bool get isLoading;
  String? get errorMessage;
  bool get isSuccess;
  bool get showTermsAndAgree; // 인증번호 관련
  String? get verificationId;
  int? get resendToken; // 약관동의 관련
  bool get isAllAgreed; // 전체 동의
  bool get isTermAgreed; // 이용약관
  bool get isPrivacyPolicyAgreed; // 개인정보 약관
  bool get isLocationPolicyAgreed; // 위치정보
  bool get isAgeVerified; // 연령 확인
  bool get isMarketingAgreed; // 마켓 수신 동의
  bool get isThirdPartyAgreed; // 제3자 서비스(파이어베이스 등) 데이터 공유
  bool get isPushAgreed;

  /// Create a copy of SignUpState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SignUpStateCopyWith<SignUpState> get copyWith =>
      _$SignUpStateCopyWithImpl<SignUpState>(this as SignUpState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SignUpState &&
            (identical(other.currentStep, currentStep) ||
                other.currentStep == currentStep) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.birthDate, birthDate) ||
                other.birthDate == birthDate) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.isSuccess, isSuccess) ||
                other.isSuccess == isSuccess) &&
            (identical(other.showTermsAndAgree, showTermsAndAgree) ||
                other.showTermsAndAgree == showTermsAndAgree) &&
            (identical(other.verificationId, verificationId) ||
                other.verificationId == verificationId) &&
            (identical(other.resendToken, resendToken) ||
                other.resendToken == resendToken) &&
            (identical(other.isAllAgreed, isAllAgreed) ||
                other.isAllAgreed == isAllAgreed) &&
            (identical(other.isTermAgreed, isTermAgreed) ||
                other.isTermAgreed == isTermAgreed) &&
            (identical(other.isPrivacyPolicyAgreed, isPrivacyPolicyAgreed) ||
                other.isPrivacyPolicyAgreed == isPrivacyPolicyAgreed) &&
            (identical(other.isLocationPolicyAgreed, isLocationPolicyAgreed) ||
                other.isLocationPolicyAgreed == isLocationPolicyAgreed) &&
            (identical(other.isAgeVerified, isAgeVerified) ||
                other.isAgeVerified == isAgeVerified) &&
            (identical(other.isMarketingAgreed, isMarketingAgreed) ||
                other.isMarketingAgreed == isMarketingAgreed) &&
            (identical(other.isThirdPartyAgreed, isThirdPartyAgreed) ||
                other.isThirdPartyAgreed == isThirdPartyAgreed) &&
            (identical(other.isPushAgreed, isPushAgreed) ||
                other.isPushAgreed == isPushAgreed));
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        currentStep,
        phoneNumber,
        name,
        birthDate,
        gender,
        isLoading,
        errorMessage,
        isSuccess,
        showTermsAndAgree,
        verificationId,
        resendToken,
        isAllAgreed,
        isTermAgreed,
        isPrivacyPolicyAgreed,
        isLocationPolicyAgreed,
        isAgeVerified,
        isMarketingAgreed,
        isThirdPartyAgreed,
        isPushAgreed
      ]);

  @override
  String toString() {
    return 'SignUpState(currentStep: $currentStep, phoneNumber: $phoneNumber, name: $name, birthDate: $birthDate, gender: $gender, isLoading: $isLoading, errorMessage: $errorMessage, isSuccess: $isSuccess, showTermsAndAgree: $showTermsAndAgree, verificationId: $verificationId, resendToken: $resendToken, isAllAgreed: $isAllAgreed, isTermAgreed: $isTermAgreed, isPrivacyPolicyAgreed: $isPrivacyPolicyAgreed, isLocationPolicyAgreed: $isLocationPolicyAgreed, isAgeVerified: $isAgeVerified, isMarketingAgreed: $isMarketingAgreed, isThirdPartyAgreed: $isThirdPartyAgreed, isPushAgreed: $isPushAgreed)';
  }
}

/// @nodoc
abstract mixin class $SignUpStateCopyWith<$Res> {
  factory $SignUpStateCopyWith(
          SignUpState value, $Res Function(SignUpState) _then) =
      _$SignUpStateCopyWithImpl;
  @useResult
  $Res call(
      {AuthStep currentStep,
      String phoneNumber,
      String name,
      String? birthDate,
      String? gender,
      bool isLoading,
      String? errorMessage,
      bool isSuccess,
      bool showTermsAndAgree,
      String? verificationId,
      int? resendToken,
      bool isAllAgreed,
      bool isTermAgreed,
      bool isPrivacyPolicyAgreed,
      bool isLocationPolicyAgreed,
      bool isAgeVerified,
      bool isMarketingAgreed,
      bool isThirdPartyAgreed,
      bool isPushAgreed});
}

/// @nodoc
class _$SignUpStateCopyWithImpl<$Res> implements $SignUpStateCopyWith<$Res> {
  _$SignUpStateCopyWithImpl(this._self, this._then);

  final SignUpState _self;
  final $Res Function(SignUpState) _then;

  /// Create a copy of SignUpState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentStep = null,
    Object? phoneNumber = null,
    Object? name = null,
    Object? birthDate = freezed,
    Object? gender = freezed,
    Object? isLoading = null,
    Object? errorMessage = freezed,
    Object? isSuccess = null,
    Object? showTermsAndAgree = null,
    Object? verificationId = freezed,
    Object? resendToken = freezed,
    Object? isAllAgreed = null,
    Object? isTermAgreed = null,
    Object? isPrivacyPolicyAgreed = null,
    Object? isLocationPolicyAgreed = null,
    Object? isAgeVerified = null,
    Object? isMarketingAgreed = null,
    Object? isThirdPartyAgreed = null,
    Object? isPushAgreed = null,
  }) {
    return _then(_self.copyWith(
      currentStep: null == currentStep
          ? _self.currentStep
          : currentStep // ignore: cast_nullable_to_non_nullable
              as AuthStep,
      phoneNumber: null == phoneNumber
          ? _self.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      birthDate: freezed == birthDate
          ? _self.birthDate
          : birthDate // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _self.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      isSuccess: null == isSuccess
          ? _self.isSuccess
          : isSuccess // ignore: cast_nullable_to_non_nullable
              as bool,
      showTermsAndAgree: null == showTermsAndAgree
          ? _self.showTermsAndAgree
          : showTermsAndAgree // ignore: cast_nullable_to_non_nullable
              as bool,
      verificationId: freezed == verificationId
          ? _self.verificationId
          : verificationId // ignore: cast_nullable_to_non_nullable
              as String?,
      resendToken: freezed == resendToken
          ? _self.resendToken
          : resendToken // ignore: cast_nullable_to_non_nullable
              as int?,
      isAllAgreed: null == isAllAgreed
          ? _self.isAllAgreed
          : isAllAgreed // ignore: cast_nullable_to_non_nullable
              as bool,
      isTermAgreed: null == isTermAgreed
          ? _self.isTermAgreed
          : isTermAgreed // ignore: cast_nullable_to_non_nullable
              as bool,
      isPrivacyPolicyAgreed: null == isPrivacyPolicyAgreed
          ? _self.isPrivacyPolicyAgreed
          : isPrivacyPolicyAgreed // ignore: cast_nullable_to_non_nullable
              as bool,
      isLocationPolicyAgreed: null == isLocationPolicyAgreed
          ? _self.isLocationPolicyAgreed
          : isLocationPolicyAgreed // ignore: cast_nullable_to_non_nullable
              as bool,
      isAgeVerified: null == isAgeVerified
          ? _self.isAgeVerified
          : isAgeVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      isMarketingAgreed: null == isMarketingAgreed
          ? _self.isMarketingAgreed
          : isMarketingAgreed // ignore: cast_nullable_to_non_nullable
              as bool,
      isThirdPartyAgreed: null == isThirdPartyAgreed
          ? _self.isThirdPartyAgreed
          : isThirdPartyAgreed // ignore: cast_nullable_to_non_nullable
              as bool,
      isPushAgreed: null == isPushAgreed
          ? _self.isPushAgreed
          : isPushAgreed // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [SignUpState].
extension SignUpStatePatterns on SignUpState {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_SignUpState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SignUpState() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_SignUpState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SignUpState():
        return $default(_that);
    }
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_SignUpState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SignUpState() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            AuthStep currentStep,
            String phoneNumber,
            String name,
            String? birthDate,
            String? gender,
            bool isLoading,
            String? errorMessage,
            bool isSuccess,
            bool showTermsAndAgree,
            String? verificationId,
            int? resendToken,
            bool isAllAgreed,
            bool isTermAgreed,
            bool isPrivacyPolicyAgreed,
            bool isLocationPolicyAgreed,
            bool isAgeVerified,
            bool isMarketingAgreed,
            bool isThirdPartyAgreed,
            bool isPushAgreed)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SignUpState() when $default != null:
        return $default(
            _that.currentStep,
            _that.phoneNumber,
            _that.name,
            _that.birthDate,
            _that.gender,
            _that.isLoading,
            _that.errorMessage,
            _that.isSuccess,
            _that.showTermsAndAgree,
            _that.verificationId,
            _that.resendToken,
            _that.isAllAgreed,
            _that.isTermAgreed,
            _that.isPrivacyPolicyAgreed,
            _that.isLocationPolicyAgreed,
            _that.isAgeVerified,
            _that.isMarketingAgreed,
            _that.isThirdPartyAgreed,
            _that.isPushAgreed);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            AuthStep currentStep,
            String phoneNumber,
            String name,
            String? birthDate,
            String? gender,
            bool isLoading,
            String? errorMessage,
            bool isSuccess,
            bool showTermsAndAgree,
            String? verificationId,
            int? resendToken,
            bool isAllAgreed,
            bool isTermAgreed,
            bool isPrivacyPolicyAgreed,
            bool isLocationPolicyAgreed,
            bool isAgeVerified,
            bool isMarketingAgreed,
            bool isThirdPartyAgreed,
            bool isPushAgreed)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SignUpState():
        return $default(
            _that.currentStep,
            _that.phoneNumber,
            _that.name,
            _that.birthDate,
            _that.gender,
            _that.isLoading,
            _that.errorMessage,
            _that.isSuccess,
            _that.showTermsAndAgree,
            _that.verificationId,
            _that.resendToken,
            _that.isAllAgreed,
            _that.isTermAgreed,
            _that.isPrivacyPolicyAgreed,
            _that.isLocationPolicyAgreed,
            _that.isAgeVerified,
            _that.isMarketingAgreed,
            _that.isThirdPartyAgreed,
            _that.isPushAgreed);
    }
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            AuthStep currentStep,
            String phoneNumber,
            String name,
            String? birthDate,
            String? gender,
            bool isLoading,
            String? errorMessage,
            bool isSuccess,
            bool showTermsAndAgree,
            String? verificationId,
            int? resendToken,
            bool isAllAgreed,
            bool isTermAgreed,
            bool isPrivacyPolicyAgreed,
            bool isLocationPolicyAgreed,
            bool isAgeVerified,
            bool isMarketingAgreed,
            bool isThirdPartyAgreed,
            bool isPushAgreed)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SignUpState() when $default != null:
        return $default(
            _that.currentStep,
            _that.phoneNumber,
            _that.name,
            _that.birthDate,
            _that.gender,
            _that.isLoading,
            _that.errorMessage,
            _that.isSuccess,
            _that.showTermsAndAgree,
            _that.verificationId,
            _that.resendToken,
            _that.isAllAgreed,
            _that.isTermAgreed,
            _that.isPrivacyPolicyAgreed,
            _that.isLocationPolicyAgreed,
            _that.isAgeVerified,
            _that.isMarketingAgreed,
            _that.isThirdPartyAgreed,
            _that.isPushAgreed);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _SignUpState extends SignUpState {
  const _SignUpState(
      {this.currentStep = AuthStep.phoneSignup,
      this.phoneNumber = '',
      this.name = '',
      this.birthDate,
      this.gender,
      this.isLoading = false,
      this.errorMessage,
      this.isSuccess = false,
      this.showTermsAndAgree = false,
      this.verificationId,
      this.resendToken,
      this.isAllAgreed = false,
      this.isTermAgreed = false,
      this.isPrivacyPolicyAgreed = false,
      this.isLocationPolicyAgreed = false,
      this.isAgeVerified = false,
      this.isMarketingAgreed = false,
      this.isThirdPartyAgreed = false,
      this.isPushAgreed = false})
      : super._();

  @override
  @JsonKey()
  final AuthStep currentStep;
  @override
  @JsonKey()
  final String phoneNumber;
  @override
  @JsonKey()
  final String name;
  @override
  final String? birthDate;
  @override
  final String? gender;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? errorMessage;
  @override
  @JsonKey()
  final bool isSuccess;
  @override
  @JsonKey()
  final bool showTermsAndAgree;
// 인증번호 관련
  @override
  final String? verificationId;
  @override
  final int? resendToken;
// 약관동의 관련
  @override
  @JsonKey()
  final bool isAllAgreed;
// 전체 동의
  @override
  @JsonKey()
  final bool isTermAgreed;
// 이용약관
  @override
  @JsonKey()
  final bool isPrivacyPolicyAgreed;
// 개인정보 약관
  @override
  @JsonKey()
  final bool isLocationPolicyAgreed;
// 위치정보
  @override
  @JsonKey()
  final bool isAgeVerified;
// 연령 확인
  @override
  @JsonKey()
  final bool isMarketingAgreed;
// 마켓 수신 동의
  @override
  @JsonKey()
  final bool isThirdPartyAgreed;
// 제3자 서비스(파이어베이스 등) 데이터 공유
  @override
  @JsonKey()
  final bool isPushAgreed;

  /// Create a copy of SignUpState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SignUpStateCopyWith<_SignUpState> get copyWith =>
      __$SignUpStateCopyWithImpl<_SignUpState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SignUpState &&
            (identical(other.currentStep, currentStep) ||
                other.currentStep == currentStep) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.birthDate, birthDate) ||
                other.birthDate == birthDate) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.isSuccess, isSuccess) ||
                other.isSuccess == isSuccess) &&
            (identical(other.showTermsAndAgree, showTermsAndAgree) ||
                other.showTermsAndAgree == showTermsAndAgree) &&
            (identical(other.verificationId, verificationId) ||
                other.verificationId == verificationId) &&
            (identical(other.resendToken, resendToken) ||
                other.resendToken == resendToken) &&
            (identical(other.isAllAgreed, isAllAgreed) ||
                other.isAllAgreed == isAllAgreed) &&
            (identical(other.isTermAgreed, isTermAgreed) ||
                other.isTermAgreed == isTermAgreed) &&
            (identical(other.isPrivacyPolicyAgreed, isPrivacyPolicyAgreed) ||
                other.isPrivacyPolicyAgreed == isPrivacyPolicyAgreed) &&
            (identical(other.isLocationPolicyAgreed, isLocationPolicyAgreed) ||
                other.isLocationPolicyAgreed == isLocationPolicyAgreed) &&
            (identical(other.isAgeVerified, isAgeVerified) ||
                other.isAgeVerified == isAgeVerified) &&
            (identical(other.isMarketingAgreed, isMarketingAgreed) ||
                other.isMarketingAgreed == isMarketingAgreed) &&
            (identical(other.isThirdPartyAgreed, isThirdPartyAgreed) ||
                other.isThirdPartyAgreed == isThirdPartyAgreed) &&
            (identical(other.isPushAgreed, isPushAgreed) ||
                other.isPushAgreed == isPushAgreed));
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        currentStep,
        phoneNumber,
        name,
        birthDate,
        gender,
        isLoading,
        errorMessage,
        isSuccess,
        showTermsAndAgree,
        verificationId,
        resendToken,
        isAllAgreed,
        isTermAgreed,
        isPrivacyPolicyAgreed,
        isLocationPolicyAgreed,
        isAgeVerified,
        isMarketingAgreed,
        isThirdPartyAgreed,
        isPushAgreed
      ]);

  @override
  String toString() {
    return 'SignUpState(currentStep: $currentStep, phoneNumber: $phoneNumber, name: $name, birthDate: $birthDate, gender: $gender, isLoading: $isLoading, errorMessage: $errorMessage, isSuccess: $isSuccess, showTermsAndAgree: $showTermsAndAgree, verificationId: $verificationId, resendToken: $resendToken, isAllAgreed: $isAllAgreed, isTermAgreed: $isTermAgreed, isPrivacyPolicyAgreed: $isPrivacyPolicyAgreed, isLocationPolicyAgreed: $isLocationPolicyAgreed, isAgeVerified: $isAgeVerified, isMarketingAgreed: $isMarketingAgreed, isThirdPartyAgreed: $isThirdPartyAgreed, isPushAgreed: $isPushAgreed)';
  }
}

/// @nodoc
abstract mixin class _$SignUpStateCopyWith<$Res>
    implements $SignUpStateCopyWith<$Res> {
  factory _$SignUpStateCopyWith(
          _SignUpState value, $Res Function(_SignUpState) _then) =
      __$SignUpStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {AuthStep currentStep,
      String phoneNumber,
      String name,
      String? birthDate,
      String? gender,
      bool isLoading,
      String? errorMessage,
      bool isSuccess,
      bool showTermsAndAgree,
      String? verificationId,
      int? resendToken,
      bool isAllAgreed,
      bool isTermAgreed,
      bool isPrivacyPolicyAgreed,
      bool isLocationPolicyAgreed,
      bool isAgeVerified,
      bool isMarketingAgreed,
      bool isThirdPartyAgreed,
      bool isPushAgreed});
}

/// @nodoc
class __$SignUpStateCopyWithImpl<$Res> implements _$SignUpStateCopyWith<$Res> {
  __$SignUpStateCopyWithImpl(this._self, this._then);

  final _SignUpState _self;
  final $Res Function(_SignUpState) _then;

  /// Create a copy of SignUpState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? currentStep = null,
    Object? phoneNumber = null,
    Object? name = null,
    Object? birthDate = freezed,
    Object? gender = freezed,
    Object? isLoading = null,
    Object? errorMessage = freezed,
    Object? isSuccess = null,
    Object? showTermsAndAgree = null,
    Object? verificationId = freezed,
    Object? resendToken = freezed,
    Object? isAllAgreed = null,
    Object? isTermAgreed = null,
    Object? isPrivacyPolicyAgreed = null,
    Object? isLocationPolicyAgreed = null,
    Object? isAgeVerified = null,
    Object? isMarketingAgreed = null,
    Object? isThirdPartyAgreed = null,
    Object? isPushAgreed = null,
  }) {
    return _then(_SignUpState(
      currentStep: null == currentStep
          ? _self.currentStep
          : currentStep // ignore: cast_nullable_to_non_nullable
              as AuthStep,
      phoneNumber: null == phoneNumber
          ? _self.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      birthDate: freezed == birthDate
          ? _self.birthDate
          : birthDate // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _self.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      isSuccess: null == isSuccess
          ? _self.isSuccess
          : isSuccess // ignore: cast_nullable_to_non_nullable
              as bool,
      showTermsAndAgree: null == showTermsAndAgree
          ? _self.showTermsAndAgree
          : showTermsAndAgree // ignore: cast_nullable_to_non_nullable
              as bool,
      verificationId: freezed == verificationId
          ? _self.verificationId
          : verificationId // ignore: cast_nullable_to_non_nullable
              as String?,
      resendToken: freezed == resendToken
          ? _self.resendToken
          : resendToken // ignore: cast_nullable_to_non_nullable
              as int?,
      isAllAgreed: null == isAllAgreed
          ? _self.isAllAgreed
          : isAllAgreed // ignore: cast_nullable_to_non_nullable
              as bool,
      isTermAgreed: null == isTermAgreed
          ? _self.isTermAgreed
          : isTermAgreed // ignore: cast_nullable_to_non_nullable
              as bool,
      isPrivacyPolicyAgreed: null == isPrivacyPolicyAgreed
          ? _self.isPrivacyPolicyAgreed
          : isPrivacyPolicyAgreed // ignore: cast_nullable_to_non_nullable
              as bool,
      isLocationPolicyAgreed: null == isLocationPolicyAgreed
          ? _self.isLocationPolicyAgreed
          : isLocationPolicyAgreed // ignore: cast_nullable_to_non_nullable
              as bool,
      isAgeVerified: null == isAgeVerified
          ? _self.isAgeVerified
          : isAgeVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      isMarketingAgreed: null == isMarketingAgreed
          ? _self.isMarketingAgreed
          : isMarketingAgreed // ignore: cast_nullable_to_non_nullable
              as bool,
      isThirdPartyAgreed: null == isThirdPartyAgreed
          ? _self.isThirdPartyAgreed
          : isThirdPartyAgreed // ignore: cast_nullable_to_non_nullable
              as bool,
      isPushAgreed: null == isPushAgreed
          ? _self.isPushAgreed
          : isPushAgreed // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on

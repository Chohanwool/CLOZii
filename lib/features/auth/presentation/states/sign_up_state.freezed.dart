// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_up_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SignUpState {
  AuthStep get currentStep => throw _privateConstructorUsedError;
  String get phoneNumber => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get birthDate => throw _privateConstructorUsedError;
  String? get gender => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  bool get isSuccess => throw _privateConstructorUsedError;
  bool get showTermsAndAgree => throw _privateConstructorUsedError; // 인증번호 관련
  String? get verificationId => throw _privateConstructorUsedError;
  int? get resendToken => throw _privateConstructorUsedError; // 약관동의 관련
  bool get isAllAgreed => throw _privateConstructorUsedError; // 전체 동의
  bool get isTermAgreed => throw _privateConstructorUsedError; // 이용약관
  bool get isPrivacyPolicyAgreed =>
      throw _privateConstructorUsedError; // 개인정보 약관
  bool get isLocationPolicyAgreed => throw _privateConstructorUsedError; // 위치정보
  bool get isAgeVerified => throw _privateConstructorUsedError; // 연령 확인
  bool get isMarketingAgreed => throw _privateConstructorUsedError; // 마켓 수신 동의
  bool get isThirdPartyAgreed =>
      throw _privateConstructorUsedError; // 제3자 서비스(파이어베이스 등) 데이터 공유
  bool get isPushAgreed => throw _privateConstructorUsedError;

  /// Create a copy of SignUpState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SignUpStateCopyWith<SignUpState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignUpStateCopyWith<$Res> {
  factory $SignUpStateCopyWith(
          SignUpState value, $Res Function(SignUpState) then) =
      _$SignUpStateCopyWithImpl<$Res, SignUpState>;
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
class _$SignUpStateCopyWithImpl<$Res, $Val extends SignUpState>
    implements $SignUpStateCopyWith<$Res> {
  _$SignUpStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      currentStep: null == currentStep
          ? _value.currentStep
          : currentStep // ignore: cast_nullable_to_non_nullable
              as AuthStep,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      birthDate: freezed == birthDate
          ? _value.birthDate
          : birthDate // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      isSuccess: null == isSuccess
          ? _value.isSuccess
          : isSuccess // ignore: cast_nullable_to_non_nullable
              as bool,
      showTermsAndAgree: null == showTermsAndAgree
          ? _value.showTermsAndAgree
          : showTermsAndAgree // ignore: cast_nullable_to_non_nullable
              as bool,
      verificationId: freezed == verificationId
          ? _value.verificationId
          : verificationId // ignore: cast_nullable_to_non_nullable
              as String?,
      resendToken: freezed == resendToken
          ? _value.resendToken
          : resendToken // ignore: cast_nullable_to_non_nullable
              as int?,
      isAllAgreed: null == isAllAgreed
          ? _value.isAllAgreed
          : isAllAgreed // ignore: cast_nullable_to_non_nullable
              as bool,
      isTermAgreed: null == isTermAgreed
          ? _value.isTermAgreed
          : isTermAgreed // ignore: cast_nullable_to_non_nullable
              as bool,
      isPrivacyPolicyAgreed: null == isPrivacyPolicyAgreed
          ? _value.isPrivacyPolicyAgreed
          : isPrivacyPolicyAgreed // ignore: cast_nullable_to_non_nullable
              as bool,
      isLocationPolicyAgreed: null == isLocationPolicyAgreed
          ? _value.isLocationPolicyAgreed
          : isLocationPolicyAgreed // ignore: cast_nullable_to_non_nullable
              as bool,
      isAgeVerified: null == isAgeVerified
          ? _value.isAgeVerified
          : isAgeVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      isMarketingAgreed: null == isMarketingAgreed
          ? _value.isMarketingAgreed
          : isMarketingAgreed // ignore: cast_nullable_to_non_nullable
              as bool,
      isThirdPartyAgreed: null == isThirdPartyAgreed
          ? _value.isThirdPartyAgreed
          : isThirdPartyAgreed // ignore: cast_nullable_to_non_nullable
              as bool,
      isPushAgreed: null == isPushAgreed
          ? _value.isPushAgreed
          : isPushAgreed // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SignUpStateImplCopyWith<$Res>
    implements $SignUpStateCopyWith<$Res> {
  factory _$$SignUpStateImplCopyWith(
          _$SignUpStateImpl value, $Res Function(_$SignUpStateImpl) then) =
      __$$SignUpStateImplCopyWithImpl<$Res>;
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
class __$$SignUpStateImplCopyWithImpl<$Res>
    extends _$SignUpStateCopyWithImpl<$Res, _$SignUpStateImpl>
    implements _$$SignUpStateImplCopyWith<$Res> {
  __$$SignUpStateImplCopyWithImpl(
      _$SignUpStateImpl _value, $Res Function(_$SignUpStateImpl) _then)
      : super(_value, _then);

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
    return _then(_$SignUpStateImpl(
      currentStep: null == currentStep
          ? _value.currentStep
          : currentStep // ignore: cast_nullable_to_non_nullable
              as AuthStep,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      birthDate: freezed == birthDate
          ? _value.birthDate
          : birthDate // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      isSuccess: null == isSuccess
          ? _value.isSuccess
          : isSuccess // ignore: cast_nullable_to_non_nullable
              as bool,
      showTermsAndAgree: null == showTermsAndAgree
          ? _value.showTermsAndAgree
          : showTermsAndAgree // ignore: cast_nullable_to_non_nullable
              as bool,
      verificationId: freezed == verificationId
          ? _value.verificationId
          : verificationId // ignore: cast_nullable_to_non_nullable
              as String?,
      resendToken: freezed == resendToken
          ? _value.resendToken
          : resendToken // ignore: cast_nullable_to_non_nullable
              as int?,
      isAllAgreed: null == isAllAgreed
          ? _value.isAllAgreed
          : isAllAgreed // ignore: cast_nullable_to_non_nullable
              as bool,
      isTermAgreed: null == isTermAgreed
          ? _value.isTermAgreed
          : isTermAgreed // ignore: cast_nullable_to_non_nullable
              as bool,
      isPrivacyPolicyAgreed: null == isPrivacyPolicyAgreed
          ? _value.isPrivacyPolicyAgreed
          : isPrivacyPolicyAgreed // ignore: cast_nullable_to_non_nullable
              as bool,
      isLocationPolicyAgreed: null == isLocationPolicyAgreed
          ? _value.isLocationPolicyAgreed
          : isLocationPolicyAgreed // ignore: cast_nullable_to_non_nullable
              as bool,
      isAgeVerified: null == isAgeVerified
          ? _value.isAgeVerified
          : isAgeVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      isMarketingAgreed: null == isMarketingAgreed
          ? _value.isMarketingAgreed
          : isMarketingAgreed // ignore: cast_nullable_to_non_nullable
              as bool,
      isThirdPartyAgreed: null == isThirdPartyAgreed
          ? _value.isThirdPartyAgreed
          : isThirdPartyAgreed // ignore: cast_nullable_to_non_nullable
              as bool,
      isPushAgreed: null == isPushAgreed
          ? _value.isPushAgreed
          : isPushAgreed // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$SignUpStateImpl extends _SignUpState {
  const _$SignUpStateImpl(
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

  @override
  String toString() {
    return 'SignUpState(currentStep: $currentStep, phoneNumber: $phoneNumber, name: $name, birthDate: $birthDate, gender: $gender, isLoading: $isLoading, errorMessage: $errorMessage, isSuccess: $isSuccess, showTermsAndAgree: $showTermsAndAgree, verificationId: $verificationId, resendToken: $resendToken, isAllAgreed: $isAllAgreed, isTermAgreed: $isTermAgreed, isPrivacyPolicyAgreed: $isPrivacyPolicyAgreed, isLocationPolicyAgreed: $isLocationPolicyAgreed, isAgeVerified: $isAgeVerified, isMarketingAgreed: $isMarketingAgreed, isThirdPartyAgreed: $isThirdPartyAgreed, isPushAgreed: $isPushAgreed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignUpStateImpl &&
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

  /// Create a copy of SignUpState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SignUpStateImplCopyWith<_$SignUpStateImpl> get copyWith =>
      __$$SignUpStateImplCopyWithImpl<_$SignUpStateImpl>(this, _$identity);
}

abstract class _SignUpState extends SignUpState {
  const factory _SignUpState(
      {final AuthStep currentStep,
      final String phoneNumber,
      final String name,
      final String? birthDate,
      final String? gender,
      final bool isLoading,
      final String? errorMessage,
      final bool isSuccess,
      final bool showTermsAndAgree,
      final String? verificationId,
      final int? resendToken,
      final bool isAllAgreed,
      final bool isTermAgreed,
      final bool isPrivacyPolicyAgreed,
      final bool isLocationPolicyAgreed,
      final bool isAgeVerified,
      final bool isMarketingAgreed,
      final bool isThirdPartyAgreed,
      final bool isPushAgreed}) = _$SignUpStateImpl;
  const _SignUpState._() : super._();

  @override
  AuthStep get currentStep;
  @override
  String get phoneNumber;
  @override
  String get name;
  @override
  String? get birthDate;
  @override
  String? get gender;
  @override
  bool get isLoading;
  @override
  String? get errorMessage;
  @override
  bool get isSuccess;
  @override
  bool get showTermsAndAgree; // 인증번호 관련
  @override
  String? get verificationId;
  @override
  int? get resendToken; // 약관동의 관련
  @override
  bool get isAllAgreed; // 전체 동의
  @override
  bool get isTermAgreed; // 이용약관
  @override
  bool get isPrivacyPolicyAgreed; // 개인정보 약관
  @override
  bool get isLocationPolicyAgreed; // 위치정보
  @override
  bool get isAgeVerified; // 연령 확인
  @override
  bool get isMarketingAgreed; // 마켓 수신 동의
  @override
  bool get isThirdPartyAgreed; // 제3자 서비스(파이어베이스 등) 데이터 공유
  @override
  bool get isPushAgreed;

  /// Create a copy of SignUpState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SignUpStateImplCopyWith<_$SignUpStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

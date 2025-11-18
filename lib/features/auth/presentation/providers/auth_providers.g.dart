// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// auth 도메인의 DI provider 모음
/// - authRepository -> authRepositoryProvider
/// - sendVerification -> sendVerificationProvider
/// - verifyOtpCode -> verifyOtpCodeProvider

@ProviderFor(authRepository)
const authRepositoryProvider = AuthRepositoryProvider._();

/// auth 도메인의 DI provider 모음
/// - authRepository -> authRepositoryProvider
/// - sendVerification -> sendVerificationProvider
/// - verifyOtpCode -> verifyOtpCodeProvider

final class AuthRepositoryProvider
    extends $FunctionalProvider<AuthRepository, AuthRepository, AuthRepository>
    with $Provider<AuthRepository> {
  /// auth 도메인의 DI provider 모음
  /// - authRepository -> authRepositoryProvider
  /// - sendVerification -> sendVerificationProvider
  /// - verifyOtpCode -> verifyOtpCodeProvider
  const AuthRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authRepositoryHash();

  @$internal
  @override
  $ProviderElement<AuthRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AuthRepository create(Ref ref) {
    return authRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthRepository>(value),
    );
  }
}

String _$authRepositoryHash() => r'a8767550d220ede9bb05149c073a651c4422d5ef';

@ProviderFor(sendVerification)
const sendVerificationProvider = SendVerificationProvider._();

final class SendVerificationProvider
    extends
        $FunctionalProvider<
          SendVerification,
          SendVerification,
          SendVerification
        >
    with $Provider<SendVerification> {
  const SendVerificationProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sendVerificationProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sendVerificationHash();

  @$internal
  @override
  $ProviderElement<SendVerification> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SendVerification create(Ref ref) {
    return sendVerification(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SendVerification value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SendVerification>(value),
    );
  }
}

String _$sendVerificationHash() => r'6f813923d84744d7492387b737efd4bd551c2f26';

@ProviderFor(verifyOtpCode)
const verifyOtpCodeProvider = VerifyOtpCodeProvider._();

final class VerifyOtpCodeProvider
    extends $FunctionalProvider<VerifyOtpCode, VerifyOtpCode, VerifyOtpCode>
    with $Provider<VerifyOtpCode> {
  const VerifyOtpCodeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'verifyOtpCodeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$verifyOtpCodeHash();

  @$internal
  @override
  $ProviderElement<VerifyOtpCode> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  VerifyOtpCode create(Ref ref) {
    return verifyOtpCode(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VerifyOtpCode value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VerifyOtpCode>(value),
    );
  }
}

String _$verifyOtpCodeHash() => r'3bb4701e05c770f5c0b91c74d8e16cb6bdfce18a';

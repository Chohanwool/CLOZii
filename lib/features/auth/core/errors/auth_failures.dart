abstract class AuthFailure {
  final String message;
  final String? code;

  const AuthFailure(this.message, [this.code]);
}

class NetworkFailure extends AuthFailure {
  const NetworkFailure(super.message, [super.code]);
}

class ServerFailure extends AuthFailure {
  const ServerFailure(super.message, [super.code]);
}

class ValidationFailure extends AuthFailure {
  const ValidationFailure(super.message, [super.code]);
}

class AuthenticationFailure extends AuthFailure {
  const AuthenticationFailure(super.message, [super.code]);
}

class PhoneAlreadyRegisteredFailure extends AuthFailure {
  const PhoneAlreadyRegisteredFailure(super.message, [super.code]);
}

class VerificationCodeExpiredFailure extends AuthFailure {
  const VerificationCodeExpiredFailure(super.message, [super.code]);
}

class InvalidVerificationCodeFailure extends AuthFailure {
  const InvalidVerificationCodeFailure(super.message, [super.code]);
}

class MaxAttemptsReachedFailure extends AuthFailure {
  const MaxAttemptsReachedFailure(super.message, [super.code]);
}

class UnknownFailure extends AuthFailure {
  const UnknownFailure(super.message, [super.code]);
}

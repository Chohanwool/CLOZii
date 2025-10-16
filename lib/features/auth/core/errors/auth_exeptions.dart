class AuthException implements Exception {
  final String message;
  final String? code;

  const AuthException(this.message, [this.code]);

  @override
  String toString() => 'AuthException: $message';
}

class NetworkException extends AuthException {
  const NetworkException(super.message, [super.code]);
}

class ServerException extends AuthException {
  const ServerException(super.message, [super.code]);
}

class ValidationException extends AuthException {
  const ValidationException(super.message, [super.code]);
}

class AuthenticationException extends AuthException {
  const AuthenticationException(super.message, [super.code]);
}

class PhoneAlreadyRegisteredException extends AuthException {
  const PhoneAlreadyRegisteredException(super.message, [super.code]);
}

class VerificationCodeExpiredException extends AuthException {
  const VerificationCodeExpiredException(super.message, [super.code]);
}

class InvalidVerificationCodeException extends AuthException {
  const InvalidVerificationCodeException(super.message, [super.code]);
}

class MaxAttemptsReachedException extends AuthException {
  const MaxAttemptsReachedException(super.message, [super.code]);
}

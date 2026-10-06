import '../entities/auth_failure.dart';

/// Domain exception carrying a machine-readable [AuthFailure] code.
class AuthException implements Exception {
  const AuthException(this.code, [this.debugMessage]);

  final AuthFailure code;
  final String? debugMessage;

  @override
  String toString() =>
      'AuthException(${code.name}${debugMessage == null ? '' : ': $debugMessage'})';
}

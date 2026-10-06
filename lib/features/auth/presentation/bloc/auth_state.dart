import 'package:equatable/equatable.dart';

import '../../domain/entities/auth_failure.dart';
import '../../domain/entities/user.dart';

enum AuthStatus {
  /// Session restore has not resolved yet (splash screen).
  unknown,
  loading,
  authenticated,
  unauthenticated,
  failure,
}

class AuthState extends Equatable {
  const AuthState({
    this.status = AuthStatus.unknown,
    this.user,
    this.failure,
  });

  final AuthStatus status;
  final User? user;

  /// Only meaningful when [status] is [AuthStatus.failure].
  final AuthFailure? failure;

  bool get isAuthenticated => status == AuthStatus.authenticated;
  bool get isSubmitting => status == AuthStatus.loading;

  /// States are constructed explicitly (never `copyWith`-ed) so stale user or
  /// failure values can never leak from one flow into another.
  const AuthState.loading() : this(status: AuthStatus.loading);
  const AuthState.authenticated(User user)
      : this(status: AuthStatus.authenticated, user: user);
  const AuthState.unauthenticated()
      : this(status: AuthStatus.unauthenticated);
  const AuthState.failed(AuthFailure failure)
      : this(status: AuthStatus.failure, failure: failure);

  @override
  List<Object?> get props => [status, user, failure];
}

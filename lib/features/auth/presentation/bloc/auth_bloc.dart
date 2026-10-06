import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/auth_failure.dart';
import '../../domain/exceptions/auth_exception.dart';
import '../../domain/usecases/register_user.dart';
import '../../domain/usecases/restore_session.dart';
import '../../domain/usecases/sign_in.dart';
import '../../domain/usecases/sign_out.dart';
import 'auth_event.dart';
import 'auth_state.dart';

export 'auth_event.dart';
export 'auth_state.dart';

/// Drives the whole authentication flow: session restore, sign-in,
/// registration and sign-out.
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required this.signIn,
    required this.registerUser,
    required this.restoreSession,
    required this.signOut,
  }) : super(const AuthState()) {
    on<AuthSessionRestored>(_onSessionRestored);
    on<AuthLoginSubmitted>(_onLogin);
    on<AuthRegisterSubmitted>(_onRegister);
    on<AuthSignOutRequested>(_onSignOut);
  }

  final SignIn signIn;
  final RegisterUser registerUser;
  final RestoreSession restoreSession;
  final SignOut signOut;

  Future<void> _onSessionRestored(
    AuthSessionRestored event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    try {
      final user = await restoreSession();
      if (user == null) {
        emit(const AuthState.unauthenticated());
      } else {
        emit(AuthState.authenticated(user));
      }
    } catch (_) {
      emit(const AuthState.unauthenticated());
    }
  }

  Future<void> _onLogin(
    AuthLoginSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    try {
      final user = await signIn(
        email: event.email.trim(),
        password: event.password,
      );
      emit(AuthState.authenticated(user));
    } on AuthException catch (error) {
      emit(AuthState.failed(error.code));
    } catch (_) {
      emit(const AuthState.failed(AuthFailure.unexpected));
    }
  }

  Future<void> _onRegister(
    AuthRegisterSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    try {
      final user = await registerUser(
        name: event.name.trim(),
        email: event.email.trim(),
        password: event.password,
      );
      emit(AuthState.authenticated(user));
    } on AuthException catch (error) {
      emit(AuthState.failed(error.code));
    } catch (_) {
      emit(const AuthState.failed(AuthFailure.unexpected));
    }
  }

  Future<void> _onSignOut(
    AuthSignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    try {
      await signOut();
    } finally {
      emit(const AuthState.unauthenticated());
    }
  }
}

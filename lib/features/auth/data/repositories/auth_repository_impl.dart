import '../../domain/entities/auth_failure.dart';
import '../../domain/entities/user.dart';
import '../../domain/exceptions/auth_exception.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._dataSource);

  final AuthLocalDataSource _dataSource;

  /// Simulated network latency so loading states are visible in the demo.
  static const _latency = Duration(milliseconds: 600);

  @override
  Future<void> initialize() => _dataSource.ensureSeeded();

  @override
  Future<User> signIn({required String email, required String password}) async {
    await Future<void>.delayed(_latency);

    final storedPassword = await _dataSource.passwordFor(email);
    if (storedPassword == null || storedPassword != password) {
      throw const AuthException(
        AuthFailure.invalidCredentials,
        'No account matches these credentials.',
      );
    }

    final user = await _dataSource.accountFor(email);
    if (user == null) {
      throw const AuthException(AuthFailure.unexpected, 'Account vanished.');
    }

    await _dataSource.saveSession(user.email);
    return user;
  }

  @override
  Future<User> register({
    required String name,
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(_latency);

    final existing = await _dataSource.accountFor(email);
    if (existing != null) {
      throw const AuthException(AuthFailure.emailTaken);
    }

    await _dataSource.upsertAccount(
      name: name,
      email: email,
      password: password,
    );

    final user = await _dataSource.accountFor(email);
    if (user == null) {
      throw const AuthException(AuthFailure.unexpected, 'Registration failed.');
    }

    await _dataSource.saveSession(user.email);
    return user;
  }

  @override
  Future<User?> restoreSession() async {
    final email = _dataSource.readSession();
    if (email == null) return null;
    return _dataSource.accountFor(email);
  }

  @override
  Future<void> signOut() => _dataSource.clearSession();
}

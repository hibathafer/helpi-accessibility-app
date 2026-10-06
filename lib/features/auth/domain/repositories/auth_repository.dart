import '../entities/user.dart';

/// Contract the authentication flow depends on.
///
/// The MVP ships a local implementation; a REST/GraphQL implementation can
/// be dropped in without touching the blocs or the UI.
abstract class AuthRepository {
  /// Called once at startup to seed local data (demo account).
  Future<void> initialize();

  Future<User> signIn({required String email, required String password});

  Future<User> register({
    required String name,
    required String email,
    required String password,
  });

  /// Returns the persisted session user, or `null` when signed out.
  Future<User?> restoreSession();

  Future<void> signOut();
}

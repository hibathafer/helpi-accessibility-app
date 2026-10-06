/// Failure categories surfaced by the authentication flow.
///
/// The domain layer never produces user-facing text: the presentation layer
/// maps these codes onto localized strings.
enum AuthFailure {
  invalidCredentials,
  emailTaken,
  unexpected,
}

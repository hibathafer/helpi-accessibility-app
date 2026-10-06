import '../../../../l10n/generated/app_localizations.dart';
import '../../domain/entities/auth_failure.dart';

/// Maps domain failure codes onto localized, user-facing copy.
extension AuthFailureMessage on AuthFailure {
  String message(AppLocalizations l10n) {
    switch (this) {
      case AuthFailure.invalidCredentials:
        return l10n.invalidCredentials;
      case AuthFailure.emailTaken:
        return l10n.emailTaken;
      case AuthFailure.unexpected:
        return l10n.unexpectedError;
    }
  }
}

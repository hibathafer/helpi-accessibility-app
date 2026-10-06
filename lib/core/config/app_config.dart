/// Runtime switches that depend on services living outside the app.
abstract final class AppConfig {
  /// Enable after configuring a platform-restricted Google Maps key for the
  /// target platform. Desktop continues to use the vector map.
  static const bool useGoogleMaps = bool.fromEnvironment(
    'ENABLE_GOOGLE_MAPS',
    defaultValue: false,
  );
}

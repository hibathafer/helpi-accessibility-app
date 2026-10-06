import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/data/datasources/auth_local_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/places/data/datasources/places_local_data_source.dart';
import '../../features/places/data/repositories/places_repository_impl.dart';
import '../../features/places/domain/repositories/places_repository.dart';

/// Composition root for the app.
///
/// Every external dependency (persistence, data sources, repositories) is
/// created exactly once here, so swapping the local data source for a REST
/// or GraphQL implementation later only touches this file.
class AppContainer {
  AppContainer(this.prefs) {
    authRepository = AuthRepositoryImpl(AuthLocalDataSource(prefs));
    placesRepository = PlacesRepositoryImpl(PlacesLocalDataSource());
  }

  final SharedPreferences prefs;
  late final AuthRepository authRepository;
  late final PlacesRepository placesRepository;

  /// Seeds local data (demo account, sample places) before the first frame.
  Future<void> initialize() => authRepository.initialize();
}

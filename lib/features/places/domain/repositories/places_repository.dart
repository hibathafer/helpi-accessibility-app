import '../entities/place.dart';

/// Contract the map and details screens depend on. The MVP ships a local
/// data source; a places API can be swapped in without touching the bloc.
abstract class PlacesRepository {
  Future<List<Place>> getPlaces();

  /// Persists a community-contributed place and returns the stored entity.
  Future<Place> addPlace(Place place);
}

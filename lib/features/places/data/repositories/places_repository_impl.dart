import '../../domain/entities/place.dart';
import '../../domain/repositories/places_repository.dart';
import '../datasources/places_local_data_source.dart';

class PlacesRepositoryImpl implements PlacesRepository {
  PlacesRepositoryImpl(this._dataSource);

  final PlacesLocalDataSource _dataSource;

  @override
  Future<List<Place>> getPlaces() => _dataSource.fetchPlaces();

  @override
  Future<Place> addPlace(Place place) => _dataSource.insert(place);
}

import '../entities/place.dart';
import '../repositories/places_repository.dart';

class AddPlace {
  const AddPlace(this._repository);

  final PlacesRepository _repository;

  Future<Place> call(Place place) => _repository.addPlace(place);
}

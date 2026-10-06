import '../entities/place.dart';
import '../repositories/places_repository.dart';

class GetPlaces {
  const GetPlaces(this._repository);

  final PlacesRepository _repository;

  Future<List<Place>> call() => _repository.getPlaces();
}

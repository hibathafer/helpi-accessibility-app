import '../../domain/entities/place.dart';
import '../../domain/entities/place_category.dart';
import '../models/place_model.dart';

/// Initial destination dataset for the MVP. Coordinates identify the named
/// attractions; accessibility features are intentionally left unverified.
class PlacesLocalDataSource {
  final List<PlaceModel> _places = List<PlaceModel>.of(_seed);

  static const List<PlaceModel> _seed = <PlaceModel>[
    PlaceModel(
      id: 'sagrada-familia',
      name: 'Sagrada Família',
      category: PlaceCategory.attraction,
      address: 'Barcelona, Spain',
      latitude: 41.4036,
      longitude: 2.1744,
    ),
    PlaceModel(
      id: 'park-guell',
      name: 'Park Güell',
      category: PlaceCategory.park,
      address: 'Barcelona, Spain',
      latitude: 41.4145,
      longitude: 2.1527,
    ),
    PlaceModel(
      id: 'schonbrunn-palace',
      name: 'Schönbrunn Palace',
      category: PlaceCategory.palace,
      address: 'Vienna, Austria',
      latitude: 48.1845,
      longitude: 16.3122,
    ),
    PlaceModel(
      id: 'belvedere-palace',
      name: 'Belvedere Palace',
      category: PlaceCategory.palace,
      address: 'Vienna, Austria',
      latitude: 48.1915,
      longitude: 16.3808,
    ),
    PlaceModel(
      id: 'walt-disney-world',
      name: 'Walt Disney World Resort',
      category: PlaceCategory.themePark,
      address: 'Lake Buena Vista, Florida, USA',
      latitude: 28.3852,
      longitude: -81.5639,
    ),
    PlaceModel(
      id: 'disneyland-california',
      name: 'Disneyland Resort',
      category: PlaceCategory.themePark,
      address: 'Anaheim, California, USA',
      latitude: 33.8121,
      longitude: -117.9190,
    ),
    PlaceModel(
      id: 'universal-orlando',
      name: 'Universal Orlando Resort',
      category: PlaceCategory.themePark,
      address: 'Orlando, Florida, USA',
      latitude: 28.4744,
      longitude: -81.4682,
    ),
    PlaceModel(
      id: 'marina-bay-sands',
      name: 'Marina Bay Sands',
      category: PlaceCategory.landmark,
      address: 'Marina Bay, Singapore',
      latitude: 1.2834,
      longitude: 103.8607,
    ),
    PlaceModel(
      id: 'gardens-by-the-bay',
      name: 'Gardens by the Bay',
      category: PlaceCategory.park,
      address: 'Marina Bay, Singapore',
      latitude: 1.2816,
      longitude: 103.8636,
    ),
    PlaceModel(
      id: 'sydney-opera-house',
      name: 'Sydney Opera House',
      category: PlaceCategory.landmark,
      address: 'Sydney, Australia',
      latitude: -33.8568,
      longitude: 151.2153,
    ),
  ];

  /// Simulated latency so loading states are visible.
  Future<List<PlaceModel>> fetchPlaces() async {
    await Future<void>.delayed(const Duration(milliseconds: 450));
    return List<PlaceModel>.unmodifiable(_places);
  }

  Future<PlaceModel> insert(Place place) async {
    await Future<void>.delayed(const Duration(milliseconds: 350));
    final model = PlaceModel.fromPlace(place);
    _places.insert(0, model);
    return model;
  }
}

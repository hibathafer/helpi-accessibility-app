import 'package:equatable/equatable.dart';

import '../../domain/entities/place.dart';
import '../../domain/entities/place_category.dart';

enum PlacesStatus { initial, loading, ready, failure }

class PlacesState extends Equatable {
  const PlacesState({
    this.status = PlacesStatus.initial,
    this.places = const <Place>[],
    this.query = '',
    this.category = PlaceCategory.all,
    this.lastAddedPlaceId,
  });

  final PlacesStatus status;
  final List<Place> places;

  /// Free-text search, kept as raw user input.
  final String query;
  final PlaceCategory category;

  /// Set after a successful community contribution so the add-place screen
  /// can confirm the round trip.
  final String? lastAddedPlaceId;

  bool get isReady => status == PlacesStatus.ready;

  bool get hasActiveFilter =>
      query.trim().isNotEmpty || category != PlaceCategory.all;

  /// Single source of truth for what the map markers, the result list and the
  /// empty state should render — filtering never mutates [places].
  List<Place> get visiblePlaces {
    final needle = query.trim().toLowerCase();
    return places.where((place) {
      final matchesCategory =
          category == PlaceCategory.all || place.category == category;
      if (!matchesCategory) return false;
      if (needle.isEmpty) return true;
      return place.name.toLowerCase().contains(needle) ||
          place.address.toLowerCase().contains(needle);
    }).toList(growable: false);
  }

  PlacesState copyWith({
    PlacesStatus? status,
    List<Place>? places,
    String? query,
    PlaceCategory? category,
    String? lastAddedPlaceId,
  }) {
    return PlacesState(
      status: status ?? this.status,
      places: places ?? this.places,
      query: query ?? this.query,
      category: category ?? this.category,
      lastAddedPlaceId: lastAddedPlaceId ?? this.lastAddedPlaceId,
    );
  }

  @override
  List<Object?> get props =>
      [status, places, query, category, lastAddedPlaceId];
}

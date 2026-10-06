import 'package:equatable/equatable.dart';

import '../../domain/entities/place.dart';
import '../../domain/entities/place_category.dart';

sealed class PlacesEvent extends Equatable {
  const PlacesEvent();

  @override
  List<Object?> get props => [];
}

final class PlacesLoadRequested extends PlacesEvent {
  const PlacesLoadRequested();
}

final class PlacesSearchChanged extends PlacesEvent {
  const PlacesSearchChanged(this.query);

  final String query;

  @override
  List<Object?> get props => [query];
}

final class PlacesCategoryChanged extends PlacesEvent {
  const PlacesCategoryChanged(this.category);

  final PlaceCategory category;

  @override
  List<Object?> get props => [category];
}

final class PlaceAdded extends PlacesEvent {
  const PlaceAdded(this.place);

  final Place place;

  @override
  List<Object?> get props => [place];
}

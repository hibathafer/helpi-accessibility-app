import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/add_place.dart';
import '../../domain/usecases/get_places.dart';
import 'places_event.dart';
import 'places_state.dart';

export 'places_event.dart';
export 'places_state.dart';

/// Owns place loading, search, category filtering and community additions.
class PlacesBloc extends Bloc<PlacesEvent, PlacesState> {
  PlacesBloc({required this.getPlaces, required this.addPlace})
      : super(const PlacesState()) {
    on<PlacesLoadRequested>(_onLoad);
    on<PlacesSearchChanged>(_onSearch);
    on<PlacesCategoryChanged>(_onCategory);
    on<PlaceAdded>(_onPlaceAdded);
  }

  final GetPlaces getPlaces;
  final AddPlace addPlace;

  Future<void> _onLoad(
    PlacesLoadRequested event,
    Emitter<PlacesState> emit,
  ) async {
    emit(const PlacesState(status: PlacesStatus.loading));
    try {
      final places = await getPlaces();
      emit(PlacesState(status: PlacesStatus.ready, places: places));
    } catch (_) {
      emit(const PlacesState(status: PlacesStatus.failure));
    }
  }

  void _onSearch(
    PlacesSearchChanged event,
    Emitter<PlacesState> emit,
  ) {
    emit(state.copyWith(query: event.query));
  }

  void _onCategory(
    PlacesCategoryChanged event,
    Emitter<PlacesState> emit,
  ) {
    emit(state.copyWith(category: event.category));
  }

  Future<void> _onPlaceAdded(
    PlaceAdded event,
    Emitter<PlacesState> emit,
  ) async {
    emit(state.copyWith(status: PlacesStatus.loading));
    try {
      final saved = await addPlace(event.place);
      emit(PlacesState(
        status: PlacesStatus.ready,
        places: [saved, ...state.places],
        query: state.query,
        category: state.category,
        lastAddedPlaceId: saved.id,
      ));
    } catch (_) {
      emit(state.copyWith(status: PlacesStatus.failure));
    }
  }
}

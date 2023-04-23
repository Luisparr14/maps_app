part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class OnToggleManualMarker extends SearchEvent {
  final bool activate;

  const OnToggleManualMarker(this.activate);
}

class OnNewPlacesFound extends SearchEvent {
  final List<Feature> newPlaces;

  const OnNewPlacesFound(this.newPlaces);
}

class OnAddNewElementToHistory extends SearchEvent {
  final Feature newElement;

  const OnAddNewElementToHistory(this.newElement);
}

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

part of 'map_bloc.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class OnMapInitialized extends MapEvent {
  final GoogleMapController mapController;

  const OnMapInitialized(this.mapController);
}

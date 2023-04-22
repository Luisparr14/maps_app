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

class OnToggleFollowUser extends MapEvent {
  final bool followUser;

  const OnToggleFollowUser(this.followUser);
}

class OnUpdatePolylinesTrace extends MapEvent {
  final List<LatLng> userLocations;

  const OnUpdatePolylinesTrace(this.userLocations);
}

class OnToggleShowMyRoute extends MapEvent {}

class TraceRouteStartToEnd extends MapEvent {
  final Map<String, Polyline> polylines;

  const TraceRouteStartToEnd(this.polylines);
  
}

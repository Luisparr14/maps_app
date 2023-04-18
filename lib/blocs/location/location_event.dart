part of 'location_bloc.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

class OnNewUserLocation extends LocationEvent {
  final LatLng newLocation;

  const OnNewUserLocation(this.newLocation);
}

class OnFollowUser extends LocationEvent {
  final bool followUser;

  const OnFollowUser({required this.followUser});
}

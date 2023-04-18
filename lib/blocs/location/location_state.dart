part of 'location_bloc.dart';

class LocationState extends Equatable {
  final bool followingUser;
  final LatLng? lastLocation;
  final List<LatLng> locationHistory;

  const LocationState({
      this.followingUser = false,
      this.lastLocation,
      locationHistory,
    }) : locationHistory = locationHistory ?? const [];

  LocationState copyWith(
          {bool? followingUser,
          LatLng? lastLocation,
          List<LatLng>? locationHistory}) =>
      LocationState(
          followingUser: followingUser ?? this.followingUser,
          lastLocation: lastLocation ?? this.lastLocation,
          locationHistory: locationHistory ?? this.locationHistory);

  @override
  List<Object?> get props => [followingUser, lastLocation, locationHistory];
}

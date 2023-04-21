part of 'map_bloc.dart';

class MapState extends Equatable {
  final bool isMapInitialized;
  final bool isFollowingUser;
  final bool showMyRoute;
  final Map<String, Polyline> polylines;

  const MapState(
      {this.isMapInitialized = false,
      this.isFollowingUser = true,
      this.showMyRoute = true,
      this.polylines = const {}});

  MapState copyWith(
          {bool? isMapInitialized,
          bool? isFollowingUser,
          bool? showMyRoute,
          Map<String, Polyline>? polylines}) =>
      MapState(
          isFollowingUser: isFollowingUser ?? this.isFollowingUser,
          isMapInitialized: isMapInitialized ?? this.isMapInitialized,
          showMyRoute: showMyRoute ?? this.showMyRoute,
          polylines: polylines ?? this.polylines);

  @override
  List<Object> get props => [isMapInitialized, isFollowingUser, polylines, showMyRoute];
}

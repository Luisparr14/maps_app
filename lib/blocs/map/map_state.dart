part of 'map_bloc.dart';

class MapState extends Equatable {
  final bool isMapInitialized;
  final bool isFollowingUser;

  const MapState({
    this.isMapInitialized = false,
    this.isFollowingUser = true,
  });

  MapState copyWith({
    bool? isMapInitialized,
    bool? isFollowingUser,
  }) =>
      MapState(
          isFollowingUser: isFollowingUser ?? this.isFollowingUser,
          isMapInitialized: isMapInitialized ?? this.isMapInitialized);

  @override
  List<Object> get props => [isMapInitialized, isFollowingUser];
}

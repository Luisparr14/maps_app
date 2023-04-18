// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  StreamSubscription<Position>? _positionSubscription;

  LocationBloc() : super(const LocationState()) {
    on<OnNewUserLocation>((event, emit) {
      emit(state.copyWith(
          lastLocation: event.newLocation,
          locationHistory: [...state.locationHistory, event.newLocation]));
    });

    on<OnFollowUser>(
        (event, emit) => state.copyWith(followingUser: event.followUser));
  }

  Future getCurrentPosition() async {
    final position = await Geolocator.getCurrentPosition();
    add(OnNewUserLocation(LatLng(position.latitude, position.longitude)));
    return LatLng(position.longitude, position.latitude);
  }

  void startFollowingUser() {
    add(const OnFollowUser(followUser: true));
    _positionSubscription =
        Geolocator.getPositionStream().listen((Position position) {
      print('follow');
      add(OnNewUserLocation(LatLng(position.latitude, position.longitude)));
    });
  }

  void stopFollowingUser() {
    add(const OnFollowUser(followUser: false));
    _positionSubscription?.cancel();
  }

  @override
  Future<void> close() {
    stopFollowingUser();
    return super.close();
  }
}

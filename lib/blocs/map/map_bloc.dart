import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/models/models.dart';
import 'package:maps_app/themes/themes.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final LocationBloc locationBloc;
  GoogleMapController? mapCtrl;
  LatLng? mapCenter;
  StreamSubscription<LocationState>? locationSubscription;

  MapBloc({required this.locationBloc}) : super(const MapState()) {
    on<OnMapInitialized>(_onInitMap);
    on<OnToggleFollowUser>(_onToggleFollowUser);
    on<OnUpdatePolylinesTrace>(_tracePolyline);
    on<OnToggleShowMyRoute>(
        (event, emit) => emit(state.copyWith(showMyRoute: !state.showMyRoute)));
    on<TraceRouteStartToEnd>(
        (event, emit) => emit(state.copyWith(polylines: event.polylines)));

    locationSubscription = locationBloc.stream.listen((locationState) {
      if (locationState.lastLocation != null) {
        add(OnUpdatePolylinesTrace(locationState.locationHistory));
      }
      if (!state.isFollowingUser) return;
      if (locationState.lastLocation == null) return;

      moveCamera(locationState.lastLocation!);
    });
  }

  void _onInitMap(OnMapInitialized event, Emitter<MapState> emit) {
    mapCtrl = event.mapController;
    mapCtrl!.setMapStyle(jsonEncode(watchDogsTheme));
    emit(state.copyWith(isMapInitialized: true));
  }

  void _onToggleFollowUser(OnToggleFollowUser event, Emitter<MapState> emit) {
    emit(state.copyWith(isFollowingUser: event.followUser));
    if (locationBloc.state.lastLocation == null) return;
    if (event.followUser) {
      moveCamera(locationBloc.state.lastLocation!);
    }
  }

  void _tracePolyline(OnUpdatePolylinesTrace event, Emitter<MapState> emit) {
    final currentPolyline = Map<String, Polyline>.from(state.polylines);
    final myRoute = Polyline(
      polylineId: const PolylineId('myRoute'),
      color: Colors.blue.shade400,
      width: 6,
      endCap: Cap.roundCap,
      startCap: Cap.buttCap,
      points: event.userLocations,
    );

    currentPolyline['myRoute'] = myRoute;

    emit(state.copyWith(polylines: currentPolyline));
  }

  void traceRouteStartToEnd(RouteDestination destination) {
    final currentPolyline = Map<String, Polyline>.from(state.polylines);
    final myRoute = Polyline(
      polylineId: const PolylineId('RouteStartToEnd'),
      color: Colors.blue.shade400,
      width: 4,
      endCap: Cap.roundCap,
      startCap: Cap.roundCap,
      points: destination.points,
    );

    currentPolyline['RouteStartToEnd'] = myRoute;

    add(TraceRouteStartToEnd(currentPolyline));
  }

  void moveCamera(LatLng newPosition) {
    final cameraUpdate = CameraUpdate.newLatLngZoom(newPosition, 16);
    mapCtrl?.animateCamera(cameraUpdate);
  }

  @override
  Future<void> close() {
    locationSubscription?.cancel();
    return super.close();
  }
}

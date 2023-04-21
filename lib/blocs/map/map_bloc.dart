import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/themes/themes.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final LocationBloc locationBloc;
  GoogleMapController? mapCtrl;

  MapBloc({required this.locationBloc}) : super(const MapState()) {
    on<OnMapInitialized>(_onInitMap);
    locationBloc.stream.listen((locationState) {
      if (!state.isFollowingUser) return;
      if (locationBloc.state.lastLocation == null) return;

      moveCamera(locationBloc.state.lastLocation!);
    });
  }

  void _onInitMap(OnMapInitialized event, Emitter<MapState> emit) {
    mapCtrl = event.mapController;
    mapCtrl!.setMapStyle(jsonEncode(watchDogsTheme));
    emit(state.copyWith(isMapInitialized: true));
  }

  void moveCamera(LatLng newPosition) {
    final cameraUpdate = CameraUpdate.newLatLngZoom(newPosition, 20);
    mapCtrl?.animateCamera(cameraUpdate);
  }
}

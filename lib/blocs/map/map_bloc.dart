import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/themes/themes.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  GoogleMapController? mapCtrl;

  MapBloc() : super(const MapState()) {
    on<OnMapInitialized>(_onInitMap);
  }

  void _onInitMap(OnMapInitialized event, Emitter<MapState> emit) {
    mapCtrl = event.mapController;
    mapCtrl!.setMapStyle(jsonEncode(watchDogsTheme));
    emit(state.copyWith(isMapInitialized: true));
  }
}

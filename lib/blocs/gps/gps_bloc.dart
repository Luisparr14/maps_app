import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

part 'gps_event.dart';
part 'gps_state.dart';

class GpsBloc extends Bloc<GpsEvent, GpsState> {
  StreamSubscription? gpsStreamSubscription;

  GpsBloc()
      : super(
            const GpsState(isGpsEnable: false, isGpsPermissionGranted: false)) {
    on<GpsAndPermissions>((event, emit) {
      emit(state.copyWith(
          isGpsEnable: event.isGpsEnable,
          isGpsPermissionGranted: event.isGpsPermissionGranted));
    });

    _init();
  }

  Future<void> _init() async {
    _checkLocationStatus();
  }

  Future<bool> _checkLocationStatus() async {
    var isLocationEnable = await Geolocator.isLocationServiceEnabled();
    add(GpsAndPermissions(
        isGpsEnable: isLocationEnable,
        isGpsPermissionGranted: state.isGpsPermissionGranted));
    gpsStreamSubscription = Geolocator.getServiceStatusStream().listen((event) {
      isLocationEnable = (event.index == 1) ? true : false;
      add(GpsAndPermissions(
          isGpsEnable: isLocationEnable,
          isGpsPermissionGranted: state.isGpsPermissionGranted));
    });
    return isLocationEnable;
  }

  @override
  Future<void> close() {
    gpsStreamSubscription?.cancel();
    return super.close();
  }
}

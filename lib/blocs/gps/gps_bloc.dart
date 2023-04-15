import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

part 'gps_event.dart';
part 'gps_state.dart';

class GpsBloc extends Bloc<GpsEvent, GpsState> {
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
    final isLocationEnable = await Geolocator.isLocationServiceEnabled();
    Geolocator.getServiceStatusStream().listen((event) {
      // TODO: Fire events
    });
    return isLocationEnable;
  }

  @override
  Future<void> close() {
    // TODO: Clean Service Status Listener
    return super.close();
  }
}

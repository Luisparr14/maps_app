part of 'gps_bloc.dart';

abstract class GpsEvent extends Equatable {
  const GpsEvent();

  @override
  List<Object> get props => [];
}

class GpsAndPermissions extends GpsEvent {
  final bool isGpsEnable;
  final bool isGpsPermissionGranted;

  const GpsAndPermissions(
      {required this.isGpsEnable, required this.isGpsPermissionGranted});
}

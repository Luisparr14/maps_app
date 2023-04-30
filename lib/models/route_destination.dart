import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/models/models.dart';

class RouteDestination {
  final List<LatLng> points;
  final double distance;
  final double duration;
  final Feature endPlaceInfo;

  RouteDestination(
      {required this.points,
      required this.distance,
      required this.duration,
      required this.endPlaceInfo});
}

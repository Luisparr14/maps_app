import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:google_polyline_algorithm/google_polyline_algorithm.dart';
import 'package:maps_app/models/models.dart';
import 'package:maps_app/services/services.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final MapBoxService trafficService;

  SearchBloc({required this.trafficService}) : super(const SearchState()) {
    on<SearchEvent>((event, emit) {});
    on<OnToggleManualMarker>((event, emit) =>
        emit(state.copyWith(displayManualMarker: event.activate)));
  }

  Future<RouteDestination> getCoordsStartToEnd(LatLng start, LatLng end) async {
    final trafficResponse =
        await trafficService.getCoordsStartToEnd(start, end);
    final distance = trafficResponse.routes[0].distance;
    final duration = trafficResponse.routes[0].duration;
    final geometry = trafficResponse.routes[0].geometry;
    final points = decodePolyline(geometry, accuracyExponent: 6);

    final latLngList = points
        .map((coords) => LatLng(coords[0].toDouble(), coords[1].toDouble()))
        .toList();

    return RouteDestination(
        points: latLngList, distance: distance, duration: duration);
  }

  Future getFeaturesByQuery(LatLng proximity, String query) async {
    trafficService.getResultsByQuery(proximity, query);
  }
}

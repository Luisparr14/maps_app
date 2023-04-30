import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:maps_app/models/models.dart';
import 'package:maps_app/services/places_interceptor.dart';
import 'package:maps_app/services/services.dart';

class MapBoxService {
  final Dio _dioTraffic;
  final Dio _dioPlaces;
  final String _trafficBaseUrl = 'https://api.mapbox.com/directions/v5/mapbox';
  final String _placesBaseUrl =
      'https://api.mapbox.com/geocoding/v5/mapbox.places';

  MapBoxService()
      : _dioTraffic = Dio()..interceptors.add(TrafficInterceptor()),
        _dioPlaces = Dio()..interceptors.add(PlacesInterceptor());

  Future<TrafficResponse> getCoordsStartToEnd(LatLng start, LatLng end) async {
    final coorsString =
        '${start.longitude}, ${start.latitude};${end.longitude},${end.latitude}';
    final url = '$_trafficBaseUrl/driving/$coorsString';

    final res = await _dioTraffic.get(url);

    final data = TrafficResponse.fromJson(res.data);

    return data;
  }

  Future<List<Feature>> getResultsByQuery(
      LatLng proximity, String query) async {
    final proximityParam = '${proximity.longitude},${proximity.latitude}';
    if (query.isEmpty) return [];
    final url = '$_placesBaseUrl/$query.json';
    final res = await _dioPlaces
        .get(url, queryParameters: {'proximity': proximityParam, 'limit': 7});

    final placesResponse = PlacesResponse.fromJson(res.data);

    return placesResponse.features;
  }

  Future<Feature> getResultByCoodrs(LatLng proximity) async {
    final proximityParam = '${proximity.longitude},${proximity.latitude}';
    final url = '$_placesBaseUrl/$proximityParam.json';
    final res = await _dioPlaces.get(url, queryParameters: {'limit': 1});

    final placesResponse = PlacesResponse.fromJson(res.data);

    return placesResponse.features[0];
  }
}

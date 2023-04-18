import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatelessWidget {
  final LatLng initialLcoation;
  const MapView({super.key, required this.initialLcoation});

  @override
  Widget build(BuildContext context) {
    final CameraPosition initialCameraPosition =
        CameraPosition(target: initialLcoation, zoom: 15);

    return GoogleMap(initialCameraPosition: initialCameraPosition, myLocationEnabled: true,);
  }
}
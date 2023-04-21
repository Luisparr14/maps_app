import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/blocs/map/map_bloc.dart';

class MapView extends StatelessWidget {
  final LatLng initialLcoation;
  const MapView({super.key, required this.initialLcoation});

  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);
    final CameraPosition initialCameraPosition =
        CameraPosition(target: initialLcoation, zoom: 15);

    final size = MediaQuery.of(context).size;

    return SizedBox(
        height: size.height,
        width: size.width,
        child: Listener(
          onPointerDown: (event) => (mapBloc.add(const OnToggleFollowUser(false))),
          child: GoogleMap(
            onMapCreated: (controller) =>
                mapBloc.add(OnMapInitialized(controller)),
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            initialCameraPosition: initialCameraPosition,
            myLocationEnabled: true,
          ),
        ));
  }
}

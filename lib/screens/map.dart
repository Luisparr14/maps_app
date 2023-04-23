import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/views/views.dart';
import 'package:maps_app/widgets/widgets.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late LocationBloc locationBloc = BlocProvider.of<LocationBloc>(context);

  @override
  void initState() {
    super.initState();
    final GpsBloc gpsBloc = BlocProvider.of<GpsBloc>(context);
    if (gpsBloc.state.isAllGranted) {
      locationBloc.startFollowingUser();
    }
  }

  @override
  void dispose() {
    super.dispose();
    // locationBloc.stopFollowingUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LocationBloc, LocationState>(
          builder: (context, locationState) {
        if (locationState.lastLocation == null) {
          return const Center(child: Text('Please, wait'));
        }
        return BlocBuilder<MapBloc, MapState>(
          builder: (context, state) {
            Map<String, Polyline> myPolylines = Map.from(state.polylines);
            Map<String, Marker> myMarkers = Map.from(state.markers);
            if (!state.showMyRoute) {
              myPolylines.removeWhere((key, value) => key == 'myRoute');
            }

            return SingleChildScrollView(
              child: Stack(
                children: [
                  MapView(
                    initialLcoation: locationState.lastLocation!,
                    polylines: myPolylines.values.toSet(),
                    markers: myMarkers.values.toSet(),
                  ),
                  const CustomSearchBar(),
                  const ManualMarker()
                ],
              ),
            );
          },
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: const Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ToggleShowMyRouteBtn(),
          FollowUserButton(),
          CurrentLocationBtn()
        ],
      ),
    );
  }
}

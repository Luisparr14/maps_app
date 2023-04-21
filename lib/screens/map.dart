import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            return SingleChildScrollView(
              child: Stack(
                children: [
                  MapView(
                    initialLcoation: locationState.lastLocation!,
                    polylines: state.polylines.values.toSet(),
                  )
                ],
              ),
            );
          },
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: const Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [FollowUserButton(), CurrentLocationBtn()],
      ),
    );
  }
}

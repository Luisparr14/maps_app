import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/blocs/blocs.dart';

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
    return const Scaffold(
      body: Center(child: Text('MapScreen')),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/blocs/gps/gps_bloc.dart';
import 'package:maps_app/screens/screens.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: BlocBuilder<GpsBloc, GpsState>(
        builder: (context, state) =>
            state.isAllGranted ? const MapScreen() : const GpsAccessScreen(),
      )),
    );
  }
}

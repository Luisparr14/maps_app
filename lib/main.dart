import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/screens/screens.dart';
import 'package:maps_app/services/services.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (_) => GpsBloc()),
    BlocProvider(create: (_) => LocationBloc()),
    BlocProvider(create: (context) => MapBloc(locationBloc: BlocProvider.of<LocationBloc>(context))),
    BlocProvider(create: (_) => SearchBloc(trafficService: MapBoxService()))
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Maps App',
      home: Scaffold(body: LoadingScreen()),
    );
  }
}

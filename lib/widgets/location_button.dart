import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/blocs/blocs.dart';

class CurrentLocationBtn extends StatelessWidget {
  const CurrentLocationBtn({super.key});

  @override
  Widget build(BuildContext context) {
    final locationBloc = BlocProvider.of<LocationBloc>(context);
    final mapBlock = BlocProvider.of<MapBloc>(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        child: IconButton(
          color: Colors.black,
          icon: const Icon(Icons.my_location_outlined),
          onPressed: () {
            final lastLocation = locationBloc.state.lastLocation;
            if (lastLocation == null) return;
            mapBlock.moveCamera(lastLocation);
          },
        ),
      ),
    );
  }
}

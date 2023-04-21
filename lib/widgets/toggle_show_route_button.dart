import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/blocs/blocs.dart';

class ToggleShowMyRouteBtn extends StatelessWidget {
  const ToggleShowMyRouteBtn({super.key});

  @override
  Widget build(BuildContext context) {
    final mapBlock = BlocProvider.of<MapBloc>(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        child: BlocBuilder<MapBloc, MapState>(
          builder: (context, state) {
            return IconButton(
              color: Colors.black,
              icon: Icon(Icons.more_horiz_rounded,
                  color: state.showMyRoute ? Colors.blue : Colors.black),
              onPressed: () {
                mapBlock.add(OnToggleShowMyRoute());
              },
            );
          },
        ),
      ),
    );
  }
}

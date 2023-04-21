import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/blocs/blocs.dart';

class FollowUserButton extends StatelessWidget {
  const FollowUserButton({super.key});

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
              icon: Icon(state.isFollowingUser ? Icons.directions_run_outlined : Icons.hail,
                  color: state.isFollowingUser ? Colors.blue : Colors.black),
              onPressed: () {
                mapBlock.add(OnToggleFollowUser(!state.isFollowingUser));
              },
            );
          },
        ),
      ),
    );
  }
}

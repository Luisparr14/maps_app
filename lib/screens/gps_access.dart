import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:maps_app/blocs/blocs.dart';

class GpsAccessScreen extends StatelessWidget {
  const GpsAccessScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GpsBloc, GpsState>(
        builder: (context, state) => Center(
            child: state.isGpsEnable
                ? const _EnableGpsAccessButton()
                : const _EnableGpsMessage()),
      ),
    );
  }
}

class _EnableGpsAccessButton extends StatelessWidget {
  const _EnableGpsAccessButton();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('You have to grant us GPS access',
            style: TextStyle(fontSize: 17, color: Colors.black87)),
        MaterialButton(
            color: Colors.black87,
            shape: const StadiumBorder(),
            splashColor: Colors.transparent,
            onPressed: () {
              // TODO: Grant access
            },
            child: const Text('Grant Access',
                style: TextStyle(color: Colors.white)))
      ],
    );
  }
}

class _EnableGpsMessage extends StatelessWidget {
  const _EnableGpsMessage();

  @override
  Widget build(BuildContext context) {
    return const Text('You have to enable GPS',
        style: TextStyle(fontSize: 20, color: Colors.black54));
  }
}

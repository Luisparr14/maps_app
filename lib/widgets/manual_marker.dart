import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class ManualMarker extends StatelessWidget {
  const ManualMarker({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      height: size.height,
      child: Stack(
        children: [
          Center(
            child: Transform.translate(
              offset: const Offset(0, -15),
              child: BounceInDown(child: const Icon(Icons.location_on_rounded, size: 40))
              ),
          )
        ],
      ),
    );
  }
}

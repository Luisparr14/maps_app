import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/blocs/blocs.dart';

class ManualMarker extends StatelessWidget {
  const ManualMarker({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) => state.displayManualMarker ? const _ManualMarkerBody() : const SizedBox()
    );
  }
}

class _ManualMarkerBody extends StatelessWidget {
  const _ManualMarkerBody();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Stack(
        children: [
          const Positioned(top: 40, left: 10, child: _BtnBack()),
          Center(
            child: Transform.translate(
                offset: const Offset(0, -15),
                child: BounceInDown(
                    child: const Icon(Icons.location_on_rounded, size: 40, color: Colors.white))),
          ),
          const Positioned(bottom: 40, left: 40, child: _BtnConfirmLocation()),
        ],
      ),
    );
  }
}

class _BtnConfirmLocation extends StatelessWidget {
  const _BtnConfirmLocation();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return FadeInUp(
      duration: const Duration(milliseconds: 300),
      child: MaterialButton(
          onPressed: () {},
          color: Colors.black87,
          minWidth: size.width - 110,
          height: 40,
          elevation: 1,
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          shape: const StadiumBorder(),
          child: const Text('Confirm Location',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 15))),
    );
  }
}

class _BtnBack extends StatelessWidget {
  const _BtnBack();

  @override
  Widget build(BuildContext context) {
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    return FadeInLeft(
      duration: const Duration(milliseconds: 300),
      child: CircleAvatar(
        backgroundColor: Colors.black87,
        minRadius: 18,
        child: IconButton(
            onPressed: () {
              searchBloc.add(const OnToggleManualMarker(false));
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded)),
      ),
    );
  }
}

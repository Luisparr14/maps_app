import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/delegates/delegates.dart';
import 'package:maps_app/helpers/helpers.dart';
import 'package:maps_app/models/models.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) => state.displayManualMarker
            ? const SizedBox()
            : const _CustomSearchBarBody());
  }
}

class _CustomSearchBarBody extends StatelessWidget {
  const _CustomSearchBarBody();

  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    goBack() => Navigator.pop(context);

    void onSearchResults(SearchResult result) {
      final searchBloc = BlocProvider.of<SearchBloc>(context);
      if (result.manual) {
        searchBloc.add(OnToggleManualMarker(result.manual));
        return;
      }
    }

    void goToPlace(SearchResult result) async {
      if (result.position == null || result.myLocation == null) return;
      showLoadingMessage(context);
      final destination = await searchBloc.getCoordsStartToEnd(
          result.myLocation!, result.position!);
      await mapBloc.traceRouteStartToEnd(destination);
      goBack();
    }

    return FadeInDown(
      duration: const Duration(milliseconds: 500),
      child: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 10),
          width: double.infinity,
          height: 40,
          child: GestureDetector(
            onTap: () async {
              final result = await showSearch(
                  context: context, delegate: SearchDestinationDelegate());
              if (result == null) return;
              onSearchResults(result);
              goToPlace(result);
            },
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(1000),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.white54,
                        blurRadius: 10,
                        offset: Offset(0, 1))
                  ]),
              child: const Text(
                '¿Donde quieres ir?',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

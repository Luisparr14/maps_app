import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/models/models.dart';
import 'package:maps_app/helpers/helpers.dart';

class SearchDestinationDelegate extends SearchDelegate<SearchResult> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.search))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, SearchResult(cancel: true));
        },
        icon: const Icon(Icons.arrow_back_ios));
  }

  @override
  Widget buildResults(BuildContext context) {
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    final proximity = BlocProvider.of<LocationBloc>(context).state.lastLocation;
    searchBloc.getFeaturesByQuery(proximity!, query);

    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        final places = state.places;
        return ListView.separated(
            itemBuilder: (_, index) {
              final place = places[index];

              return ListTile(
                title: Text(place.text),
                subtitle:
                    Text(place.placeName, style: const TextStyle(fontSize: 12)),
                onTap: () {
                  final lng = place.center[0];
                  final lat = place.center[1];
                  final result = SearchResult(
                      cancel: false,
                      position: LatLng(lat, lng),
                      myLocation: proximity,
                      name: place.text,
                      description: place.placeName);
                  close(context, result);
                  searchBloc.add(OnAddNewElementToHistory(place));
                },
              );
            },
            separatorBuilder: (_, index) =>
                const Divider(color: Colors.black87, height: 0),
            itemCount: places.length);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return ListView(
          children: [
            ListTile(
                leading: const Icon(Icons.location_on_rounded),
                title: const Text('Add marker manualy'),
                onTap: () {
                  close(context, SearchResult(cancel: false, manual: true));
                }),
            ...state.history.map((e) => ListTile(
                  title: Text(e.text),
                  subtitle: Text(e.placeName),
                  leading: const Icon(Icons.location_on_rounded),
                ))
          ],
        );
      },
    );
  }
}

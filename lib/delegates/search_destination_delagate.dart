import 'package:flutter/material.dart';

class SearchDestinationDelegate extends SearchDelegate {
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
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back_ios));
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('buildResults');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
        return ListView(
      children: [
        ListTile(
          leading: const Icon(Icons.location_on_rounded),
          title: const Text('Add marker manualyy'),
          onTap: () => print('ontap'),
        )
      ],
    );
  }
}

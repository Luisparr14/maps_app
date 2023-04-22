import 'package:flutter/material.dart';
import 'package:maps_app/delegates/delegates.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        width: double.infinity,
        height: 40,
        child: GestureDetector(
          onTap: () async {
            final result = await showSearch(
                context: context, delegate: SearchDestinationDelegate());

            if (result == null) return;

            print(result);
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
    );
  }
}

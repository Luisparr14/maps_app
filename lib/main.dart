import 'package:flutter/material.dart';
import 'package:maps_app/screens/screens.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Maps App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('App'),
        ),
        body: const LoadingScreen()
      ),
    );
  }
}

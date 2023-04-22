import 'package:flutter/material.dart';

void showLoadingMessage(BuildContext context) {
  showDialog(
      context: context,
      builder:(_) => AlertDialog(
        title: const Text('Please, wait...'),
        content: Container(
          width: 100,
          height: 100,
          child: const Column(
            children: [
              Text('Calculating route'),
              SizedBox(height: 20),
              CircularProgressIndicator()
            ],
          ),
        ),
      ));
}

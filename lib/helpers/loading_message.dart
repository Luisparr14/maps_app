import 'package:flutter/material.dart';

void showLoadingMessage(BuildContext context) {
  showDialog(
      context: context,
      builder:(_) => const AlertDialog(
        title: Text('Please, wait...'),
        content: SizedBox(
          width: 100,
          height: 100,
          child: Column(
            children: [
              Text('Calculating route'),
              SizedBox(height: 20),
              CircularProgressIndicator()
            ],
          ),
        ),
      ));
}

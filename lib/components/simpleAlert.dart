import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SimpleAlert extends StatelessWidget {
  final String title;
  final String? content;
  const SimpleAlert({super.key, required this.title, this.content});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title, style: const TextStyle(fontSize: 28)),
      content: Text(content!, style: const TextStyle(fontSize: 18)),
      actions: [
        FilledButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('Okay'))
      ],
    );
  }
}

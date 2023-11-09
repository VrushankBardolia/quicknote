import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActionAlert extends StatelessWidget {
  final String title;
  final String content;
  final void Function() onTap;
  final String actionText;

  const ActionAlert(
      {super.key,
      required this.title,
      required this.content,
      required this.onTap,
      required this.actionText});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title, style: const TextStyle(fontSize: 28)),
      content: Text(content, style: const TextStyle(fontSize: 18)),
      actions: [
        TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('Cancel', style: TextStyle(fontSize: 16))),
        FilledButton(
            onPressed: onTap,
            child: Text(actionText, style: const TextStyle(fontSize: 16)))
      ],
    );
  }
}

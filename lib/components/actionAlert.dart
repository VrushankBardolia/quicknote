import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActionAlert extends StatelessWidget {
  final String title;
  final String? content;
  final void Function() onTap;
  final String actionText;
  const ActionAlert({super.key, required this.title, this.content, required this.onTap, required this.actionText});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content!),
      actions: [
        TextButton(onPressed: (){Get.back();}, child: const Text('Okay')),
        FilledButton(onPressed: onTap, child: Text(actionText))
      ],
    );
  }
}

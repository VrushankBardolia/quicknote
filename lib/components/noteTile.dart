import 'package:flutter/material.dart';

class NoteTile extends StatelessWidget {
  final String title;
  final String date;
  final void Function() onTap;

  const NoteTile({super.key, required this.title, required this.date, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme= Theme.of(context).colorScheme;
    return ListTile(
      title: Text(title,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w600)),
      subtitle: Text(date,style: const TextStyle(fontSize: 16)),
      tileColor: theme.secondaryContainer,
      textColor: theme.onSecondaryContainer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onTap: onTap,
    );
  }
}

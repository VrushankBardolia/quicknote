import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final Function() onTap;
  final String name;
  const AuthButton({super.key, required this.onTap, required this.name});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
        onPressed: onTap,
        child: Text(name,style: const TextStyle(fontSize: 18),)
    );
  }
}

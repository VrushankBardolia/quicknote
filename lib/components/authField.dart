import 'package:flutter/material.dart';

class AuthField extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final Icon icon;
  final bool password;
  final TextInputType textType;
  const AuthField({super.key, required this.controller, required this.hint, required this.icon, required this.password, required this.textType});

  @override
  State<AuthField> createState() => _AuthFieldState();
}

class _AuthFieldState extends State<AuthField> {
  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:6),
      child: TextField(
        controller: widget.controller,
        decoration: InputDecoration(
          prefixIcon: widget.icon,
          hintText: widget.hint,
          filled: true,
          fillColor: theme.secondaryContainer,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.transparent)
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: theme.primary)
          ),
        ),
        obscureText: widget.password,
        keyboardType: widget.textType,
      ),
    );
  }
}
